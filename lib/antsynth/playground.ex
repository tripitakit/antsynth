defmodule Antsynth.Playground do
  alias Antsynth.{Ant, Playground}

  @type t :: %Playground{
          midi_root: integer,
          radius: integer,
          map: %HexGrid.Map{data: Map.t()}
        }

  @enforce_keys [:midi_root, :radius, :map]
  defstruct(@enforce_keys)

  @spec new({integer(), integer()}) :: {:ok, Playground.t()}
  def new({midi_root, radius}) do
    {:ok, map} = HexGrid.Map.new_hex(radius)

    midi_map =
      map.data
      |> Map.keys()
      |> set_note(midi_root, map)

    {:ok, %Playground{midi_root: midi_root, radius: radius, map: midi_map}}
  end

  @spec includes?(HexGrid.Map.t(), HexGrid.Hex.t()) :: true | false
  defp includes?(map, hex) do
    map
    |> Map.has_key?(hex)
  end

  @spec set_note([], integer(), HexGrid.Map.t()) :: HexGrid.Map.t()
  defp set_note([], _root, map), do: map

  @spec set_note(nonempty_list(HexGrid.Hex.t()), integer(), HexGrid.Map.t()) :: nil
  defp set_note([hex = %HexGrid.Hex{} | hexes], midi_root, map) do
    midi_note = midi_root + hex.q + 4 * hex.r - 3 * hex.s

    {:ok, new_map} = HexGrid.Map.set(map, hex, :midi_note, midi_note)
    set_note(hexes, midi_root, new_map)
  end
end
