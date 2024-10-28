defmodule LivebookProject.Application do
  use Application

  def start(_type, _args) do
    children = [
      LivebookProject.MyRepo
    ]

    opts = [strategy: :one_for_one, name: LivebookProject.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
