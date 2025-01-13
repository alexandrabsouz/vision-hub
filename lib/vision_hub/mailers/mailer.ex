defmodule VisionHub.Mailer do
  @moduledoc """
  This module is responsible for handling email sending functionality
  within the VisionHub application. It uses the Swoosh.Mailer library
  to provide email delivery capabilities.
  """
  use Swoosh.Mailer, otp_app: :vision_hub
  @behaviour VisionHub.MailerBehaviour

  @spec send_notification_email(any()) :: {:error, any()} | {:ok, any()}
  def send_notification_email(user_email) do
    new_email =
      Swoosh.Email.new()
      |> Swoosh.Email.to(user_email)
      |> Swoosh.Email.from("no-reply@visionhub.com")
      |> Swoosh.Email.subject("Notificação sobre câmeras Hikvision")
      |> Swoosh.Email.html_body("<h1>Olá!</h1><p>Você possui uma câmera da marca Hikvision.</p>")

    deliver(new_email)
  end
end
