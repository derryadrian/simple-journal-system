# Konstanta OJS 3.5 untuk status, keputusan, dan review.
#
# Semua nilai diambil dari kode resmi OJS (pkp-lib), jadi angkanya harus sama persis
# dengan isi database OJS. Jangan mengarang angka sendiri: kalau butuh kode baru,
# cari dulu di pkp-lib.
#
# Role (Roles) dan stage (Accounts.Stages) sudah ada di modul lain.

defmodule SimpleJournalSystem.Ojs.SubmissionStatus do
  @moduledoc """
  Status naskah dan publikasi (kolom `status` di tabel `submissions` dan `publications`).
  Sumber: PKPSubmission::STATUS_* di OJS 3.5.

  Catatan: status 2 tidak dipakai OJS 3.x. Status naskah selalu dihitung ulang dari
  status publikasinya, jangan diubah sembarangan.
  """

  @queued 1
  @published 3
  @declined 4
  @scheduled 5

  @all [
    @queued,
    @published,
    @declined,
    @scheduled
  ]

  @doc "Semua nilai yang dikenal."
  def all, do: @all

  def queued, do: @queued
  def published, do: @published
  def declined, do: @declined
  def scheduled, do: @scheduled

  @doc "Nama untuk ditampilkan."
  def name(value) do
    case value do
      @queued -> "Queued"
      @published -> "Published"
      @declined -> "Declined"
      @scheduled -> "Scheduled"
      _ -> "Unknown (#{value})"
    end
  end

  @doc "Apakah nilai ini dikenal OJS."
  def valid?(value), do: value in @all
end

defmodule SimpleJournalSystem.Ojs.Decision do
  @moduledoc """
  Kode keputusan editor (kolom `decision` di tabel `edit_decisions`).
  Sumber: PKP\\Decision\\Decision di OJS 3.5. Hanya kode yang dipakai OJS yang disertakan;
  kode khusus OMP (buku) tidak dimasukkan.
  """

  @accept 2
  @external_review 3
  @pending_revisions 4
  @resubmit 5
  @decline 6
  @send_to_production 7
  @initial_decline 8
  @recommend_accept 9
  @recommend_pending_revisions 10
  @recommend_resubmit 11
  @recommend_decline 12
  @new_external_round 14
  @revert_decline 15
  @revert_initial_decline 16
  @skip_external_review 17
  @back_from_production 29
  @back_from_copyediting 30
  @cancel_review_round 31

  @all [
    @accept,
    @external_review,
    @pending_revisions,
    @resubmit,
    @decline,
    @send_to_production,
    @initial_decline,
    @recommend_accept,
    @recommend_pending_revisions,
    @recommend_resubmit,
    @recommend_decline,
    @new_external_round,
    @revert_decline,
    @revert_initial_decline,
    @skip_external_review,
    @back_from_production,
    @back_from_copyediting,
    @cancel_review_round
  ]

  @doc "Semua nilai yang dikenal."
  def all, do: @all

  def accept, do: @accept
  def external_review, do: @external_review
  def pending_revisions, do: @pending_revisions
  def resubmit, do: @resubmit
  def decline, do: @decline
  def send_to_production, do: @send_to_production
  def initial_decline, do: @initial_decline
  def recommend_accept, do: @recommend_accept
  def recommend_pending_revisions, do: @recommend_pending_revisions
  def recommend_resubmit, do: @recommend_resubmit
  def recommend_decline, do: @recommend_decline
  def new_external_round, do: @new_external_round
  def revert_decline, do: @revert_decline
  def revert_initial_decline, do: @revert_initial_decline
  def skip_external_review, do: @skip_external_review
  def back_from_production, do: @back_from_production
  def back_from_copyediting, do: @back_from_copyediting
  def cancel_review_round, do: @cancel_review_round

  @doc "Nama untuk ditampilkan."
  def name(value) do
    case value do
      @accept -> "Accept Submission"
      @external_review -> "Send to Review"
      @pending_revisions -> "Request Revisions"
      @resubmit -> "Resubmit for Review"
      @decline -> "Decline Submission"
      @send_to_production -> "Send To Production"
      @initial_decline -> "Decline Submission (before review)"
      @recommend_accept -> "Recommend Accept"
      @recommend_pending_revisions -> "Recommend Revisions"
      @recommend_resubmit -> "Recommend Resubmit"
      @recommend_decline -> "Recommend Decline"
      @new_external_round -> "New Review Round"
      @revert_decline -> "Revert Decline"
      @revert_initial_decline -> "Revert Initial Decline"
      @skip_external_review -> "Accept and Skip Review"
      @back_from_production -> "Back from Production"
      @back_from_copyediting -> "Back from Copyediting"
      @cancel_review_round -> "Cancel Review Round"
      _ -> "Unknown (#{value})"
    end
  end

  @doc "Apakah nilai ini dikenal OJS."
  def valid?(value), do: value in @all

  @doc """
  Keputusan yang hanya berupa rekomendasi (dibuat editor "recommend only").
  Rekomendasi tidak mengubah stage atau status naskah.
  """
  def recommendation?(value),
    do:
      value in [
        @recommend_accept,
        @recommend_pending_revisions,
        @recommend_resubmit,
        @recommend_decline
      ]
end

defmodule SimpleJournalSystem.Ojs.ReviewAssignmentStatus do
  @moduledoc """
  Status penugasan reviewer (hasil hitung dari `review_assignments`, bukan satu kolom).
  Sumber: ReviewAssignment::REVIEW_ASSIGNMENT_STATUS_* di OJS 3.5.
  """

  @awaiting_response 0
  @declined 1
  @response_overdue 4
  @accepted 5
  @review_overdue 6
  @received 7
  @complete 8
  @thanked 9
  @cancelled 10
  @request_resend 11
  @viewed 12

  @all [
    @awaiting_response,
    @declined,
    @response_overdue,
    @accepted,
    @review_overdue,
    @received,
    @complete,
    @thanked,
    @cancelled,
    @request_resend,
    @viewed
  ]

  @doc "Semua nilai yang dikenal."
  def all, do: @all

  def awaiting_response, do: @awaiting_response
  def declined, do: @declined
  def response_overdue, do: @response_overdue
  def accepted, do: @accepted
  def review_overdue, do: @review_overdue
  def received, do: @received
  def complete, do: @complete
  def thanked, do: @thanked
  def cancelled, do: @cancelled
  def request_resend, do: @request_resend
  def viewed, do: @viewed

  @doc "Nama untuk ditampilkan."
  def name(value) do
    case value do
      @awaiting_response -> "Awaiting Response"
      @declined -> "Declined"
      @response_overdue -> "Response Overdue"
      @accepted -> "Accepted"
      @review_overdue -> "Review Overdue"
      @received -> "Review Received"
      @complete -> "Review Complete"
      @thanked -> "Reviewer Thanked"
      @cancelled -> "Cancelled"
      @request_resend -> "Request Resent"
      @viewed -> "Viewed"
      _ -> "Unknown (#{value})"
    end
  end

  @doc "Apakah nilai ini dikenal OJS."
  def valid?(value), do: value in @all

  @complete_statuses [@received, @complete, @thanked, @viewed]

  @doc "Status yang berarti review sudah selesai dikerjakan reviewer."
  def complete_statuses, do: @complete_statuses
end

defmodule SimpleJournalSystem.Ojs.ReviewAssignmentConsidered do
  @moduledoc """
  Penanda "considered" oleh editor (kolom `considered` di `review_assignments`).
  Sumber: ReviewAssignment::REVIEW_ASSIGNMENT_* di OJS 3.5.
  """

  @new 0
  @unconsidered 1
  @reconsidered 2
  @considered 3
  @viewed 4

  @all [
    @new,
    @unconsidered,
    @reconsidered,
    @considered,
    @viewed
  ]

  @doc "Semua nilai yang dikenal."
  def all, do: @all

  def new, do: @new
  def unconsidered, do: @unconsidered
  def reconsidered, do: @reconsidered
  def considered, do: @considered
  def viewed, do: @viewed

  @doc "Nama untuk ditampilkan."
  def name(value) do
    case value do
      @new -> "New"
      @unconsidered -> "Unconsidered"
      @reconsidered -> "Reconsidered"
      @considered -> "Considered"
      @viewed -> "Viewed"
      _ -> "Unknown (#{value})"
    end
  end

  @doc "Apakah nilai ini dikenal OJS."
  def valid?(value), do: value in @all
end

defmodule SimpleJournalSystem.Ojs.ReviewRecommendation do
  @moduledoc """
  Rekomendasi reviewer (kolom `recommendation` di `review_assignments`).
  Sumber: ReviewAssignment::SUBMISSION_REVIEWER_RECOMMENDATION_* di OJS 3.5.
  """

  @accept 1
  @pending_revisions 2
  @resubmit_here 3
  @resubmit_elsewhere 4
  @decline 5
  @see_comments 6

  @all [
    @accept,
    @pending_revisions,
    @resubmit_here,
    @resubmit_elsewhere,
    @decline,
    @see_comments
  ]

  @doc "Semua nilai yang dikenal."
  def all, do: @all

  def accept, do: @accept
  def pending_revisions, do: @pending_revisions
  def resubmit_here, do: @resubmit_here
  def resubmit_elsewhere, do: @resubmit_elsewhere
  def decline, do: @decline
  def see_comments, do: @see_comments

  @doc "Nama untuk ditampilkan."
  def name(value) do
    case value do
      @accept -> "Accept Submission"
      @pending_revisions -> "Revisions Required"
      @resubmit_here -> "Resubmit for Review"
      @resubmit_elsewhere -> "Resubmit Elsewhere"
      @decline -> "Decline Submission"
      @see_comments -> "See Comments"
      _ -> "Unknown (#{value})"
    end
  end

  @doc "Apakah nilai ini dikenal OJS."
  def valid?(value), do: value in @all
end

defmodule SimpleJournalSystem.Ojs.ReviewMethod do
  @moduledoc """
  Metode review (kolom `review_method` di `review_assignments`).
  Sumber: ReviewAssignment::SUBMISSION_REVIEW_METHOD_* di OJS 3.5.
  """

  @anonymous 1
  @double_anonymous 2
  @open 3

  @all [
    @anonymous,
    @double_anonymous,
    @open
  ]

  @doc "Semua nilai yang dikenal."
  def all, do: @all

  def anonymous, do: @anonymous
  def double_anonymous, do: @double_anonymous
  def open, do: @open

  @doc "Nama untuk ditampilkan."
  def name(value) do
    case value do
      @anonymous -> "Anonymous Reviewer/Disclosed Author"
      @double_anonymous -> "Double-anonymous"
      @open -> "Open"
      _ -> "Unknown (#{value})"
    end
  end

  @doc "Apakah nilai ini dikenal OJS."
  def valid?(value), do: value in @all
end

defmodule SimpleJournalSystem.Ojs.ReviewRoundStatus do
  @moduledoc """
  Status review round (kolom `status` di `review_rounds`).
  Sumber: ReviewRound::REVIEW_ROUND_STATUS_* di OJS 3.5.
  """

  @revisions_requested 1
  @resubmit_for_review 2
  @sent_to_external 3
  @accepted 4
  @declined 5
  @pending_reviewers 6
  @pending_reviews 7
  @reviews_ready 8
  @reviews_completed 9
  @reviews_overdue 10
  @revisions_submitted 11
  @pending_recommendations 12
  @recommendations_ready 13
  @recommendations_completed 14
  @resubmit_for_review_submitted 15
  @returned_to_review 16

  @all [
    @revisions_requested,
    @resubmit_for_review,
    @sent_to_external,
    @accepted,
    @declined,
    @pending_reviewers,
    @pending_reviews,
    @reviews_ready,
    @reviews_completed,
    @reviews_overdue,
    @revisions_submitted,
    @pending_recommendations,
    @recommendations_ready,
    @recommendations_completed,
    @resubmit_for_review_submitted,
    @returned_to_review
  ]

  @doc "Semua nilai yang dikenal."
  def all, do: @all

  def revisions_requested, do: @revisions_requested
  def resubmit_for_review, do: @resubmit_for_review
  def sent_to_external, do: @sent_to_external
  def accepted, do: @accepted
  def declined, do: @declined
  def pending_reviewers, do: @pending_reviewers
  def pending_reviews, do: @pending_reviews
  def reviews_ready, do: @reviews_ready
  def reviews_completed, do: @reviews_completed
  def reviews_overdue, do: @reviews_overdue
  def revisions_submitted, do: @revisions_submitted
  def pending_recommendations, do: @pending_recommendations
  def recommendations_ready, do: @recommendations_ready
  def recommendations_completed, do: @recommendations_completed
  def resubmit_for_review_submitted, do: @resubmit_for_review_submitted
  def returned_to_review, do: @returned_to_review

  @doc "Nama untuk ditampilkan."
  def name(value) do
    case value do
      @revisions_requested -> "Revisions Requested"
      @resubmit_for_review -> "Resubmit for Review"
      @sent_to_external -> "Sent to External Review"
      @accepted -> "Accepted"
      @declined -> "Declined"
      @pending_reviewers -> "Pending Reviewers"
      @pending_reviews -> "Pending Reviews"
      @reviews_ready -> "Reviews Ready"
      @reviews_completed -> "Reviews Completed"
      @reviews_overdue -> "Reviews Overdue"
      @revisions_submitted -> "Revisions Submitted"
      @pending_recommendations -> "Pending Recommendations"
      @recommendations_ready -> "Recommendations Ready"
      @recommendations_completed -> "Recommendations Completed"
      @resubmit_for_review_submitted -> "Resubmission Submitted"
      @returned_to_review -> "Returned to Review"
      _ -> "Unknown (#{value})"
    end
  end

  @doc "Apakah nilai ini dikenal OJS."
  def valid?(value), do: value in @all
end

defmodule SimpleJournalSystem.Ojs.FileStage do
  @moduledoc """
  Tahap file naskah (kolom `file_stage` di `submission_files`).
  Sumber: SubmissionFile::SUBMISSION_FILE_* di OJS 3.5.
  """

  @submission 2
  @note 3
  @review_file 4
  @review_attachment 5
  @final 6
  @copyedit 9
  @proof 10
  @production_ready 11
  @attachment 13
  @review_revision 15
  @dependent 17
  @query 18
  @internal_review_file 19
  @internal_review_revision 20
  @jats 21

  @all [
    @submission,
    @note,
    @review_file,
    @review_attachment,
    @final,
    @copyedit,
    @proof,
    @production_ready,
    @attachment,
    @review_revision,
    @dependent,
    @query,
    @internal_review_file,
    @internal_review_revision,
    @jats
  ]

  @doc "Semua nilai yang dikenal."
  def all, do: @all

  def submission, do: @submission
  def note, do: @note
  def review_file, do: @review_file
  def review_attachment, do: @review_attachment
  def final, do: @final
  def copyedit, do: @copyedit
  def proof, do: @proof
  def production_ready, do: @production_ready
  def attachment, do: @attachment
  def review_revision, do: @review_revision
  def dependent, do: @dependent
  def query, do: @query
  def internal_review_file, do: @internal_review_file
  def internal_review_revision, do: @internal_review_revision
  def jats, do: @jats

  @doc "Nama untuk ditampilkan."
  def name(value) do
    case value do
      @submission -> "Submission"
      @note -> "Note"
      @review_file -> "Review File"
      @review_attachment -> "Review Attachment"
      @final -> "Final Draft"
      @copyedit -> "Copyedited"
      @proof -> "Proof"
      @production_ready -> "Production Ready"
      @attachment -> "Attachment"
      @review_revision -> "Review Revision"
      @dependent -> "Dependent File"
      @query -> "Query"
      @internal_review_file -> "Internal Review File"
      @internal_review_revision -> "Internal Review Revision"
      @jats -> "JATS"
      _ -> "Unknown (#{value})"
    end
  end

  @doc "Apakah nilai ini dikenal OJS."
  def valid?(value), do: value in @all
end
