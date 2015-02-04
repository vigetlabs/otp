defmodule OTP.Common.Mixfile do
  use Mix.Project

  def project do
    [
      app: :common,
      version: "0.0.1",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.0"
    ]
  end
end
