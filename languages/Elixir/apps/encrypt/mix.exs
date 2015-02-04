defmodule Encrypt.Mixfile do
  use Mix.Project

  def project do
    [
      app: :encrypt,
      version: "0.0.1",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.0",
      escript: [ main_module: Encrypt, path: "../../encrypt" ]
    ]
  end
end
