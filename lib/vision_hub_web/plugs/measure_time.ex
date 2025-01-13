defmodule VisionHubWeb.Plugs.MeasureTime do
  @moduledoc """
  This module provides a plug to measure the time it takes to process a request.
  """
  import Plug.Conn

  alias Timex

  def init(default), do: default

  def call(conn, _opts) do
    start_time = Timex.now()

    conn = assign(conn, :start_time, start_time)

    conn
    |> put_resp_header("x-start-time", Timex.format!(start_time, "{ISO:Extended}"))
  end

  def log_time(conn) do
    start_time = conn.assigns[:start_time]
    end_time = Timex.now()

    duration = Timex.diff(end_time, start_time, :milliseconds)

    IO.puts("Request duration: #{duration}ms")

    duration
  end
end
