# Progress — Authentication & Authorization Audit

## Summary

Audit dan perbaikan authentication & authorization di project `simple-journal-system` (Phoenix + Ecto + PostgreSQL + OJS schema).

---

## Masalah 1 Selesai — Dead Clause di `get_user_by_session_token/1`

**Lokasi:** `lib/simple_journal_system/accounts.ex`

**Perubahan:** Menghapus klausa kedua yang tidak pernah tercapai:
```elixir
# DIHAPUS:
def get_user_by_session_token(user_id) when is_integer(user_id) do
  Repo.get(User, user_id)
end
```

**Alasan:** Klausa pertama tanpa guard selalu match, membuat klausa kedua dead code. Semua pemanggilan menggunakan token (binary), bukan `user_id`.

---

## Masalah 2 Selesai — Module `Emails` Tidak Ada

**Lokasi:** `lib/simple_journal_system/accounts.ex`, `lib/simple_journal_system/accounts/user_notifier.ex`

**Perubahan:**

1. Menambahkan fungsi publik `deliver_reset_password_instructions/2` di `UserNotifier`
2. Mengubah `deliver_confirmation_instructions/2` dari `defp` ke `def` (public)
3. Mengubah 3 pemanggilan di `accounts.ex`:
   - `SimpleJournalSystem.Emails.deliver_confirmation_instructions` → `SimpleJournalSystem.Accounts.UserNotifier.deliver_confirmation_instructions`
   - `SimpleJournalSystem.Emails.deliver_reset_password_instructions` → `SimpleJournalSystem.Accounts.UserNotifier.deliver_reset_password_instructions`
   - `SimpleJournalSystem.Emails.deliver_update_email_instructions` → `SimpleJournalSystem.Accounts.UserNotifier.deliver_update_email_instructions`

**Alasan:** Module `SimpleJournalSystem.Emails` tidak ada. `UserNotifier` sudah ada dan memiliki sebagian besar fungsi yang dibutuhkan.

---

## Masalah 3 Selesai — 6 Fungsi Hilang di `Accounts`

**Lokasi:** `lib/simple_journal_system/accounts.ex`

**Fungsi yang diimplementasikan:**

| # | Fungsi | Deskripsi |
|---|--------|-----------|
| 1 | `get_user!/1` | Ambil user by ID, raise jika tidak found |
| 2 | `sudo_mode?/2` | Cek apakah user baru saja re-authenticate (default TTL 20 menit) |
| 3 | `get_user_by_magic_link_token/1` | Validasi magic link token, return `User` atau `nil` |
| 4 | `login_user_by_magic_link/1` | Login via magic link, return `{:ok, {user, expired_tokens}}` atau `{:error, :not_found}` |
| 5 | `change_user_password/3` | Return `Ecto.Changeset` untuk password (delegate ke `User.password_changeset/3`) |
| 6 | `update_user_password/2` | Update password + hapus semua token, return `{:ok, {user, expired_tokens}}` |

---

## Masalah 4 — Terhalang (Environment)

**Status:** Belum bisa diverifikasi karena masalah environment

**Detail:**
- Kompilasi gagal karena `bcrypt_elixir` dependency tidak bisa di-build
- Penyebab: `nmake` tidak ditemukan di PATH (Visual Studio 2026 Community terinstall tapi tanpa workload C++)
- PostgreSQL connection timeout — belum bisa verifikasi struktur tabel langsung dari database
- Path proyek mengandung spasi ("Hype GLK") menghasilkan warning pada bcrypt_elixir, bukan error yang menghentikan kompilasi

**Solusi yang disarankan:**
1. Install workload C++ di Visual Studio 2026 Community, atau
2. Install MinGW-w64 dan set `MAKE` environment variable

---

## Files Modified

1. `lib/simple_journal_system/accounts.ex` — Masalah 1, 2, 3
2. `lib/simple_journal_system/accounts/user_notifier.ex` — Masalah 2

## Files Created

1. `PROGRESS.md` — dokumentasi ini

12/10/2026
Senin/Oktober/2026

---

# Sesi Lanjutan — 04/11/2026

## Masalah 5 Selesai — Warning Compile

**Lokasi:** `lib/simple_journal_system/accounts.ex`, `lib/simple_journal_system_web/live/user_live/login.ex`

**Perubahan:**

1. `Accounts.deliver_user_update_email_instructions/3` — sebelumnya mengirim *fungsi* URL ke notifier; sekarang memanggil `url.(encoded_token)` sehingga yang diinterpolasi adalah string URL.
2. `UserLive.Login` — menghapus fungsi `local_mail_adapter?/0` yang tidak terpakai (menyebabkan warning).

**Verifikasi:** `mix compile --warnings-as-errors` bersih setelah perubahan.

---

## Masalah 6 Selesai — Alur Ganti Email (Change Email)

**Lokasi:** `lib/simple_journal_system/accounts.ex`

**Perubahan:**

1. `update_user_email/2` ditulis ulang dengan signature `update_user_email(user, token)`:
   - Dibungkus `Repo.transaction`, kegagalan di-`Repo.rollback({:error, :transaction_aborted})` lalu dipetakan ke `{:error, :transaction_aborted}`.
   - Validasi via `UserToken.verify_change_email_token_query(token, "change:" <> user.email)`.
   - Email baru diambil dari `user_token.sent_to` (bukan dari input user).
   - Token yang sudah dipakai dihapus via `UserToken.by_token_and_context_query/2`.
2. Menghapus `token_context/1` yang sudah tidak terpakai.

**Pemanggil yang diverifikasi:** `user_live/settings.ex:75`, `test/simple_journal_system/accounts_test.exs:149,157,165,175`. Semantik pembuatan token (`settings.ex:121`, setup test `accounts_test.exs:142`) sudah cocok dengan context/`sent_to`.

**Verifikasi:** `mix format --check-formatted lib/simple_journal_system/accounts.ex` OK, `mix compile --warnings-as-errors` OK.

---

## Masalah 7 — Investigasi Alur Konfirmasi Akun (Read-only)

**Lokasi:** `lib/simple_journal_system/accounts.ex`, `lib/simple_journal_system/accounts/user_token.ex`, `lib/simple_journal_system/accounts/user.ex`, `lib/simple_journal_system_web/live/user_live/confirmation.ex`, `lib/simple_journal_system_web/controllers/user_session_controller.ex`, file test terkait.

**Akar masalah yang ditemukan:**

1. `Accounts.deliver_login_instructions/2` tidak membuat/menyimpan token `"login"` dan mengirim fungsi URL ke notifier (`user_notifier.ex:75` menginterpolasi `#{url}`) → `Protocol.UndefinedError`; membuat `user_fixture/1` (setup hampir seluruh test) gagal.
2. `Accounts.confirm_user/1` selalu `:error`: pola `%User{} = user <- Repo.one(query)` tidak cocok karena `UserToken.verify_email_token_query/2` mengembalikan query `UserToken`, bukan `User`. Fungsi ini juga tidak punya pemanggil (begitu juga `deliver_user_confirmation_instructions/1`) dan memakai konstanta masa berlaku yang salah (`@change_email_validity_in_days`).
3. `confirmed_at` adalah field `virtual: true` (`user.ex:24`) dan tidak ada kolomnya di `structure.sql`/migration → tidak pernah tersimpan. Akibatnya Confirmation LiveView selalu menampilkan form konfirmasi, notifier selalu mengirim email konfirmasi, dan `Accounts.get_user!(...).confirmed_at` selalu `nil`.
4. Guard di `accounts.ex:87` (`is_nil(confirmed_at) && hashed_password` → raise) bertentangan dengan test: `accounts_test.exs:333` mengharapkan konfirmasi berhasil untuk fixture yang punya password, sedangkan `accounts_test.exs:353` mengharapkan raise. `user_session_controller_test.exs:95` juga akan 500 dengan guard ini.

---

## Masalah 8 Selesai — Dua Perbaikan Alur Konfirmasi

**Lokasi:** `lib/simple_journal_system/accounts.ex`

**Perubahan:**

1. `deliver_login_instructions/2` (baris ~175):
   - Membuat token `UserToken.build_email_token(user, "login")` dan menyimpannya via `Repo.insert!(user_token)`.
   - Meneruskan `url.(encoded_token)` (string) ke `UserNotifier.deliver_login_instructions/2`.
   - Memperbaiki `Protocol.UndefinedError` dan token yang tidak pernah tersimpan (dibutuhkan `user_fixture/1` dan semua test konfirmasi).
2. `login_user_by_magic_link/1` (baris ~91):
   - Hasil `User.confirm_changeset(user) |> Repo.update!()` sekarang di-bind (`confirmed_user`), bukan dibuang.
   - User yang dikembalikan membawa `confirmed_at` sehingga `{:ok, {user, expired_tokens}}` konsisten dengan test (`accounts_test.exs:341`).

**Catatan teknis:** `confirmed_at` yang `virtual: true` tetap tidak menulis ke database. Berdasarkan `deps/ecto/lib/ecto/repo/schema.ex:584-638`, changeset yang hanya berisi perubahan field virtual akan menghasilkan aksi `:noop` dan tetap mengembalikan struct dengan nilai virtual terisi (tanpa query UPDATE).

**Verifikasi:** `mix format --check-formatted lib/simple_journal_system/accounts.ex` OK, `mix compile --warnings-as-errors` OK.

**Test:** BELUM dijalankan. Alias `test` di `mix.exs` melakukan `ecto.drop --quiet` → `ecto.create` → `ecto.load` → `test`, sehingga tidak dijalankan. `mix precommit` juga tidak dijalankan karena berisi alias `test` tersebut.

---

## Belum Diputuskan — Menunggu Keputusan

1. **Guard magic link** (`accounts.ex:87`): hapus raise (agar konfirmasi via magic link bekerja; `accounts_test.exs:353` disesuaikan) atau pertahankan raise (alur konfirmasi user berpengalaman password rusak dan fixture/test harus diubah).
2. **Persistensi `confirmed_at`**: tambah kolom + migration (butuh persetujuan untuk `mix ecto.migrate`), pakai ulang kolom persisten `date_validated`, atau biarkan virtual untuk sementara.
3. **Dead code konfirmasi**: `confirm_user/1`, `deliver_user_confirmation_instructions/1`, dan `UserToken.verify_email_token_query/2` — dihapus atau diperbaiki.
4. **Bug test**: `Accounts.get_user!(user.id)` di `confirmation_test.exs:64,98` dan `user_session_controller_test.exs:109` harus `user.user_id` (schema memakai primary key `user_id`, field `:id` tidak ada).

---

04/11/2026
Rabu/November/2026