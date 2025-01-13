defmodule VisionHubWeb.Mocks.Mailer do
  Mox.defmock(MailerMock, for: VisionHub.MailerBehaviour)
  Mox.defmock(AccountMock, for: VisionHub.AccountBehaviour)
end
