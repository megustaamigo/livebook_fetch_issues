import Config


config :livebook_project, ecto_repos: [LivebookProject.MyRepo]

config :livebook_project, LivebookProject.MyRepo,
  username: "postgres",
  password: "younghustler",
  database: "test_issues",  
  hostname: "localhost",
  pool_size: 10,
  pool: Ecto.Adapters.SQL.Sandbox  