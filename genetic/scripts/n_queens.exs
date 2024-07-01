defmodule NQueens do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype() do
   genes = Enum.shuffle(0..7)
    %Chromosome{genes: genes, size: 8}
  end

  @impl true
  def fitness_function(chromosome) do
    diag_clashes = 
    for i <- 0..7, j <- 0..7 do
      if i != j do
        dx = abs(i-j)
        dy = 
          abs(
            chromosome.genes
            |> Enum.at(i)
            |> Kernel.-(Enum.at(chromosome.genes, j))
          )
        if dx == dy do
          1
        else 
          0
        end
      else 
          0
      end
    end
    length(Enum.uniq(chromosome.genes)) - Enum.sum(diag_clashes)
  end
  
  @impl true
  def terminate?(population, generation) do
    Enum.max_by(population, &NQueens.fitness_function/1).fitness == 8
  end

  def repair_chromosome(chromosome) do
    genes = MapSet.new(chromosome.genes)
    new_genes = repair_helper(genes, 8)
    %Chromosome{genes: new_genes, size: length(new_genes)}
  end

  defp repair_helper(chromosome, k) do
    if MapSet.size(chromosome) >= k do
      MapSet.to_list(chromosome)
    else
      num = :rand.uniform(8)
      repair_helper(MapSet.put(chromosome, num), k)
    end
  end
end

soln = Genetic.run(NQueens, crossover_type: &Toolbox.Crossover.single_point_crossover/2, repair_chromosome: &NQueens.repair_chromosome/1)
IO.write("\n")
IO.write("Final solution: " <> Kernel.inspect(soln))
IO.write("\n")
