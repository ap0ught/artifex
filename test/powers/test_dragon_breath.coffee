{NPC, Powers} = require '../..'

module.exports =
  "should include descriptor": (test) ->
    npc = new NPC
    power = new Powers.DragonBreath(npc, "poison")
    test.equal power.descriptor, "poison"
    test.equal power.name, "Dragon breath (poison)"
    test.done()

  "range should be dependent on npc.breath.range": (test) ->
    npc = new NPC
    npc.breath = range: 3
    power = new Powers.DragonBreath(npc, "poison")
    test.equal power.range(), "Close burst 3"
    test.done()

  "attack should be dependent on npc level and breath.ability": (test) ->
    npc = new NPC
    npc.breath = ability: "dex"
    power = new Powers.DragonBreath(npc, "poison")
    test.equal power.attack(), "dex+2 (+2) vs. Reflex"
    npc.level = 11
    test.equal power.attack(), "dex+4 (+4) vs. Reflex"
    npc.abilities.dex.baseValue = 18
    test.equal power.attack(), "dex+4 (+8) vs. Reflex"
    test.done()

  "damage should be dependent on npc level and CON": (test) ->
    npc = new NPC
    power = new Powers.DragonBreath(npc, "poison")
    test.equal power.damage(), "1d6"
    npc.level = 11
    test.equal power.damage(), "2d6"
    npc.abilities.con.baseValue = 18
    test.equal power.damage(), "2d6+4"
    test.done()
