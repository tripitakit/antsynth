defmodule Antsynth.Playground do
  alias Antsynth.Playground

  @type t :: %Playground{
          midi_root: integer,
          radius: integer,
          map: %HexGrid.Map{data: Map.t()}
        }

  @enforce_keys [:midi_root, :radius, :map]
  defstruct([:midi_root, :radius, :map])

  @spec init(integer, integer) :: Playground.t()
  def init(midi_root, radius \\ 3) when radius > 0 do
    {:ok, map} = HexGrid.Map.new_hex(radius)

    midi_map =
      map.data
      |> Map.keys()
      |> set_note(midi_root, map)

    %Playground{midi_root: midi_root, radius: radius, map: midi_map}
  end

  defp set_note([], _root, map), do: map

  defp set_note([hex | hexes], midi_root, map) do
    # +7 => Perfect Fifth
    # +3 => minor third
    # +4 => Major third

    midi_note = midi_root + 7 * hex.q + 3 * hex.r + 4 * hex.s

    {:ok, new_map} = HexGrid.Map.set(map, hex, :midi_note, midi_note)

    set_note(hexes, midi_root, new_map)
  end
end
