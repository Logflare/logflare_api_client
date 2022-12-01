defmodule LogflareApiClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :logflare_api_client,
      version: "0.3.4",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: "A common client interface to the Logflare API.",
      package: [
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/Logflare/logflare_api_client"}
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {LogflareApiClient.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.4.0"},
      {:jason, ">= 1.0.0"},
      {:finch, "~> 0.10"},
      {:bertex, "~> 1.3"},
      {:bypass, "~> 2.1", only: :test},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
