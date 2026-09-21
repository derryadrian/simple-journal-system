# Role Management — Update Implementasi & Audit

> Dokumen ini adalah catatan perkembangan terbaru (**angka rilis 4**) setelah `ROLE_MANAGEMENT_PROGRESS.md`.
> Tujuannya mencatat apa yang sudah dikerjakan, hasil audit read-only, status blocker, dan langkah berikutnya.
>
> **Prinsip:** semua audit di bawah dilakukan **read-only** — tidak ada migration, ALTER TABLE, atau perubahan database/file yang dijalankan kecuali disebutkan eksplisit.

---

## 1. Ringkasan Pekerjaan yang Sudah Dilakukan

| # | Item | Status | Catatan |
|---|---|---|---|
| 1 | Blocker environment `_build` & `file_system` | ✅ Selesai | `_build` dihapus & dibangun ulang; `file_system` berhasil compile; `nmake` tersedia via Visual Studio BuildTools Developer Command Prompt |
| 2 | `SimpleJournalSystemWeb.AuthorLive` | ✅ Dibuat | File baru `lib/simple_journal_system_web/live/author_live.ex` (placeholder minimal) — menghilangkan `UndefinedFunctionError` di `GET /author` |
| 3 | `mix compile` (dev) | ✅ Sukses | Muncul **warning saja** (bukan error), semuanya dari area Authentication/Accounts (Kategori B) |
| 4 | Audit Role Management | ✅ Bersih | `authorization.ex`, helper role, pipeline router role, dan `AuthorLive` **tanpa warning/error** |
| 5 | Audit database & migration (read-only) | ✅ Selesai | Status berikut (lihat bagian 3–5) |
| 6 | Blocker `users_tokens` | ✅ Selesai | Eksekusi Opsi 1 berhasil: `users.user_id` kini `PRIMARY KEY`, migration `create_users_tokens` UP, FK + CASCADE + index terverifikasi (lihat §6b) |
| 7 | Audit read-only warning Kategori B | ✅ Selesai | Root cause teridentifikasi = mismatch API Authentication (Accounts vs web-layer/test). Arah perbaikan disetujui, **belum diimplementasi** (lihat §6c) |

---

## 2. AuthorLive (yang baru dibuat)

- **File:** `lib/simple_journal_system_web/live/author_live.ex`
- **Module:** `SimpleJournalSystemWeb.AuthorLive`
- **Isi:** minimal, `use SimpleJournalSystemWeb, :live_view` + `render/1` dengan `<Layouts.app flash={@flash} current_scope={@current_scope}>`; menampilkan heading "Author Dashboard" dan email user yang login.
- **Tidak menyentuh:** router, pipeline `:author`, Accounts, UserAuth, Authorization, schema, migration, database.
- **Pola:** mengikuti LiveView ter-authentikasi yang sudah ada (`settings.ex`, `confirmation.ex`) — `on_mount :require_authenticated` menjamin `@current_scope.user` tersedia.
- **Catatan UX:** placeholder sementara; fitur Author asli dikerjakan terpisah (sesuai `ROLE_MANAGEMENT_PROGRESS.md` — fokus saat ini Database → Role Mapping → Authorization → Route Protection → Testing).

---

## 3. Hasil Audit Compile

`mix compile` (dev) berhasil dengan **±22 warning, 0 error**. Semua warning dikelompokkan:

### A. Berkaitan langsung dengan Role Management → **0 warning**
Tidak ada warning dari `authorization.ex`, helper `require_*` di `user_auth.ex`, pipeline role router, atau `author_live.ex`.

### B. Authentication bawaan Phoenix/Accounts → **±22 warning (semua di sini)**
Pola "`X is undefined or private`" karena fungsi dipanggil tapi tidak didefinisikan:

| File | Fungsi bermasalah |
|---|---|
| `user_session_controller.ex` | `Accounts.login_user_by_magic_link/1`, `Accounts.sudo_mode?/1`, `Accounts.update_user_password/2` (hanya ada `/3`) |
| `user_live/settings.ex` | `change_user_email/3`, `change_user_password/2 & /3`, `sudo_mode?/1`, `deliver_user_update_email_instructions/3`, type-warning clause `{:error, _}` unreachable (akibat fungsi undefined) |
| `user_live/confirmation.ex` | `Accounts.get_user_by_magic_link_token/1` |
| `accounts.ex` | `User.email_changeset/2`, `User.password_changeset/2`, `User.confirm_changeset/1`, `User.validate_current_password/2`, `UserToken.verify_email_token_query/2`, modul `SimpleJournalSystem.Emails` (belum ada), warning "redundant clause" `get_user_by_session_token/1` (clause integer, baris 60) |

> ⚠️ Warning ini akan mengikat sebagai **error** saat `mix precommit` (memakai `compile --warnings-as-errors`).

### C. Database/migration → **0 warning compile**
### D. Tidak berkaitan dengan Role Management → **0 warning**

---

## 4. Audit Database (read-only) — `ojs_db_pg`

| Item | Nilai |
|---|---|
| Database | `ojs_db_pg` (PostgreSQL 18) |
| Host / Port | `localhost` / `5432` |
| User / Password | `postgres` / env `DB_PASSWORD` (ter-set) |
| Asal tabel `users`, `user_groups`, `user_user_groups` | **Dari OJS existing** — kolom cocok 1:1 dengan schema (terverifikasi via query) |
| Tabel `users_tokens` | **TIDAK ADA** |
| `schema_migrations` | Ada tapi **kosong** → kedua migration berstatus **DOWN** |

### Data OJS yang ada
| Tabel | Baris |
|---|---|
| `users` | 1 |
| `user_groups` | 1 |
| `user_user_groups` | 1 |
| `submissions` | ada (belum dihitung) |

Sample user: **`1 | adminhana | ha.sooofi@gmail.com`** → group 1 → **role_id 1 (Manager)**.
Belum ada user ber-role **Author (256)** untuk menguji `GET /author`.

---

## 5. Audit Migration (read-only) — aman untuk OJS?

### `20260723043341_create_users_auth_tables`
- `change/0` **kosong** (no-op sengaja; komentar: "Tabel users sudah ada dari OJS").
- Efek bila dijalankan: hanya mencatat versi di `schema_migrations`. **100% aman.**

### `20260724044658_create_users_tokens`
Yang akan dibuat bila berhasil:
- **Tabel `users_tokens`**:
  - `user_id` bigint **NOT NULL** — FK → `users.user_id`, `ON DELETE CASCADE`
  - `token` binary **NOT NULL**
  - `context` string **NOT NULL**
  - `sent_to` string (nullable)
  - `authenticated_at` utc_datetime (nullable)
  - `inserted_at` utc_datetime NOT NULL (dari `timestamps(updated_at: false)`)
- **Index:** `(user_id)`, `(context)`, `UNIQUE (token, context)`
- **Tidak** menghapus/mengubah `users`, `user_groups`, `user_user_groups` — hanya CREATE tabel baru + index.

### ⛔ Kendala utama (blocker) — ✅ RESOLVED di rilis 3
Tabel `users` awalnya **tidak punya PRIMARY KEY, UNIQUE constraint, maupun index sama sekali** (hanya 3 constraint `NOT NULL`). PostgreSQL mensyaratkan kolom rujukan FK harus unique → migrasi `create_users_tokens` awalnya **akan gagal** dengan:
```
ERROR: there is no unique constraint matching given keys for referenced table "users"
```
Gagal dengan aman (transaksi rollback), tapi `users_tokens` tidak jadi dibuat.
→ **Status sekarang:** `users.user_id` telah menjadi `PRIMARY KEY` (lihat §6b), sehingga FK di migrasi `users_tokens` valid dan migration berhasil UP.

### Hasil audit detail `users.user_id`
- ✅ Tidak ada duplicate `user_id`
- ✅ Tidak ada `user_id` NULL (0 baris)
- ✅ Tidak ada FK dari tabel lain yang menunjuk `users`
- ✅ Hanya 3 constraint NOT NULL (`users_date_registered_not_null`, `users_disabled_not_null`, `users_user_id_not_null`)
- ✅ 0 index di `users`

---

## 6. Blockers Saat Ini

1. **Database `users_tokens`** — ✅ **SELESAI** (lihat §6b). Tidak lagi blocker.
2. **Auth runtime:** tanpa `users_tokens`, login/session (insert & verify token) akan crash — **resolved** karena `users_tokens` sudah ada. Catatan: alur login masih bergantung pada perbaikan Kategori B (§8.2).
3. **Precommit / Kategori B:** ±22 warning → `mix compile --warnings-as-errors` gagal (exit 1). **Audit selesai**, arah disetujui, **implementasi belum dimulai** (lihat §6c).
4. **Data role:** belum ada user ber-role Author (256) untuk menguji `/author`.
5. **Environment test:** compile `:test` blocked oleh `bcrypt_elixir` (`nmake` hanya tersedia via Developer Command Prompt).

## 6a. Keputusan Blocker `users_tokens` (catatan historis — telah dieksekusi di rilis 3)

Status awal (rilis 2): berhenti di **tahap decision**, sebelum menjalankan `ALTER TABLE` / `mix ecto.migrate`. → **Rilis 3: Opsi 1 disetujui dan dieksekusi (lihat §6b).**

Fakta dari audit read-only:
- `users.user_id` **NOT NULL**, tanpa duplicate, tanpa NULL.
- **Tidak ada** FK dari tabel lain yang mereferensikan `users`.
- `users` **tidak punya PK / UNIQUE / index** sama sekali.
- `create_users_tokens` memanfaatkan `references(:users, column: :user_id, ...)` → PostgreSQL mensyaratkan kolom rujukan FK harus unique.
- `users_tokens` **belum ada** (tabel baru, belum dibuat).

### Dua opsi & konsekuensi

**Opsi 1 — `ALTER TABLE users ADD PRIMARY KEY (user_id)`**
- Membuat `users.user_id` memenuhi syarat FK PostgreSQL → migrasi `create_users_tokens` berhasil; FK + index `(user_id)` + `ON DELETE CASCADE` aktif, token terikat integritas ke `users`.
- Aman secara data: audit membuktikan `user_id` unik, NOT NULL, dan tanpa FK masuk → ALTER tidak konflik/rollback.
- Efek samping: mengubah skema tabel `users` milik OJS. Risiko jangka panjang: bila dump OJS di-import ulang, PK yang kita tambah hilang (dump asli OJS tidak memuatnya) → FK `users_tokens` rusak lagi dan perlu di-ALTER ulang.
- Bonus kecil: index unik pada `user_id` mempercepat join FK `users_tokens → users`.

**Opsi 2 — Mengubah migration `users_tokens` agar tanpa FK ke `users.user_id`**
- `user_id` jadi kolom bigint biasa (+ index opsional, tanpa constraint FK). Migrasi berhasil tanpa menyentuh tabel `users` OJS sama sekali.
- Hilang integritas referensial: DB tidak menjamin `user_id` ada di `users`, dan tanpa CASCADE → token yatim (orphan) bisa menumpuk saat user dihapus dari OJS.
- Wajib mengedit file migration yang sudah ditulis. Karena `schema_migrations` masih kosong (kedua migration DOWN), edit sekarang aman — tidak ada state ter-apply yang bertabrakan.
- Desain relasional kurang bersih, tapi database OJS tetap utuh/asli.

### ✅ Rekomendasi — **Opsi 1**

`ALTER TABLE users ADD PRIMARY KEY (user_id)` paling sesuai untuk Simple Journal System karena:
1. Menjaga integritas relasional yang benar — tabel auth butuh FK berfungsi + cascade delete; token session harus ikut terhapus saat user dihapus.
2. Aman terverifikasi: audit read-only membuktikan kolom unik, not null, tanpa FK masuk → satu ALTER sekali jalan, tanpa konflik.
3. Risiko "menyentuh tabel OJS" terkelola: menambah PK tidak memecah query OJS (hanya menambah constraint), dan akan didokumentasikan sebagai langkah yang perlu diulang jika dump OJS di-import ulang.

Opsi 2 hanya direkomendasikan jika "tabel OJS wajib zero-touch" menjadi syarat keras — trade-off-nya kehilangan FK & CASCADE (token orphan).

## 6b. Eksekusi Opsi 1 — ✅ SELESAI & TERVERIFIKASI

Status: Opsi 1 **disetujui & dieksekusi**. Tidak ada struktur/data OJS lain yang diubah selain penambahan PK pada `users.user_id`. Tidak ada tindakan destructive (DROP/TRUNCATE/DELETE/re-import).

### Audit ulang read-only (sebelum eksekusi)
| Cek | Hasil |
|---|---|
| Database aktif | `ojs_db_pg` (localhost:5432) ✅ |
| `users.user_id` NULL | 0 baris NULL ✅ |
| Duplicate `user_id` | tidak ada (total 1, distinct 1) ✅ |
| PK/UNIQUE/index di `users` | 0 index, hanya 3 constraint NOT NULL ✅ |
| FK dari tabel lain ke `users` | tidak ada ✅ |

### Perintah yang dijalankan
```sql
ALTER TABLE users ADD PRIMARY KEY (user_id);
```
- Output: `ALTER TABLE` — sukses, tanpa transaksi gagal/rollback.

### Verifikasi setelah eksekusi
| Item | Hasil (dicek langsung via psql) |
|---|---|
| PK `users_pkey` | `PRIMARY KEY (user_id)` + `CREATE UNIQUE INDEX users_pkey ... btree (user_id)` ✅ |
| Constraint `users` | 3 NOT NULL + `users_pkey` (p) ✅ |

### `mix ecto.migrate` — sukses
| Migration | Status |
|---|---|
| `20260723043341_create_users_auth_tables` | ✅ UP (tercatat di `schema_migrations`) |
| `20260724044658_create_users_tokens` | ✅ UP — `create table users_tokens` + 3 index |

### Verifikasi langsung ke PostgreSQL
| Item | Hasil |
|---|---|
| Tabel `users_tokens` | ✅ ada (7 kolom: id, user_id, token, context, sent_to, authenticated_at, inserted_at) |
| FK `users_tokens_user_id_fkey` | ✅ `FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE` |
| `ON DELETE CASCADE` | ✅ aktif (dari definisi FK) |
| Index | ✅ `users_tokens_user_id_index` (user_id), `users_tokens_context_index` (context), `users_tokens_token_context_index` UNIQUE (token, context), `users_tokens_pkey` (id) |
| `schema_migrations` | ✅ kedua versi terdaftar: `20260723043341`, `20260724044658` |

### Catatan
- Perubahan ini **hanya** menambah PK pada `users.user_id`. Struktur/data OJS lain (user_groups, user_user_groups, dll) tidak disentuh.
- Migration `users_tokens` **tidak diubah** (FK tetap ke `users.user_id`).
- Risiko yang tercatat di §6a tetap berlaku: bila dump OJS di-import ulang, PK perlu ditambahkan kembali.

## 6c. Audit warning Kategori B (rilis 4) — READ-ONLY, arah disetujui, belum diimplementasi

Status: **analisis read-only selesai.** Tidak ada source code, migration, test, database, maupun dokumentasi yang diubah pada rilis ini.

### Konteks & akar masalah
Blocker aktif saat ini: `mix compile --warnings-as-errors` gagal (exit 1) → ±16 warning unik ≈ ±22 call site, **semua** dari area Authentication/Accounts (Kategori B). Role Management tetap **0 warning**.

Akar masalah **bukan mismatch database/schema** (PK, FK, `users_tokens` semua sudah benar). Masalahnya **campuran empat hal**:
1. **Accounts API tidak sinkron dengan web layer** — router/controller/LiveView ditulis mengikuti template `phx.gen.auth` baru (magic-link, `sudo_mode`, `update_user_password/2` → `{user, expired_tokens}`, `change_user_email/3`, url-builder-fun), sedangkan `Accounts` masih template lama (`change_user_email/2`, `update_user_password/3`, referensi `Emails`).
2. **`User` & `UserToken` tidak sinkron** — schema `User` (kustom OJS, PK `user_id`) kehilangan changeset standar (`email_changeset`, `password_changeset`, `confirm_changeset`, `validate_current_password`); `UserToken` memakai nama fungsi berbeda (`verify_change_email_token_query` vs `verify_email_token_query`).
3. **Sisa fitur Phoenix tidak dipakai/setengah terpasang** — modul `SimpleJournalSystem.Emails` dirujuk tapi tak pernah dibuat (`UserNotifier` yang ada).
4. **Test memakai API yang sama dengan web layer** (baru) — jadi target konsisten = API baru, bukan "kembali ke lama".

### Arah yang disetujui (pending implementasi)
1. **Pertahankan alur magic-link** — jangan hapus/ganti route & test yang bergantung pada `get_user_by_magic_link_token/1`, `login_user_by_magic_link/1`, `User.confirm_changeset/1`, `UserToken.verify_email_token_query/2`.
2. **JANGAN membuat modul `Emails` baru** — ref legacy `SimpleJournalSystem.Emails` didokumentasikan sebagai legacy; email update diarahkan ke `UserNotifier`. Tidak bikin modul baru hanya untuk menutup warning.
3. **Fokus pada sinkronisasi API Authentication yang dipanggil runtime + didukung test.**
4. **Hati-hati terhadap pekerjaan Authentication tim lain** — hindari perubahan besar yang berpotensi menimpa/menduplikasi; zona rawan = `accounts.ex` (session token) & `user_auth.ex` + router scopes.

### Rencana implementasi paling aman (urutan)
| # | Langkah | File |
|---|---|---|
| 1 | Implementasikan changeset `User` yang hilang: `email_changeset/2,3`, `password_changeset/2`, `confirm_changeset/1`, `validate_current_password/2` (pondasi, aditif) | `user.ex` |
| 2 | Lengkapi/selaraskan `UserToken.verify_email_token_query/2` | `user_token.ex` |
| 3 | Sinkronkan `Accounts` ke API web-layer + test: `sudo_mode?/1,2`, `update_user_password/2` (ganti `/3`), `change_user_email/2,3`, `change_user_password/2,3`, perbaiki `update_user_email/2`, `deliver_user_update_email_instructions/3` | `accounts.ex` |
| 4 | Lengkapi magic-link: `get_user_by_magic_link_token/1`, `login_user_by_magic_link/1`, `UserToken.verify_email_token_query/2` | `accounts.ex`, `user_token.ex` |
| 5 | Rapikan legacy: hapus `deliver_user_reset_password_instructions/1` + `reset_user_password/2` (tidak dipakai), arahkan `Emails.*` → `UserNotifier.*`; hapus klausa integer mati `get_user_by_session_token/1`; perbaiki match `{:error,_}` di `settings.ex:79` | `accounts.ex`, `settings.ex` |

> ⚠️ Langkah di atas **belum dieksekusi** — menunggu approval.

### Catatan environment
- Test env compile saat ini **blocked oleh `bcrypt_elixir` (butuh `nmake`)** → verifikasi test penuh harus lewat Visual Studio BuildTools Developer Command Prompt. `mix.precommit` berjalan di `:test` env.

## 7. Non-blockers

- `AuthorLive` ✅ bersih.
- Role Management ✅ bersih (0 warning).
- Baris `HEAD` nyasar di `config/dev.exs:1` (sisa artefak merge, harmless — bukan output compile).
- `Accounts.list_user_groups/1` duplikat & tidak terpakai (kebersihan kode, bukan blocker).

---

## 8. Recommended Next Steps

1. ~~**Eksekusi keputusan Blocker `users_tokens` (Opsi 1)**~~ — ✅ **SELESAI**: `PRIMARY KEY (user_id)` terpasang, `mix ecto.migrate` sukses, `users_tokens` + FK/CASCADE/index terverifikasi (lihat §6b).
2. **Implementasi perbaikan Kategori B** sesuai arah §6c (urutan aman 1–5, menunggu approval) — satu-satunya penyebab `mix compile --warnings-as-errors` gagal.
3. **Tambahkan data role Author (256)** untuk user uji → verifikasi `GET /author` merender placeholder.
4. **Tutup** dengan `mix format` + `mix precommit` (via Developer Command Prompt untuk `nmake`/bcrypt).

---

## 9. Trigger untuk Revisi Dokumen Ini
- ~~Menambah PK/unique pada `users.user_id` (eksekusi Opsi 1 disetujui & dijalankan)~~ — ✅ selesai.
- ~~Berhasil menjalankan `mix ecto.migrate`~~ — ✅ selesai.
- Implementasi Kategori B selesai (0 warning / `mix compile --warnings-as-errors` lolos).
- Verifikasi `GET /author` dengan user Author.
- Diubahnya keputusan blocker `users_tokens` (misal beralih ke Opsi 2) — sudah tidak relevan, Opsi 1 berhasil.
- Ada perubahan pada pekerjaan Authentication tim lain yang mempengaruhi zona API Accounts.