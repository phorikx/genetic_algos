defmodule OneMax do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = for _ <- 1..1000, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: 1000}
  end

  @impl true
  def fitness_function(chromosome) do
    Enum.sum(chromosome.genes)    
  end

  @impl true
  def terminate?([best | _]), do: best.fitness == 1000
end
IO.write("Running Genetic")

soln = Genetic.run(OneMax)

IO.write("\n")
IO.inspect(soln)
