defmodule VisionHub.MailerBehaviour do
  @moduledoc """
  Behaviour for sending notification emails.
  """
  @callback send_notification_email(String.t()) :: {:ok, any} | {:error, any}
end
