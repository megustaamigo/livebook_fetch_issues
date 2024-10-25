defmodule Visualization do
  def create_chart(list_of_issues) do
    # Umwandeln der Daten in ein geeignetes Format für VegaLite
    data =
      Enum.map(list_of_issues, fn issue ->
        %{
          "title" => issue["title"],
          "number" => issue["number"],
          "state" => issue["state"],
          "updated_at" => issue["updated_at"]
        }
      end)

    VegaLite.new(width: 1200, height: 800)
    |> VegaLite.data_from_values(data)
    |> VegaLite.mark(:point)
    |> VegaLite.encode_field(:x, "updated_at", type: :temporal)
    |> VegaLite.encode_field(:y, "number", type: :nominal)
    |> VegaLite.encode_field(:color, "state", type: :nominal)
  end
end
