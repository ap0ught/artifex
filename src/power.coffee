module.exports = class Power
  constructor: (initializers...) ->
    for initializer in initializers
      for key, value of initializer
        if key is "_formulae"
          for name, impl of value
            this[name] = impl
        else if typeof value is "function"
          this[key] = value(this)
        else
          this[key] = value

  get: (name) ->
    @process this[name]

  process: (value) ->
    if typeof value is "object" and value.length?
      @process item for item in value

    else if typeof value is "string"
      @parse value

    else
      value

  parse: (value) ->
    result = ""
    start = 0

    while (pos = value.indexOf("{", start)) >= 0
      ePos = value.indexOf "}", pos
      break unless ePos > pos

      key = value.substring pos+1, ePos
      result += value.substring start, pos
      result += this[key]()

      start = ePos+1

    result + value.substring start

  signed: (n) -> if n >= 0 then "+#{n}" else "#{n}"
  plural: (n, one, many) -> if n is 1 then one else many
  min   : (a, b) -> if a < b then a else b
  max   : (a, b) -> if a > b then a else b

  byLevel: (stages...) ->
    for stage in stages
      if typeof stage is "object"
        [value, cutoff] = stage
        return value if @npc.level < cutoff
      else
        return stage

    undefined

  "str": -> @npc.abilities.str.score()
  "con": -> @npc.abilities.con.score()
  "dex": -> @npc.abilities.dex.score()
  "int": -> @npc.abilities.int_.score()
  "int_": -> @npc.abilities.int_.score()
  "wis": -> @npc.abilities.wis.score()
  "cha": -> @npc.abilities.cha.score()

  "#str": -> @npc.abilities.str.modifier()
  "strM": -> @npc.abilities.str.modifier()
  "#con": -> @npc.abilities.con.modifier()
  "conM": -> @npc.abilities.con.modifier()
  "#dex": -> @npc.abilities.dex.modifier()
  "dexM": -> @npc.abilities.dex.modifier()
  "#int": -> @npc.abilities.int_.modifier()
  "intM": -> @npc.abilities.int_.modifier()
  "#wis": -> @npc.abilities.wis.modifier()
  "wisM": -> @npc.abilities.wis.modifier()
  "#cha": -> @npc.abilities.cha.modifier()
  "chaM": -> @npc.abilities.cha.modifier()

  "±str": -> @signed @strM()
  "±con": -> @signed @conM()
  "±dex": -> @signed @dexM()
  "±int": -> @signed @intM()
  "±wis": -> @signed @wisM()
  "±cha": -> @signed @chaM()

  "±str.nz": -> if @strM() != 0 then @signed @strM() else ""
  "±con.nz": -> if @conM() != 0 then @signed @conM() else ""
  "±dex.nz": -> if @dexM() != 0 then @signed @dexM() else ""
  "±int.nz": -> if @intM() != 0 then @signed @intM() else ""
  "±wis.nz": -> if @wisM() != 0 then @signed @wisM() else ""
  "±cha.nz": -> if @chaM() != 0 then @signed @chaM() else ""
