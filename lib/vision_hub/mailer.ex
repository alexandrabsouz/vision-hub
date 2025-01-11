defmodule VisionHub.Mailer do
  @moduledoc """
  This module is responsible for handling email sending functionality
  within the VisionHub application. It uses the Swoosh.Mailer library
  to provide email delivery capabilities.

  ## Configuration

  Ensure that the `:vision_hub` OTP application is properly configured
  with the necessary email settings in your configuration files.

  ## Examples

      VisionHub.Mailer.deliver(email)

  """
  use Swoosh.Mailer, otp_app: :vision_hub

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
