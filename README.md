# SpellCheckClient

This is a very early implementation of Microsoft's Project Oxford API in Elixir. Currently only supports the Spell Check API, but I'll be expanding it to cover the entire API.

https://www.projectoxford.ai/

## Dependencies
This project requires poison, and httpoison

## Install
1. Copy the three files in lib/ into your lib/
2. Change the API key in http_spell_check

## Usage
```
require SpellCheckClient

HTTPSpellCheck.start
IO.puts SpellCheckClient.check("Thos strimg has erors.")
```


