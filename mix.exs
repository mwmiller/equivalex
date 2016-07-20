defmodule Equivalex.Mixfile do
  use Mix.Project

  def project do
    [app: :equivalex,
     version: "0.1.2",
     elixir: "~> 1.3",
     name: "Equivalex",
     source_url: "https://github.com/mwmiller/equivalex",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    []
  end

  defp deps do
    [
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.13", only: :dev},
    ]
  end

  defp description do
    """
    constant time polymorphic comparisons
    """
  end

  defp package do
    [
     files: ["lib", "mix.exs", "README*", "LICENSE*", ],
     maintainers: ["Matt Miller"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/mwmiller/equivalex",
             }
    ]
  end

end

