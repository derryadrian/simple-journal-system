# Role Management Progress
## Simple Journal System — OJS Role & Authorization

> Dokumen ini menjadi sumber konteks utama untuk pengembangan Role Management.
>
> Tujuan utamanya adalah menjaga agar developer, Sofi, Gemini, OpenCode, maupun contributor lain memahami:
> - apa yang sedang dibuat,
> - kenapa dibuat,
> - kondisi implementasi saat ini,
> - keputusan teknis yang sudah diambil,
> - apa yang belum selesai,
> - dan langkah berikutnya.
>
> Jangan mengubah struktur database atau bagian fitur lain secara sembarangan tanpa melihat konteks di dokumen ini.

---

# 1. Tujuan Utama

Project ini adalah **Simple Journal System** berbasis Phoenix/Elixir yang dibuat untuk mempelajari dan meniru sebagian workflow Open Journal Systems (OJS).

Fokus pekerjaan saat ini adalah:

> **Role Management / Authorization**

Sistem harus dapat:

1. Mengetahui role yang dimiliki setiap user.
2. Menggunakan `role_id` OJS sebagai identitas role.
3. Menghubungkan:
   - `users`
   - `user_user_groups`
   - `user_groups`
4. Menentukan apakah user boleh mengakses resource tertentu.
5. Melindungi route berdasarkan role.
6. Menjadi dasar untuk pengembangan fitur journal berikutnya.

Untuk sekarang **jangan fokus ke tampilan/UI role**.

Prioritas saat ini adalah:

> Database → Role Mapping → Authorization → Route Protection → Testing

---

# 2. Konteks OJS Role

Role yang digunakan mengikuti struktur role OJS yang sudah ditentukan:

| Role | role_id |
|---|---:|
| Manager | 1 |
| Site Admin | 16 |
| Author | 256 |
| Editor | 512 |
| Reviewer | 4096 |
| Assistant | 8192 |
| Reader | 65536 |

Catatan:

- `Manager` dan `Site Admin` bukan role yang sama.
- `role_id` adalah identifier utama role.
- Satu user **boleh memiliki lebih dari satu role**.
- Oleh karena itu relasi user → role menggunakan tabel `user_user_groups`.
- Jangan mengasumsikan satu user hanya memiliki satu role.

---

# 3. Struktur Relasi Role

Struktur sederhananya:

```text
users
  |
  | user_id
  v
user_user_groups
  |
  | user_group_id
  v
user_groups
  |
  | role_id
  v
OJS Role



````md
## Alur Penentuan Role User

Role user tidak disimpan langsung di tabel `users`.

Relasinya:

```text
users
└── user_id = 2
    username = suneater

        |
        v

user_user_groups
└── user_id = 2
    user_group_id = 3

        |
        v

user_groups
└── user_group_id = 3
    role_id = 256

        |
        v

Author
````

### Cara kerja

1. User login.
2. Sistem mendapatkan `user_id`.
3. Sistem mencari relasi user tersebut di tabel `user_user_groups`.
4. Dari sana sistem mendapatkan `user_group_id`.
5. Sistem mencari data group di tabel `user_groups`.
6. `role_id` dari `user_groups` menentukan role user.
7. Authorization memeriksa apakah `role_id` user sesuai dengan role yang dibutuhkan route.

Contoh:

```text
user_id = 2
        |
        v
user_group_id = 3
        |
        v
role_id = 256
        |
        v
Author
```

Seorang user dapat memiliki lebih dari satu role.

Contoh:

```text
users
user_id = 2

        |
        +------------------------+
        |                        |
        v                        v

user_user_groups         user_user_groups
user_group_id = 3        user_group_id = 5

        |                        |
        v                        v

user_groups              user_groups
role_id = 256            role_id = 4096

        |                        |
        v                        v

Author                   Reviewer
```

Dalam kondisi tersebut:

```elixir
Authorization.get_roles(user)
```

akan menghasilkan:

```elixir
[256, 4096]
```

Kemudian:

```elixir
Authorization.has_role?(user, 256)
# true

Authorization.has_role?(user, 4096)
# true

Authorization.has_role?(user, 512)
# false
```

```

Jadi intinya **nggak usah bikin diagram panjang per role satu-satu**. Justru contoh multiple role di atas lebih penting, karena itu menjelaskan kenapa kita bikin:

- `get_roles/1`
- `has_role?/2`
- `has_any_role?/2`
- `has_all_roles?/2`

Dan ini juga lebih enak buat kita atau OpenCode baca: mereka langsung ngerti struktur role kita tanpa harus lihat tujuh diagram yang sebenarnya polanya sama.

Yang kemarin kamu kirim itu, bagian `users -> user_user_groups -> user_groups -> Author` cukup **sekali sebagai contoh alur dasar**, lalu langsung lanjut ke **contoh satu user punya banyak role**.
```

---

# 🔒 Keputusan Teknis Terkini (DICATAT — BELUM DIEKSEKUSI)

> Status saat ini: **berhenti di tahap decision sebelum ALTER TABLE**. Tidak ada migration, database, maupun source code yang diubah. Detail lengkap di `ROLE_MANAGEMENT_UPDATE.md` §6a.

## Blocker `users_tokens`

- `users_tokens` **belum ada**; migrasi `create_users_tokens` akan gagal karena `references(:users, column: :user_id)` mengharuskan `users.user_id` unique, padahal `users` (tabel OJS existing) **tidak punya PK/UNIQUE/index**.
- Audit read-only membuktikan `users.user_id` **NOT NULL & tanpa duplicate**, dan **tidak ada FK dari tabel lain** yang menunjuk `users` → aman untuk ditambah constraint.

## Keputusan: Opsi 1 — `ALTER TABLE users ADD PRIMARY KEY (user_id)`

**Rekomendasi paling sesuai** untuk project ini karena: integritas FK + `ON DELETE CASCADE` untuk token session, aman secara data (unik & not null, tanpa FK masuk), dan menambah PK tidak memecah query OJS.

- Konsekuensi: mengubah skema tabel `users` milik OJS; wajib diulang bila dump OJS di-import ulang.
- Alternatif (Opsi 2): ubah migration `users_tokens` tanpa FK ke `users` — menjaga tabel OJS zero-touch, tapi kehilangan FK & CASCADE (token orphan).
- **Eksekusi ditunda** hingga ada approval menjalankan migration/ALTER TABLE.

---

# ✅ Eksekusi Opsi 1 — SELESAI (rilis 3)

> Status terbaru: Opsi 1 telah disetujui & dieksekusi. Detail verifikasi lengkap di `ROLE_MANAGEMENT_UPDATE.md` §6b.

## Yang sudah dieksekusi
- `ALTER TABLE users ADD PRIMARY KEY (user_id)` → sukses. `users.user_id` kini `PRIMARY KEY` (constraint `users_pkey` + unique index).
- `mix ecto.migrate` → sukses. Kedua migration **UP**:
  - `20260723043341_create_users_auth_tables`
  - `20260724044658_create_users_tokens`
- Tabel `users_tokens` **ada** (id, user_id, token, context, sent_to, authenticated_at, inserted_at).
- FK `users_tokens_user_id_fkey` → `FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE` ✅.
- Index: `(user_id)`, `(context)`, `UNIQUE (token, context)` ✅ + PK `(id)`.

## Yang TIDAK diubah
- Struktur/data OJS lain (user_groups, user_user_groups, dst) — tidak disentuh.
- Migration `users_tokens` — tidak diubah (FK tetap ke `users.user_id`).
- Source code — tidak ada yang diubah.
- Tidak ada user role Author (256) yang dibuat.

## Status saat ini
- Blocker `users_tokens` — **✅ selesai**.
- Blocker **precommit** — 🟡 masih ada: `mix compile --warnings-as-errors` gagal (exit 1) **hanya** karena ±22 warning Kategori B (Authentication/Accounts) yang sudah diketahui; **tidak ada error baru**.
- Blocker **data role Author** — 🟡 belum ada user ber-role Author (256) untuk menguji `GET /author`.

## Langkah berikutnya
1. **Perbaiki Kategori B** (Authentication/Accounts) — satu-satunya penyebab `mix compile --warnings-as-errors` gagal. Audit & arah sudah disetujui (lihat §6c di `ROLE_MANAGEMENT_UPDATE.md`), **implementasi belum dimulai**.
2. Tambahkan data role Author (256) untuk user uji.
3. Verifikasi `GET /author` → `mix format` + `mix precommit`.

---

# 📋 Audit Warning Kategori B — READ-ONLY (rilis 4)

> Status: **analisis selesai, belum ada perubahan file.** Tidak ada source code/migration/test/database yang diubah. Detail lengkap di `ROLE_MANAGEMENT_UPDATE.md` §6c.

## Ringkasan
- Blocker aktif: `mix compile --warnings-as-errors` gagal (exit 1) karena **±16 warning unik (±22 call site)** di area Authentication/Accounts.
- Role Management tetap **0 warning** — masalah bukan di area Role.
- **Akar masalah:** mismatch API Authentication — `Accounts` masih template `phx.gen.auth` lama, sedangkan router/controller/LiveView **dan test** memakai template baru (magic-link, sudo-mode, `update_user_password/2` `{user, expired_tokens}`). `User` & `UserToken` juga kehilangan/selaras-nama fungsi changeset & token-query. Modul `Emails` dirujuk tapi tak pernah dibuat.

## Keputusan yang sudah disetujui
1. **Pertahankan alur magic-link** (`get_user_by_magic_link_token/1`, `login_user_by_magic_link/1`, `confirm_changeset/1`, `verify_email_token_query/2`).
2. **Jangan buat modul `Emails` baru** — legacy ref diarahkan ke `UserNotifier`.
3. Fokus sinkronisasi API Authentication yang **dipakai runtime + didukung test**.
4. Hindari perubahan besar yang berpotensi menimpa pekerjaan Authentication tim lain.

## File yang akan disentuh (setelah approval)
- `lib/simple_journal_system/accounts/user.ex` — tambah changeset hilang.
- `lib/simple_journal_system/accounts/user_token.ex` — lengkapi `verify_email_token_query/2`.
- `lib/simple_journal_system/accounts.ex` — sinkronkan API + rapikan legacy.
- `lib/simple_journal_system_web/live/user_live/settings.ex` — perbaiki match `{:error,_}` (perubahan kecil).

## Status blocker saat ini
- `users_tokens` / PK — **✅ selesai**.
- Precommit / Kategori B — 🟡 **audit selesai, implementasi menunggu approval**.
- Data role Author (256) — 🟡 belum.
- Test env (`nmake`/bcrypt) — 🟡 hanya via Developer Command Prompt.
