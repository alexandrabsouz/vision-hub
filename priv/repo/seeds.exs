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

alias VisionHub.{
  Repo,
  User,
  Device
}

defmodule VisionHub.Seeds do
  def run do
    IO.puts("Starting the seed script...")

    brands = ["Intelbras", "Hikvision", "Giga", "Vivotek"]
    current_time = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    Repo.transaction(fn ->
      1..1000
      |> Enum.each(fn _ ->
        user_data = %{
          email: Faker.Internet.email(),
          name: Faker.Person.name(),
          inserted_at: current_time,
          updated_at: current_time
        }

        user = %User{}
        |> User.changeset(user_data)
        |> Repo.insert!()

        devices_data = for _ <- 1..50 do
          %{
            brand: Enum.random(brands),
            is_active: Enum.random([true, false]),
            user_id: user.id,
            inserted_at: current_time,
            updated_at: current_time
          }
        end

        Repo.insert_all(Device, devices_data)
      end)
    end)

    IO.puts("Seed script executed successfully!")
  end
end

VisionHub.Seeds.run()
