defmodule Toolbox.Selection do
  def elite(parents, n) do
    parents
    |> Enum.take(n)
  end

  def random(parents, n) do
    parents
    |> Enum.take_random(n)
  end

  def tournament(parents, n, tournament_size) do
    0..(n - 1)
    |> Enum.map(fn _ ->
      parents
      |> Enum.take_random(tournament_size)
      |> Enum.max_by(& &1.fitness)
    end)
  end

  def tournament_no_duplicates(parents, n, tournament_size) do
    selected = MapSet.new()
    tournament_helper(parents, n, tournament_size, selected)
  end

  defp tournament_helper(parents, n, tournament_size, selected) do
    if MapSet.size(selected) == n do
      MapSet.to_list(selected)
    else
      chosen =
        parents
        |> Enum.take_random(tournament_size)
        |> Enum.max_by(& &1.fitness)

      tournament_helper(parents, n, tournament_size, MapSet.put(selected, chosen))
    end
  end

  def roulette(parents, n) do
    sum_fitness =
      parents
      |> Enum.map(& &1.fitness)
      |> Enum.sum()

    0..(n - 1)
    |> Enum.map(fn _ ->
      u = :rand.uniform() * sum_fitness

      parents
      |> Enum.reduce_while(
        0,
        fn x, sum ->
          if x.fitness + sum > u do
            {:halt, x}
          else
            {:cont, x.fitness + sum}
          end
        end
      )
    end)
  end
end
