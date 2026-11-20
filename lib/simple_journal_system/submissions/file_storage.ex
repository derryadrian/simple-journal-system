defmodule SimpleJournalSystem.Submissions.FileStorage do
  @moduledoc """
  Penyimpanan file submission secara privat.
  """

  def store(temp_path, submission_id) do
    upload_dir = Application.fetch_env!(:simple_journal_system, :upload_dir)

    filename = "#{Ecto.UUID.generate()}.pdf"
    relative_path = Path.join(["submissions", to_string(submission_id), filename])
    destination = Path.join(upload_dir, relative_path)

    with :ok <- validate_pdf(temp_path),
         :ok <- File.mkdir_p(Path.dirname(destination)),
         :ok <- File.cp(temp_path, destination) do
      {:ok, relative_path}
    end
  end

  def delete(relative_path) do
    upload_dir = Application.fetch_env!(:simple_journal_system, :upload_dir)
    path = Path.expand(relative_path, upload_dir)

    if String.starts_with?(path, Path.expand(upload_dir) <> "/") do
      File.rm(path)
    else
      {:error, :invalid_path}
    end
  end

  defp validate_pdf(path) do
    case File.open(path, [:read, :binary]) do
      {:ok, file} ->
        result =
          case IO.binread(file, 5) do
            "%PDF-" -> :ok
            _ -> {:error, :invalid_pdf}
          end

        File.close(file)
        result

      {:error, reason} ->
        {:error, reason}
    end
  end
end
