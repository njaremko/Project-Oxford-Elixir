defmodule Corrector do
  def construct_correct_text(corrections \\ [], text \\ "", prev_start \\ 0, offset \\ -1,  result \\ "")

  def construct_correct_text([head|tail], text, prev_start, offset, result) do

    offset = Map.get(head, "offset")

    if offset > prev_start do
      result = result <> String.slice(text, prev_start, offset - prev_start)
    end

    top_suggestion = ""
    suggestion_length = length(Map.get(head, "suggestions"))
    if suggestion_length == 0 do
      # No suggestions, so just use token...
      top_suggestion = Map.get(head, "token")
    else
      top_suggestion = Map.get(
                        # Take first suggestion
                        hd(Map.get(head, "suggestions")),
                        "token")
    end
    result = result <> top_suggestion

    prev_start = offset + String.length(Map.get(head, "token"))

    construct_correct_text(tail, text, prev_start, offset, result)
  end

  def construct_correct_text([], text, prev_start, offset, result) do
    len = String.length(text)
    if prev_start < len do
      result = result <> elem(String.split_at(text, prev_start), 1)
    end
    result
  end
end
