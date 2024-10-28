defmodule LivebookProject.Visualization do
  def create_chart(data) do
    VegaLite.new(width: 1200, height: 800)
    |> VegaLite.data_from_values(data)
    |> VegaLite.mark(:point)
    |> VegaLite.encode_field(:x, "issues_updated_at", type: :temporal)
    |> VegaLite.encode_field(:y, "number", type: :nominal)
    |> VegaLite.encode_field(:color, "state", type: :nominal)
  end
end
