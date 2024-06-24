defmodule Problem do
  alias Type.Chromosome

  @callback genotype :: Chromosome.t()
  @callback fitness_function(Chromosome.t()) :: number()
  @callback terminate?(Enum.t()) :: boolean()
end
