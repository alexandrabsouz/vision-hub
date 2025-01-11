defmodule VisionHub.Filters.DeviceFilters do
  import Ecto.Query

  @moduledoc """
  Helper functions to filter and sort devices in Ecto queries.
  """

  @doc """
  Filters the query by device name.

  ## Parameters
    - `query`: The Ecto query.
    - `name`: The device name to filter by.

  ## Returns
  The filtered query or original query if `name` is nil.
  """
  def apply_device_name_filter(query, nil), do: query

  def apply_device_name_filter(query, name) do
    from [u, d] in query, where: d.name == ^name
  end

  @doc """
  Filters the query by device brand.

  ## Parameters
    - `query`: The Ecto query.
    - `brand`: The device brand to filter by.

  ## Returns
  The filtered query or original query if `brand` is nil.
  """
  def apply_device_brand_filter(query, nil), do: query

  def apply_device_brand_filter(query, brand) do
    from [u, d] in query, where: d.brand == ^brand
  end

  @doc """
  Orders the query by the specified field.

  ## Parameters
    - `query`: The Ecto query.
    - `order_by`: The field to order by (either "name" or "brand").

  ## Returns
  The ordered query or original query if `order_by` is nil or unknown.
  """
  def apply_ordering(query, nil), do: query

  def apply_ordering(query, "brand") do
    from [u, d] in query, order_by: [asc: d.brand]
  end

  def apply_ordering(query, "name") do
    from [u, d] in query, order_by: [asc: d.name]
  end

  def apply_ordering(query, _), do: query
end
