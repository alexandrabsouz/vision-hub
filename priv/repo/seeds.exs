# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     VisionHub.Repo.insert!(%VisionHub.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Faker
alias VisionHub.Repo
alias VisionHub.Accounts.User
alias VisionHub.Accounts.Device

current_time = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
brands = ["Intelbras", "Hikvision", "Giga", "Vivotek"]

# Gerar usuários
user_data = Enum.map(1..1000, fn _ ->
  %{
    email: Faker.Internet.email(),
    name: Faker.Person.name(),
    inserted_at: current_time,
    updated_at: current_time
  }
end)

# Executando inserções sequenciais dentro de transações
Enum.each(user_data, fn user_data ->
  Repo.transaction(fn ->
    # Inserir usuário
    user = Repo.insert!(User.changeset(%User{}, user_data))

    # Gerar e inserir dispositivos
    devices_data = Enum.map(1..50, fn _ ->
      %{
        brand: Enum.random(brands),
        is_active: Enum.random([true, false]),
        user_id: user.id,
        inserted_at: current_time,
        updated_at: current_time
      }
    end)

    Repo.insert_all(Device, devices_data)
  end)
end)

IO.puts("Seed script executed successfully!")
