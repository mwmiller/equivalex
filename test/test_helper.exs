ExUnit.start()

defmodule TimeProfile do

  def timethem([], acc), do: acc
  def timethem([{a,b}|t], acc), do: timethem(t, [timethis(fn -> Equivalex.equal?(a,b) end, 25_000)|acc])

  def timethis(fun, count) do
    results = timeit(fun,count,[])
    Enum.sum(results)/Enum.count(results)
  end

  defp timeit(_f, 0, res), do: res
  defp timeit(fun, c, res) do
    {start, _return, stop} = {:os.timestamp, fun.(), :os.timestamp}
    timeit(fun, c-1, [:timer.now_diff(stop, start) |res])
  end
end
