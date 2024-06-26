defmodule OneMaxInteractive do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = for _ <- 1..10, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: 10}
  end

  @impl true
  def fitness_function(chromosome) do
    IO.inspect(chromosome)
    fit = IO.gets("Rate from 1 to 10 ")
    fit
    |> String.trim()
    |> String.to_integer()
  end

  @impl true
  def terminate?([best | _], _generation), do: best.fitness == 20
end
IO.write("Running Genetic")

soln = Genetic.run(OneMaxInteractive, population_size: 4)

IO.write("\n")
IO.inspect(soln)
