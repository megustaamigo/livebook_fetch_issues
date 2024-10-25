defmodule LivebookProject do
  def instructions do
    IO.puts(
      "Please provide following information about the GitHub\n repository you want to access and view issues of:"
    )
  end

  def followup_instructions do
    IO.puts("Evalue the Elixir code underneath and sen the information for it to be displayed.")
  end
end
