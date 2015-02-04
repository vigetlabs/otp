defmodule Decrypt.Mixfile do
  use Mix.Project

  def project do
    [
      app: :decrypt,
      version: "0.0.1",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.0",
      escript: [ main_module: Decrypt, path: "../../decrypt" ],
      deps: deps
    ]
  end

  def deps do
    [ { :common, path: "../../lib/otp/common" } ]
  end
end
