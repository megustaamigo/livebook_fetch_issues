defmodule LivebookProject.Application do
  use Application

  def start(_type, _args) do
    children = [
      # Hier wird das Repo hinzugefügt
      LivebookProject.MyRepo
      # Du kannst hier andere Kinder hinzufügen, z.B. Web-Server, Worker etc.
    ]

    opts = [strategy: :one_for_one, name: LivebookProject.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
