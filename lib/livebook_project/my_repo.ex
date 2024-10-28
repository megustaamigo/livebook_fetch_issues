defmodule LivebookProject.MyRepo do
  use Ecto.Repo,
    otp_app: :livebook_project,
    adapter: Ecto.Adapters.Postgres
end
