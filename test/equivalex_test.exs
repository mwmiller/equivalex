defmodule EquivalexTest do
  use ExUnit.Case
  import Equivalex
  doctest Equivalex

  test "strings" do
    a = "hello"
    b = "hullo"

    assert equal?(a, a)
    assert equal?(b, b)

    refute equal?(a, b)
  end

  test "bitstrings" do
    a = <<0::size(1), 1::size(1)>>
    b = <<1::size(1), 0::size(1)>>

    assert equal?(a, a)
    assert equal?(b, b)

    refute equal?(a, b)
  end

  test "charlists" do
    a = 'hello'
    b = 'hullo'

    assert equal?(a, a)
    assert equal?(b, b)

    refute equal?(a, b)
  end

  test "maps" do
    a = %{"one" => 1, "two" => 2}
    b = %{"one" => 2, "two" => 1}

    assert equal?(a, a)
    assert equal?(b, b)

    refute equal?(a, b)
  end

  test "tuples" do
    a = {"hello", "world"}
    b = {"hello", "whirled"}

    assert equal?(a, a)
    assert equal?(b, b)

    refute equal?(a, b)
  end

  test "deeper structures" do
    a = [{3, "dog"}, "silent", {['abc', 'def'], 3.14}, :error]
    b = [{3, "dog"}, "silent", {['abc', 'def'], 'tau'}, :ok]
    c = {:ok, %{"numbers" => [1, 2, 3]}}

    assert equal?(a, a)
    assert equal?(b, b)
    assert equal?(c, c)

    refute equal?(a, b)
    refute equal?(b, c)
    refute equal?(c, a)
  end

  test "constant timeliness" do
    a = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    b = "baaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    c = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaac"
    d = "aaaaaaaaaaaaaaaaaaaddddddddddddddddddddddddd"

    combos = [
      {a, a},
      {b, b},
      {c, c},
      {d, d},
      {a, b},
      {b, c},
      {c, d},
      {a, c},
      {b, d},
      {a, d}
    ]

    all_times = TimeProfile.timethem(combos, [])
    avg = Enum.sum(all_times) / Enum.count(all_times)

    assert Enum.max(all_times) / avg <= 1.05, "Slowest comparison is no more than 5% off mean"
    assert Enum.min(all_times) / avg >= 0.95, "Fastest comparison is no more than 5% off mean"
  end
end
