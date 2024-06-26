defmodule Speller do
 @impl Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = 
      Stream.repeatedly(fn -> Enum.random(?a..?z) end)
    |> Enum.take(34)
    %Chromosome{genes: genes, size: 34}
  end

  def fitness_function(chromosome) do
    target = "supercalifragilisticexpialidocious"
    guess = List.to_string(chromosome.genes)
    String.jaro_distance(target, guess)
  end

  def terminate?([best | _], _), do: best.fitness == 1
end
soln = Genetic.run(Speller, selection_type: fn pop, n -> Toolbox.Selection.tournament(pop, n, 3) end)
IO.write("\n")
IO.inspect(soln)
