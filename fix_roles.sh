#!/usr/bin/env bash
# Jalankan dari folder project (yang ada mix.exs):  bash fix_roles.sh
cd "$(dirname "$0")" || exit 1
if [ ! -f mix.exs ]; then
  echo "File ini harus ada di folder project (yang ada mix.exs)."
  exit 1
fi

echo "== 1. Tulis ulang roles.ex dengan nomor sesuai database OJS"
cat > lib/simple_journal_system/accounts/roles.ex <<'EOF_ROLES'
defmodule SimpleJournalSystem.Accounts.Roles do
  @moduledoc """
  Konstanta role OJS 3, sesuai isi tabel `user_groups.role_id` di database OJS.

    1        Site Admin
    16       Manager (grup: Journal manager, Journal editor, Production editor)
    17       Sub editor (grup: Section editor, Guest editor)
    4096     Reviewer
    4097     Assistant (grup: Copyeditor, Layout editor, Proofreader, dll.)
    65536    Author (grup: Author, Translator)
    1048576  Reader
    2097152  Subscription manager
  """

  @site_admin 1
  @manager 16
  @sub_editor 17
  @reviewer 4096
  @assistant 4097
  @author 65536
  @reader 1048576
  @subscription_manager 2097152

  @all [
    @site_admin,
    @manager,
    @sub_editor,
    @reviewer,
    @assistant,
    @author,
    @reader,
    @subscription_manager
  ]

  def all, do: @all

  def site_admin, do: @site_admin
  def manager, do: @manager
  def sub_editor, do: @sub_editor
  def reviewer, do: @reviewer
  def assistant, do: @assistant
  def author, do: @author
  def reader, do: @reader
  def subscription_manager, do: @subscription_manager

  # Nama lama, dipertahankan supaya kode yang sudah ada tidak perlu diubah.
  # Di OJS asli, Journal manager, Journal editor, dan Production editor
  # semuanya role 16. Jadi journal_manager dan editor = manager (16).
  def journal_manager, do: @manager
  def editor, do: @manager

  @doc """
  Nama role untuk ditampilkan.
  """
  def name(role_id) do
    case role_id do
      @site_admin -> "Site Admin"
      @manager -> "Manager"
      @sub_editor -> "Section Editor"
      @reviewer -> "Reviewer"
      @assistant -> "Assistant"
      @author -> "Author"
      @reader -> "Reader"
      @subscription_manager -> "Subscription Manager"
      _ -> "Unknown (#{role_id})"
    end
  end

  def valid?(role_id), do: role_id in @all

  @doc """
  Role yang boleh mengakses alur editorial.
  """
  def editorial_roles, do: [@site_admin, @manager, @sub_editor, @reviewer]
end
EOF_ROLES

echo
echo "== Perubahan:"
git --no-pager diff --stat
echo
echo "== Menjalankan test (agak lama)..."
mix test > hasil_test.txt 2>&1
grep -E "tests,|failures|\*\* \(Compile|warning: .*Roles" hasil_test.txt
echo
echo "Selesai. Tempel semua tulisan di atas ke chat."
