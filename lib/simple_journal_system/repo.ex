defmodule SimpleJournalSystem.Repo do
  use Ecto.Repo,
    otp_app: :simple_journal_system,
    adapter: Ecto.Adapters.Postgres

  import Ecto.Query, only: [exclude: 2, subquery: 1, limit: 2, offset: 2]

  @doc """
  Pagination sederhana. Mengembalikan {hasil_halaman_ini, total_semua}.
  Opsi: :page (default 1) dan :page_size (default 25).
  """
  def paginate(query, opts \\ []) do
    page = Keyword.get(opts, :page, 1)
    page_size = Keyword.get(opts, :page_size, 25)

    total =
      query
      |> exclude(:order_by)
      |> exclude(:preload)
      |> subquery()
      |> aggregate(:count)

    results =
      query
      |> limit(^page_size)
      |> offset(^((page - 1) * page_size))
      |> all()

    {results, total}
  end
end
