defmodule Antsynth.Playground do
  alias Antsynth.Playground

  @type t :: %Playground{
          root: integer,
          radius: integer,
          map: %HexGrid.Map{data: Map.t()}
        }

  @enforce_keys [:root, :radius, :map]
  defstruct([:root, :radius, :map])

  @spec init(integer, integer) :: Playground.t()
  def init(root, radius \\ 3) when radius > 0 do
    {:ok, map} = HexGrid.Map.new_hex(radius)

    %Playground{root: root, radius: radius, map: map}
    |> place_notes()
  end

  @spec place_notes(Playground.t()) :: Playground.t()
  defp place_notes(playground = %Playground{}) do
    new_map =
      playground.map.data
      |> Map.keys()
      |> place_note(playground.root, playground.map)

    %{playground | map: new_map}
  end

  defp place_note([], _root, map), do: map

  defp place_note([hex | hexes], root, map) do
    note = calc_note(root, hex.q, hex.r, hex.s)
    {:ok, new_map} = HexGrid.Map.set(map, hex, :midinote, note)
    place_note(hexes, root, new_map)
  end

  defp calc_note(root, q, r, s) do
    # +7 => Perfect Fifth
    # +3 => minor third
    # +4 => Major third
    root + 7 * q + 3 * r + 4 * s
  end
end
