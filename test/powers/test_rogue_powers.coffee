{Attribute} = require '../..'
{Verify} = require '../helpers'

sneakAttack = (die, adjust) ->
  (npc) =>
    npc.attacks.sneakAttack ||= new Attribute 0
    npc.attacks.sneakAttack.damageDie = die
    npc.attacks.sneakAttack.adjust adjust

artfulDodger = (npc) -> npc.feature "class", "Artful Dodger"
brutalScoundrel = (npc) -> npc.feature "class", "Brutal Scoundrel"
  
module.exports =
  "[SneakAttack] should be defined":
    Verify.testProperties "SneakAttack",
      name: [ expect: "Sneak Attack" ]
      hit: [
        { level:  1, expect: "+2d6 damage" },
        { level:  1, when: sneakAttack(8, 0), expect: "+2d8 damage" },
        { level:  1, when: sneakAttack(6, 4), expect: "+2d6+4 damage" },
        { level: 11, expect: "+3d6 damage" },
        { level: 21, expect: "+5d6 damage" } ]

  "[DeftStrike] should be defined":
    Verify.testProperties "DeftStrike",
      name: [ expect: "Deft Strike" ]
      attack: [ { dex: 10, expect: "+0 vs. AC" }, { dex: 16, expect: "+3 vs. AC" } ]
      hit: [
        { level:  1, dex: 10, expect: "1[W] damage" },
        { level:  1, dex: 16, expect: "1[W]+3 damage" },
        { level: 21, dex: 16, expect: "2[W]+3 damage" } ]

  "[PiercingStrike] should be defined":
    Verify.testProperties "PiercingStrike",
      name: [ expect: "Piercing Strike" ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { dex: 10, expect: "+0 vs. Reflex" }, { dex: 16, expect: "+3 vs. Reflex" } ]
      hit: [
        { level:  1, dex: 10, expect: "1[W] damage" },
        { level:  1, dex: 16, expect: "1[W]+3 damage" },
        { level: 21, dex: 16, expect: "2[W]+3 damage" } ]

  "[RiposteStrike] should be defined":
    Verify.testProperties "RiposteStrike",
      name: [ expect: "Riposte Strike" ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [
        { dex: 10, str: 10, expect: "+0 vs. AC (special, riposte +0 vs. AC)" },
        { dex: 10, str: 16, expect: "+0 vs. AC (special, riposte +3 vs. AC)" },
        { dex: 16, str: 10, expect: "+3 vs. AC (special, riposte +0 vs. AC)" },
        { dex: 16, str: 16, expect: "+3 vs. AC (special, riposte +3 vs. AC)" } ]
      hit: [
        { level:  1, dex: 10, str: 10, expect: "1[W] damage (special, riposte 1[W] damage)" },
        { level:  1, dex: 16, str: 10, expect: "1[W]+3 damage (special, riposte 1[W] damage)" },
        { level:  1, dex: 10, str: 16, expect: "1[W] damage (special, riposte 1[W]+3 damage)" },
        { level:  1, dex: 16, str: 16, expect: "1[W]+3 damage (special, riposte 1[W]+3 damage)" },
        { level: 21, dex: 16, str: 16, expect: "2[W]+3 damage (special, riposte 2[W]+3 damage)" } ]

  "[SlyFlourish] should be defined":
    Verify.testProperties "SlyFlourish",
      name: [ expect: "Sly Flourish" ]
      attack: [ { dex: 10, expect: "+0 vs. AC" }, { dex: 16, expect: "+3 vs. AC" } ]
      hit: [
        { level:  1, dex: 10, cha: 10, expect: "1[W] damage" },
        { level:  1, dex: 16, cha: 10, expect: "1[W]+3 damage" },
        { level:  1, dex: 10, cha: 14, expect: "1[W]+2 damage" },
        { level:  1, dex: 16, cha: 14, expect: "1[W]+5 damage" },
        { level: 21, dex: 16, cha: 14, expect: "2[W]+5 damage" } ]

  "[DazingStrike] should be defined":
    Verify.testProperties "DazingStrike",
      name: [ expect: "Dazing Strike" ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { dex: 10, expect: "+0 vs. AC" }, { dex: 16, expect: "+3 vs. AC" } ]
      hit: [
        { dex: 10, expect: "1[W] damage (special)" },
        { dex: 16, expect: "1[W]+3 damage (special)" } ]

  "[KingsCastle] should be defined":
    Verify.testProperties "KingsCastle",
      name: [ expect: "King's Castle" ]
      attack: [ { dex: 10, expect: "+0 vs. Reflex" }, { dex: 16, expect: "+3 vs. Reflex" } ]
      hit: [
        { dex: 10, expect: "2[W] damage (special)" },
        { dex: 16, expect: "2[W]+3 damage (special)" } ]

  "[PositioningStrike] should be defined":
    Verify.testProperties "PositioningStrike",
      name: [ expect: "Positioning Strike" ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { dex: 10, expect: "+0 vs. Will" }, { dex: 16, expect: "+3 vs. Will" } ]
      hit: [
        { dex: 10, cha: 10, expect: "1[W] damage, slide target 1 square" },
        { dex: 10, cha: 16, expect: "1[W] damage, slide target 1 square" },
        { dex: 10, cha: 16, when: artfulDodger, expect: "1[W] damage, slide target 3 squares" },
        { dex: 10, cha:  8, when: artfulDodger, expect: "1[W] damage, slide target 1 square" },
        { dex: 14, cha: 16, when: artfulDodger, expect: "1[W]+2 damage, slide target 3 squares" } ]

  "[TorturousStrike] should be defined":
    Verify.testProperties "TorturousStrike",
      name: [ expect: "Torturous Strike" ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { dex: 10, expect: "+0 vs. AC" }, { dex: 16, expect: "+3 vs. AC" } ]
      hit: [
        { dex: 10, str: 10, expect: "2[W] damage" },
        { dex: 14, str: 10, expect: "2[W]+2 damage" },
        { dex: 14, str: 16, expect: "2[W]+2 damage" },
        { dex: 10, str: 16, when: brutalScoundrel, expect: "2[W]+3 damage" },
        { dex: 14, str: 16, when: brutalScoundrel, expect: "2[W]+5 damage" } ]

  "[BlindingBarrage] should be defined":
    Verify.testProperties "BlindingBarrage",
      name: [ expect: "Blinding Barrage" ]
      attack: [ { dex: 10, expect: "+0 vs. AC" }, { dex: 16, expect: "+3 vs. AC" } ]
      hit: [
        { dex: 10, expect: "2[W] damage (special)" },
        { dex: 16, expect: "2[W]+3 damage (special)" } ]

  "[EasyTarget] should be defined":
    Verify.testProperties "EasyTarget",
      name: [ expect: "Easy Target" ]
      attack: [ { dex: 10, expect: "+0 vs. AC" }, { dex: 16, expect: "+3 vs. AC" } ]
      hit: [
        { dex: 10, expect: "2[W] damage (special)" },
        { dex: 16, expect: "2[W]+3 damage (special)" } ]

  "[TrickStrike] should be defined":
    Verify.testProperties "TrickStrike",
      name: [ expect: "Trick Strike" ]
      attack: [ { dex: 10, expect: "+0 vs. AC" }, { dex: 16, expect: "+3 vs. AC" } ]
      hit: [
        { dex: 10, expect: "3[W] damage (special)" },
        { dex: 16, expect: "3[W]+3 damage (special)" } ]