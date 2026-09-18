defmodule SimpleJournalSystem.Emails do
  import Swoosh.Email

  alias SimpleJournalSystem.Accounts.User

  @from_email System.get_env("MAILER_SENDER") || "noreply@example.com"
  @app_name "Simple Journal System"

  def deliver_confirmation_instructions(%User{} = user, encoded_token) do
    confirmation_url =
      "http://localhost:4000/users/confirm/#{encoded_token}"

    email =
      new()
      |> from(@from_email)
      |> to({user.username || "User", user.email})
      |> subject("Confirm Your Email")
      |> html_body("""
      <h1>Welcome to #{@app_name}</h1>
      <p>Please confirm your email address by clicking the link below:</p>
      <p>
        <a href="#{confirmation_url}">Confirm Email</a>
      </p>
      <p>If you did not create an account, please ignore this email.</p>
      <p>This link will expire in 7 days.</p>
      """)
      |> text_body("""
      Welcome to #{@app_name}

      Please confirm your email address by visiting:
      #{confirmation_url}

      If you did not create an account, please ignore this email.
      This link will expire in 7 days.
      """)

    deliver_email(email)
  end

  def deliver_login_instructions(%User{} = user, encoded_token, url_fun) do
  login_url = url_fun.(encoded_token)

    email =
      new()
      |> from(@from_email)
      |> to({user.username || "User", user.email})
      |> subject("Log in instructions")
      |> html_body("""
      <h1>Log in to #{@app_name}</h1>
      <p>You can log into your account by visiting the link below:</p>
      <p>
        <a href="#{login_url}">Log in</a>
      </p>
      <p>If you didn't request this email, please ignore this.</p>
      """)
      |> text_body("""
      Log in to #{@app_name}

      You can log into your account by visiting:
      #{login_url}

      If you didn't request this email, please ignore this.
      """)

    deliver_email(email)
  end

    def deliver_reset_password_instructions(%User{} = user, encoded_token) do
      reset_url =
        "http://localhost:4000/users/reset/#{encoded_token}"

      email =
        new()
        |> from(@from_email)
        |> to({user.username || "User", user.email})
        |> subject("Reset Your Password")
        |> html_body("""
        <h1>Password Reset Request</h1>
        <p>
          We received a request to reset your password.
          Click the link below:
        </p>
        <p>
          <a href="#{reset_url}">Reset Password</a>
        </p>
        <p>If you did not request this, please ignore this email.</p>
        <p>This link will expire in 7 days.</p>
        """)
        |> text_body("""
        Password Reset Request

        We received a request to reset your password.

        Visit:
        #{reset_url}

        If you did not request this, please ignore this email.
        This link will expire in 7 days.
        """)

      deliver_email(email)
    end

  def deliver_update_email_instructions(
        %User{} = user,
        new_email,
        encoded_token,
        url_fun
      ) do
    update_url = url_fun.(encoded_token)

    email =
      new()
      |> from(@from_email)
      |> to({user.username || "User", new_email})
      |> subject("Confirm Email Change")
      |> html_body("""
      <h1>Email Change Request</h1>
      <p>
        You requested to change your email address to #{new_email}.
      </p>
      <p>Click the link below to confirm:</p>
      <p>
        <a href="#{update_url}">Confirm Email Change</a>
      </p>
      <p>If you did not request this, please ignore this email.</p>
      <p>This link will expire in 7 days.</p>
      """)
      |> text_body("""
      Email Change Request

      You requested to change your email address to #{new_email}.

      Visit to confirm:
      #{update_url}

      If you did not request this, please ignore this email.
      This link will expire in 7 days.
      """)

    deliver_email(email)
  end

  defp deliver_email(email) do
    case SimpleJournalSystem.Mailer.deliver(email) do
      {:ok, _metadata} ->
        IO.puts("Email sent successfully")

      {:error, error} ->
        IO.puts("Email delivery failed: #{inspect(error)}")
        IO.puts("To: #{inspect(email.to)}")
        IO.puts("Subject: #{email.subject}")
    end
  end
end
