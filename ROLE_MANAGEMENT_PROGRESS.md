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
