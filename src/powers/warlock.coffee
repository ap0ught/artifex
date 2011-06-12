hasPact = (pact) ->
  (power) -> power.npc.hasFeature("class", "#{pact} Pact")

module.exports =
  WarlocksCurse:
    name        : "Warlock's Curse"
    effect      : "+{hitDice}d6 extra damage (special)"
    _formulae   : { hitDice: ["case", ["<", ".level", 11], 1, ["<", ".level", 21], 2, true, 3] }

  DireRadiance:
    name        : "Dire Radiance"
    keywords    : [ "arcane", "fear", "implement", "radiant" ]
    attack      : "{±con} vs. Fortitude"
    hit         : "{hitDice}d6{±con.nz} damage (special)"
    _formulae   : { hitDice: ["if", ["<", ".level", 21], 1, 2] }

  EldritchBlast:
    name        : "Eldritch Blast"
    keywords    : [ "arcane", "implement" ]
    attack      : "{±ability} vs. Reflex"
    hit         : "{hitDice}d10{±ability.nz} damage"
    _formulae   :
      hitDice   : ["if", ["<", ".level", 21], 1, 2]
      ability   : (power) -> power.npc.abilities[power.ability].modifier()
      "±ability": ["±", "ability"]
      "±ability.nz": ["if", ["=", "ability", 0], ["~", ""], ["±", "ability"]]

  Eyebite:
    name        : "Eyebite"
    keywords    : [ "arcane", "charm", "implement", "psychic" ]
    attack      : "{±cha} vs. Will"
    hit         : "{hitDice}d6{±cha.nz} damage (special)"
    _formulae   : { hitDice: ["if", ["<", ".level", 21], 1, 2] }

  HellishRebuke:
    name        : "Hellish Rebuke"
    keywords    : [ "arcane", "fire", "implement" ]
    attack      : "{±con} vs. Reflex"
    hit         : "{hitDice}d6{±con.nz} damage (special)"
    _formulae   : { hitDice: ["if", ["<", ".level", 21], 1, 2] }

  DiabolicGrasp:
    name        : "Diabolic Grasp"
    keywords    : [ "arcane", "implement" ]
    attack      : "{±con} vs. Fortitude"
    hit         : "2d8{±con.nz} damage, slide target {distance} {squares}"
    _formulae   :
      distance: ["if", hasPact("Infernal"), ["+", "#int", 1], 2]
      squares : ["if", ["=", "distance", 1], ["~", "square"], ["~", "squares"]]

  DreadfulWord:
    name        : "Dreadful Word"
    keywords    : [ "arcane", "fear", "implement", "psychic" ]
    attack      : "{±cha} vs. Will"
    hit         : "2d8{±cha.nz} damage, target has {penalty} Will"
    _formulae   : { penalty: ["±", ["-", 0, ["if", hasPact("Star"), ["+", "#int", 1], 1]]] }

  VampiricEmbrace:
    name        : "Vampiric Embrace"
    keywords    : [ "arcane", "implement", "necrotic" ]
    attack      : "{±con} vs. Will"
    hit         : "2d8{±con.nz} damage, you gain {hp} temporary HP"
    _formulae   : { hp: ["if", hasPact("Infernal"), ["+", "#int", 5], 5] }

  Witchfire:
    name        : "Witchfire"
    keywords    : [ "arcane", "fire", "implement" ]
    attack      : "{±cha} vs. Reflex"
    hit         : "2d6{±cha.nz} damage, target has {penalty} attack"
    _formulae   : { penalty: ["±", ["-", 0, ["if", hasPact("Fey"), ["+", "#int", 2], 2]]] }

  ArmorOfAgathys:
    name        : "Armor of Agathys"
    keywords    : [ "arcane", "cold" ]
    effect      : "{±tempHP} temporary HP, adjacent enemies take 1d6{±con.nz} damage"
    _formulae   :
      "±tempHP": ["±", ["+", "#int", 10]]

  CurseOfTheDarkDream:
    name        : "Curse of the Dark Dream"
    keywords    : [ "arcane", "charm", "implement", "psychic" ]
    attack      : "{±cha} vs. Will"
    hit         : "3d8{±cha.nz} damage (special)"

  DreadStar:
    name        : "Dread Star"
    keywords    : [ "arcane", "fear", "implement", "radiant" ]
    attack      : "{±cha} vs. Will"
    hit         : "3d6{±cha.nz} damage (special)"

  FlamesOfPhlegethos:
    name        : "Flames of Phlegethos"
    keywords    : [ "arcane", "fire", "implement" ]
    attack      : "{±con} vs. Reflex"
    hit         : "3d10{±con.nz} damage (special)"
