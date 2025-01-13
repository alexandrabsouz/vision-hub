# Start the ExUnit framework
ExUnit.start()

# Set the Ecto SQL Sandbox mode to manual for the VisionHub Repo
Ecto.Adapters.SQL.Sandbox.mode(VisionHub.Repo, :manual)
