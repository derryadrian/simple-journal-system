defmodule SimpleJournalSystemWeb.AuthorLive do
  @moduledoc """
  Halaman awal author untuk memulai submission sesuai alur OJS 3.5.
  """
  use SimpleJournalSystemWeb, :live_view

  import Ecto.Query, warn: false

  alias SimpleJournalSystem.Journals
  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Submissions
  alias SimpleJournalSystem.Submissions.Section

  @impl true
  def mount(_params, _session, socket) do
    journals = Journals.list_enabled_journals()
    selected_journal = List.first(journals)
    selected_locale = selected_journal && selected_journal.primary_locale
    sections = load_sections(selected_journal, selected_locale)
    locales = load_locales(selected_journal)

    {:ok,
     socket
     |> assign(:page_title, "New Submission")
     |> assign(:journals, journals)
     |> assign(:selected_journal_id, selected_journal && to_string(selected_journal.journal_id))
     |> assign(:selected_section_id, sections |> List.first() |> then(&(&1 && to_string(&1.id))))
     |> assign(:selected_locale, selected_locale)
     |> assign(:sections, sections)
     |> assign(:locales, locales)
     |> assign(:started_submission, nil)}
  end

  @impl true
  def handle_event("update_options", params, socket) do
    journal_id = Map.get(params, "journal_id", socket.assigns.selected_journal_id)
    journal = find_enabled_journal(socket.assigns.journals, journal_id)

    if journal do
      locales = load_locales(journal)
      requested_locale = Map.get(params, "locale", socket.assigns.selected_locale)
      locale = if requested_locale in locales, do: requested_locale, else: journal.primary_locale
      sections = load_sections(journal, locale)
      requested_section = Map.get(params, "section_id", socket.assigns.selected_section_id)

      section_id =
        if Enum.any?(sections, &(to_string(&1.id) == requested_section)) do
          requested_section
        else
          sections |> List.first() |> then(&(&1 && to_string(&1.id)))
        end

      {:noreply,
       socket
       |> assign(:selected_journal_id, to_string(journal.journal_id))
       |> assign(:selected_locale, locale)
       |> assign(:locales, locales)
       |> assign(:sections, sections)
       |> assign(:selected_section_id, section_id)
       |> assign(:started_submission, nil)}
    else
      {:noreply, put_flash(socket, :error, "Jurnal yang dipilih tidak tersedia.")}
    end
  end

  @impl true
  def handle_event("begin_submission", %{"journal_id" => journal_id} = params, socket) do
    user = socket.assigns.current_scope.user
    journal = find_enabled_journal(socket.assigns.journals, journal_id)
    section_id = parse_integer(Map.get(params, "section_id"))
    locale = Map.get(params, "locale")

    cond do
      is_nil(journal) ->
        {:noreply, put_flash(socket, :error, "Silakan pilih jurnal yang tersedia.")}

      locale not in socket.assigns.locales ->
        {:noreply,
         put_flash(socket, :error, "Bahasa yang dipilih tidak tersedia untuk jurnal ini.")}

      true ->
        case Submissions.start_submission(user, journal.journal_id, %{
               section_id: section_id,
               locale: locale
             }) do
          {:ok, result} ->
            {:noreply,
             socket
             |> assign(:started_submission, result.submission)
             |> put_flash(:info, "Submission berhasil dibuat sebagai draft.")}

          {:error, :journal_not_found} ->
            {:noreply, put_flash(socket, :error, "Jurnal tidak ditemukan.")}

          {:error, :submissions_disabled} ->
            {:noreply,
             put_flash(socket, :error, "Jurnal ini sedang tidak menerima submission baru.")}

          {:error, :section_not_found} ->
            {:noreply,
             put_flash(socket, :error, "Section yang dipilih tidak tersedia pada jurnal ini.")}

          {:error, :section_inactive} ->
            {:noreply, put_flash(socket, :error, "Section yang dipilih sedang tidak aktif.")}

          {:error, :section_editor_restricted} ->
            {:noreply,
             put_flash(socket, :error, "Section tersebut hanya dapat dipilih oleh editor.")}

          {:error, :not_allowed} ->
            {:noreply,
             put_flash(socket, :error, "Jurnal ini belum memiliki grup Author untuk pendaftaran.")}

          {:error, %Ecto.Changeset{}} ->
            {:noreply,
             put_flash(
               socket,
               :error,
               "Submission belum dapat dibuat. Periksa data jurnal dan akun."
             )}

          {:error, _reason} ->
            {:noreply, put_flash(socket, :error, "Terjadi kesalahan saat membuat submission.")}
        end
    end
  end

  def handle_event("begin_submission", _params, socket) do
    {:noreply, put_flash(socket, :error, "Data jurnal belum lengkap. Silakan pilih jurnal.")}
  end

  def handle_event("new_submission", _params, socket) do
    {:noreply, assign(socket, :started_submission, nil)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="mx-auto w-full max-w-4xl space-y-6">
        <div class="border-b border-base-300 pb-5">
          <p class="text-sm font-semibold uppercase tracking-[0.16em] text-primary">
            Author Dashboard
          </p>
          <h1 class="mt-2 text-3xl font-semibold tracking-tight">Make a Submission</h1>
          <p class="mt-2 text-sm text-base-content/70">
            Start a new manuscript submission to one of the available journals.
          </p>
        </div>

        <%= if @started_submission do %>
          <section class="rounded-xl border border-success/30 bg-success/5 p-6" role="status">
            <div class="flex items-start gap-3">
              <.icon name="hero-check-circle" class="mt-0.5 size-7 text-success" />
              <div class="min-w-0">
                <h2 class="text-lg font-semibold">Submission started</h2>
                <p class="mt-1 text-sm text-base-content/75">
                  Your draft has been saved. Submission ID: <strong class="font-mono">{@started_submission.submission_id}</strong>.
                </p>
                <p class="mt-2 text-sm text-base-content/70">
                  You can continue with the next wizard step once the submission details page is available.
                </p>
                <button
                  type="button"
                  phx-click="new_submission"
                  class="btn btn-outline btn-sm mt-4"
                >
                  Start another submission
                </button>
              </div>
            </div>
          </section>
        <% else %>
          <section class="rounded-xl border border-base-300 bg-base-100 p-6 shadow-sm sm:p-8">
            <h2 class="text-xl font-semibold">Before you begin</h2>
            <div class="mt-3 space-y-3 text-sm leading-6 text-base-content/75">
              <p>
                You will be asked to upload your manuscript files, identify co-authors, and provide
                information such as the title and abstract in the following steps.
              </p>
              <p>
                Please choose the journal, section, and submission language carefully. Your progress
                will be saved as a draft when you begin.
              </p>
            </div>

            <%= if @journals == [] do %>
              <div class="alert alert-warning mt-6">
                <.icon name="hero-exclamation-triangle" class="size-5" />
                <span>There are currently no available journals.</span>
              </div>
            <% else %>
              <form
                id="submission-start-form"
                phx-change="update_options"
                phx-submit="begin_submission"
                class="mt-7 space-y-6"
              >
                <div class="space-y-2">
                  <label for="journal_id" class="label font-medium">Journal
                  <span class="text-error">*</span></label>
                  <select
                    id="journal_id"
                    name="journal_id"
                    class="select select-bordered w-full"
                    required
                  >
                    <%= for journal <- @journals do %>
                      <option
                        value={journal.journal_id}
                        selected={to_string(journal.journal_id) == @selected_journal_id}
                      >
                        {journal.path}
                      </option>
                    <% end %>
                  </select>
                </div>

                <div class="grid gap-6 sm:grid-cols-2">
                  <div class="space-y-2">
                    <label for="section_id" class="label font-medium">Section</label>
                    <select
                      id="section_id"
                      name="section_id"
                      class="select select-bordered w-full"
                      disabled={@sections == []}
                    >
                      <%= if @sections == [] do %>
                        <option value="">No section available</option>
                      <% else %>
                        <%= for section <- @sections do %>
                          <option
                            value={section.id}
                            selected={to_string(section.id) == @selected_section_id}
                          >
                            {section.title}
                          </option>
                        <% end %>
                      <% end %>
                    </select>
                    <p class="text-xs text-base-content/60">
                      Only active sections available to authors are shown.
                    </p>
                  </div>

                  <div class="space-y-2">
                    <label for="locale" class="label font-medium">Submission Language
                    <span class="text-error">*</span></label>
                    <select id="locale" name="locale" class="select select-bordered w-full" required>
                      <%= for locale <- @locales do %>
                        <option value={locale} selected={locale == @selected_locale}>
                          {locale_label(locale)}
                        </option>
                      <% end %>
                    </select>
                  </div>
                </div>

                <div class="flex justify-end border-t border-base-300 pt-5">
                  <button type="submit" class="btn btn-primary" phx-disable-with="Starting...">
                    Begin Submission <.icon name="hero-arrow-right" class="size-4" />
                  </button>
                </div>
              </form>
            <% end %>
          </section>
        <% end %>
      </div>
    </Layouts.app>
    """
  end

  defp find_enabled_journal(journals, journal_id) do
    Enum.find(journals, &(to_string(&1.journal_id) == to_string(journal_id)))
  end

  defp load_sections(nil, _locale), do: []

  defp load_sections(journal, locale) do
    rows =
      from(section in Section,
        left_join: setting in "section_settings",
        on:
          setting.section_id == section.section_id and setting.locale == ^(locale || "") and
            setting.setting_name == "title",
        where:
          section.journal_id == ^journal.journal_id and section.is_inactive == 0 and
            section.editor_restricted == 0,
        order_by: [asc: section.seq, asc: section.section_id],
        select: {section.section_id, setting.setting_value}
      )
      |> Repo.all()

    Enum.map(rows, fn {id, title} ->
      %{id: id, title: if(is_binary(title) and title != "", do: title, else: "Section #{id}")}
    end)
  end

  defp load_locales(nil), do: []

  defp load_locales(journal) do
    configured =
      Repo.all(
        from(setting in "journal_settings",
          where:
            setting.journal_id == ^journal.journal_id and
              setting.setting_name == "supportedLocales",
          select: setting.setting_value
        )
      )
      |> Enum.flat_map(&parse_locale_setting/1)

    ([journal.primary_locale] ++ configured)
    |> Enum.filter(&(is_binary(&1) and String.trim(&1) != ""))
    |> Enum.uniq()
  end

  defp parse_locale_setting(nil), do: []

  defp parse_locale_setting(value) when is_binary(value) do
    case Jason.decode(value) do
      {:ok, locales} when is_list(locales) -> locales
      _ -> String.split(value, [",", ";"], trim: true)
    end
  end

  defp parse_integer(value) when is_integer(value), do: value

  defp parse_integer(value) when is_binary(value) do
    case Integer.parse(value) do
      {integer, ""} -> integer
      _ -> nil
    end
  end

  defp parse_integer(_), do: nil

  defp locale_label("id"), do: "Bahasa Indonesia (id)"
  defp locale_label("en"), do: "English (en)"
  defp locale_label(locale), do: locale
end
