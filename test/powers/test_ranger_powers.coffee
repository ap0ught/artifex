{Verify} = require '../helpers'

module.exports =
  "[HuntersQuarry] should be defined":
    Verify.testProperties "HuntersQuarry",
      name: [ expect: "Hunter's Quarry" ]
      effect: [
        { level:  1, quarryDie: 6, expect: "deal +1d6 extra damage to quarry per round" },
        { level: 11, quarryDie: 6, expect: "deal +2d6 extra damage to quarry per round" },
        { level: 21, quarryDie: 6, expect: "deal +3d6 extra damage to quarry per round" },
        { level: 21, quarryDie: 8, expect: "deal +3d8 extra damage to quarry per round" } ]

  "[CarefulAttack] should be defined":
    Verify.testProperties "CarefulAttack",
      name: [ expect: "Careful Attack" ]
      keywords: [ expect: [ "martial", "weapon" ] ]
      attack: [
        { str: 10, dex: 10, expect: "+2 vs. AC (melee) or +2 vs. AC (ranged)" },
        { str: 16, dex: 10, expect: "+5 vs. AC (melee) or +2 vs. AC (ranged)" },
        { str: 10, dex: 16, expect: "+2 vs. AC (melee) or +5 vs. AC (ranged)" },
        { str: 16, dex: 16, expect: "+5 vs. AC (melee) or +5 vs. AC (ranged)" } ]
      hit: [
        { level:  1, expect: "1[W] damage" },
        { level: 20, expect: "1[W] damage" },
        { level: 21, expect: "2[W] damage" } ]

  "[HitAndRun] should be defined":
    Verify.testProperties "HitAndRun",
      name: [ expect: "Hit and Run" ]
      keywords: [ expect: [ "martial", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { str: 10, expect: "+0 vs. AC" }, { str: 16, expect: "+3 vs. AC" } ]
      hit: [
        { level:  1, str: 10, expect: "1[W] damage" },
        { level:  1, str: 16, expect: "1[W]+3 damage" },
        { level: 20, str: 16, expect: "1[W]+3 damage" },
        { level: 21, str: 16, expect: "2[W]+3 damage" } ]

  "[NimbleStrike] should be defined":
    Verify.testProperties "NimbleStrike",
      name: [ expect: "Nimble Strike" ]
      keywords: [ expect: [ "martial", "weapon" ] ]
      attackTypes: [ expect: [ "ranged weapon" ] ]
      attack: [ { dex: 10, expect: "+0 vs. AC" }, { dex: 16, expect: "+3 vs. AC" } ]
      hit: [
        { level:  1, dex: 10, expect: "1[W] damage" },
        { level:  1, dex: 16, expect: "1[W]+3 damage" },
        { level: 20, dex: 16, expect: "1[W]+3 damage" },
        { level: 21, dex: 16, expect: "2[W]+3 damage" } ]

  "[TwinStrike] should be defined":
    Verify.testProperties "TwinStrike",
      name: [ expect: "Twin Strike" ]
      keywords: [ expect: [ "martial", "weapon" ] ]
      attack: [
        { str: 10, dex: 10, expect: "+0 vs. AC (melee) or +0 vs. AC (ranged), two attacks" },
        { str: 16, dex: 10, expect: "+3 vs. AC (melee) or +0 vs. AC (ranged), two attacks" },
        { str: 10, dex: 16, expect: "+0 vs. AC (melee) or +3 vs. AC (ranged), two attacks" },
        { str: 16, dex: 16, expect: "+3 vs. AC (melee) or +3 vs. AC (ranged), two attacks" } ]
      hit: [
        { level:  1, expect: "1[W] damage per attack" },
        { level: 20, expect: "1[W] damage per attack" },
        { level: 21, expect: "2[W] damage per attack" } ]

  "[DireWolverineStrike] should be defined":
    Verify.testProperties "DireWolverineStrike",
      name: [ expect: "Dire Wolverine Strike" ]
      keywords: [ expect: [ "martial", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { str: 10, expect: "+0 vs. AC" }, { str: 16, expect: "+3 vs. AC" } ]
      hit: [ { str: 10, expect: "1[W] damage" }, { str: 16, expect: "1[W]+3 damage" } ]

  "[EvasiveStrike] should be defined":
    Verify.testProperties "EvasiveStrike",
      name: [ expect: "Evasive Strike" ]
      keywords: [ expect: [ "martial", "weapon" ] ]
      special: [ { wis: 10, expect: "shift 1 square" }, { wis: 16, expect: "shift 4 squares" } ]
      attack: [
        { str: 10, dex: 10, expect: "+0 vs. AC (melee) or +0 vs. AC (ranged)" },
        { str: 16, dex: 10, expect: "+3 vs. AC (melee) or +0 vs. AC (ranged)" },
        { str: 10, dex: 16, expect: "+0 vs. AC (melee) or +3 vs. AC (ranged)" },
        { str: 16, dex: 16, expect: "+3 vs. AC (melee) or +3 vs. AC (ranged)" } ]
      hit: [
        { str: 10, dex: 10, expect: "2[W] damage (melee) or 2[W] damage (ranged)" },
        { str: 16, dex: 10, expect: "2[W]+3 damage (melee) or 2[W] damage (ranged)" },
        { str: 10, dex: 16, expect: "2[W] damage (melee) or 2[W]+3 damage (ranged)" },
        { str: 16, dex: 16, expect: "2[W]+3 damage (melee) or 2[W]+3 damage (ranged)" } ]

  "[FoxsCunning] should be defined":
    Verify.testProperties "FoxsCunning",
      name: [ expect: "Fox's Cunning" ]
      keywords: [ expect: [ "martial", "weapon" ] ]
      attack: [ { wis: 10, expect: "basic attack +0" }, { wis: 16, expect: "basic attack +3" } ]

  "[TwoFangedStrike] should be defined":
    Verify.testProperties "TwoFangedStrike",
      name: [ expect: "Two-Fanged Strike" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attack: [
        { str: 10, dex: 10, expect: "+0 vs. AC (melee) or +0 vs. AC (ranged), two attacks" },
        { str: 16, dex: 10, expect: "+3 vs. AC (melee) or +0 vs. AC (ranged), two attacks" },
        { str: 10, dex: 16, expect: "+0 vs. AC (melee) or +3 vs. AC (ranged), two attacks" },
        { str: 16, dex: 16, expect: "+3 vs. AC (melee) or +3 vs. AC (ranged), two attacks" } ]
      hit: [
        { str: 10, dex: 10, wis: 10, expect: "1[W] damage (melee) or 1[W] damage (ranged) per attack, +0 if both attacks hit" },
        { str: 16, dex: 10, wis: 10, expect: "1[W]+3 damage (melee) or 1[W] damage (ranged) per attack, +0 if both attacks hit" },
        { str: 10, dex: 16, wis: 10, expect: "1[W] damage (melee) or 1[W]+3 damage (ranged) per attack, +0 if both attacks hit" },
        { str: 16, dex: 16, wis: 10, expect: "1[W]+3 damage (melee) or 1[W]+3 damage (ranged) per attack, +0 if both attacks hit" },
        { str: 16, dex: 16, wis: 16, expect: "1[W]+3 damage (melee) or 1[W]+3 damage (ranged) per attack, +3 if both attacks hit" } ]

  "[HuntersBearTrap] should be defined":
    Verify.testProperties "HuntersBearTrap",
      name: [ expect: "Hunter's Bear Trap" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attack: [
        { str: 10, dex: 10, expect: "+0 vs. AC (melee) or +0 vs. AC (ranged)" },
        { str: 16, dex: 10, expect: "+3 vs. AC (melee) or +0 vs. AC (ranged)" },
        { str: 10, dex: 16, expect: "+0 vs. AC (melee) or +3 vs. AC (ranged)" },
        { str: 16, dex: 16, expect: "+3 vs. AC (melee) or +3 vs. AC (ranged)" } ]
      hit: [
        { str: 10, dex: 10, expect: "2[W] damage (melee) or 2[W] damage (ranged) (special)" },
        { str: 16, dex: 10, expect: "2[W]+3 damage (melee) or 2[W] damage (ranged) (special)" },
        { str: 10, dex: 16, expect: "2[W] damage (melee) or 2[W]+3 damage (ranged) (special)" },
        { str: 16, dex: 16, expect: "2[W]+3 damage (melee) or 2[W]+3 damage (ranged) (special)" } ]

  "[JawsOfTheWolf] should be defined":
    Verify.testProperties "JawsOfTheWolf",
      name: [ expect: "Jaws of the Wolf" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [
        { str: 10, expect: "+0 vs. AC, two attacks" },
        { str: 16, expect: "+3 vs. AC, two attacks" } ]
      hit: [
        { str: 10, expect: "2[W] damage per attack" },
        { str: 16, expect: "2[W]+3 damage per attack" } ]

  "[SplitTheTree] should be defined":
    Verify.testProperties "SplitTheTree",
      name: [ expect: "Split the Tree" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attackTypes: [ expect: [ "ranged weapon" ] ]
      attack: [
        { dex: 10, expect: "+0 vs. AC (special)" },
        { dex: 16, expect: "+3 vs. AC (special)" } ]
      hit: [
        { dex: 10, expect: "2[W] damage" },
        { dex: 16, expect: "2[W]+3 damage" } ]

  "[SuddenStrike] should be defined":
    Verify.testProperties "SuddenStrike",
      name: [ expect: "Sudden Strike" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [
        { str: 10, expect: "+0 vs. AC (special)" },
        { str: 16, expect: "+3 vs. AC (special)" } ]
      hit: [
        { str: 10, expect: "1[W] damage (off-hand) (special, 2[W] damage w/ main weapon)" },
        { str: 16, expect: "1[W] damage (off-hand) (special, 2[W]+3 damage w/ main weapon)" } ]

  "[CrucialAdvice] should be defined":
    Verify.testProperties "CrucialAdvice",
      name: [ expect: "Crucial Advice" ],
      type: [ expect: "encounter" ]
      keywords: [ expect: [ "martial" ] ]
      effect: [
        { wis: 10, expect: "ally rerolls skill check with +0 bonus" },
        { wis: 16, expect: "ally rerolls skill check with +3 bonus" } ]

  "[UnbalancingParry] should be defined":
    Verify.testProperties "UnbalancingParry",
      name: [ expect: "Unbalancing Parry" ],
      type: [ expect: "encounter" ]
      keywords: [ expect: [ "martial", "weapon" ] ]

  "[YieldGround] should be defined":
    Verify.testProperties "YieldGround",
      name: [ expect: "Yield Ground" ],
      type: [ expect: "encounter" ]
      keywords: [ expect: [ "martial" ] ]
      effect: [
        { wis: 10, expect: "shift 0 squares" },
        { wis: 16, expect: "shift 3 squares" } ]

  "[CutAndRun] should be defined":
    Verify.testProperties "CutAndRun",
      name: [ expect: "Cut and Run" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attack: [
        { str: 10, dex: 10, expect: "+0 vs. AC (melee) or +0 vs. AC (ranged) (special)" },
        { str: 16, dex: 10, expect: "+3 vs. AC (melee) or +0 vs. AC (ranged) (special)" },
        { str: 10, dex: 14, expect: "+0 vs. AC (melee) or +2 vs. AC (ranged) (special)" },
        { str: 16, dex: 14, expect: "+3 vs. AC (melee) or +2 vs. AC (ranged) (special)" } ]
      hit: [
        { str: 10, dex: 10, wis: 8, expect: "1[W] damage (melee) or 1[W] damage (ranged), shift 1 square" },
        { str: 10, dex: 10, wis: 10, expect: "1[W] damage (melee) or 1[W] damage (ranged), shift 1 square" },
        { str: 18, dex: 10, wis: 10, expect: "1[W]+4 damage (melee) or 1[W] damage (ranged), shift 1 square" },
        { str: 10, dex: 16, wis: 10, expect: "1[W] damage (melee) or 1[W]+3 damage (ranged), shift 1 square" },
        { str: 10, dex: 10, wis: 14, expect: "1[W] damage (melee) or 1[W] damage (ranged), shift 3 squares" },
        { str: 18, dex: 16, wis: 14, expect: "1[W]+4 damage (melee) or 1[W]+3 damage (ranged), shift 3 squares" } ]

  "[DisruptiveStrike] should be defined":
    Verify.testProperties "DisruptiveStrike",
      name: [ expect: "Disruptive Strike" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attack: [
        { str: 10, dex: 10, expect: "+0 vs. AC (melee) or +0 vs. AC (ranged)" },
        { str: 16, dex: 10, expect: "+3 vs. AC (melee) or +0 vs. AC (ranged)" },
        { str: 10, dex: 14, expect: "+0 vs. AC (melee) or +2 vs. AC (ranged)" },
        { str: 16, dex: 14, expect: "+3 vs. AC (melee) or +2 vs. AC (ranged)" } ]
      hit: [
        { str: 10, dex: 10, wis: 10, expect: "1[W] damage (melee) or 1[W] damage (ranged), target takes -3 attack penalty" },
        { str: 18, dex: 10, wis: 10, expect: "1[W]+4 damage (melee) or 1[W] damage (ranged), target takes -3 attack penalty" },
        { str: 10, dex: 16, wis: 10, expect: "1[W] damage (melee) or 1[W]+3 damage (ranged), target takes -3 attack penalty" },
        { str: 10, dex: 10, wis: 14, expect: "1[W] damage (melee) or 1[W] damage (ranged), target takes -5 attack penalty" },
        { str: 18, dex: 16, wis: 14, expect: "1[W]+4 damage (melee) or 1[W]+3 damage (ranged), target takes -5 attack penalty" } ]

  "[ShadowWaspStrike] should be defined":
    Verify.testProperties "ShadowWaspStrike",
      name: [ expect: "Shadow Wasp Strike" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attack: [
        { str: 10, dex: 10, expect: "+0 vs. AC (melee) or +0 vs. AC (ranged)" },
        { str: 16, dex: 10, expect: "+3 vs. AC (melee) or +0 vs. AC (ranged)" },
        { str: 10, dex: 14, expect: "+0 vs. AC (melee) or +2 vs. AC (ranged)" },
        { str: 16, dex: 14, expect: "+3 vs. AC (melee) or +2 vs. AC (ranged)" } ]
      hit: [
        { str: 10, dex: 10, expect: "2[W] damage (melee) or 2[W] damage (ranged)" },
        { str: 16, dex: 10, expect: "2[W]+3 damage (melee) or 2[W] damage (ranged)" },
        { str: 10, dex: 14, expect: "2[W] damage (melee) or 2[W]+2 damage (ranged)" },
        { str: 16, dex: 14, expect: "2[W]+3 damage (melee) or 2[W]+2 damage (ranged)" } ]

  "[ThundertuskBoarStrike] should be defined":
    Verify.testProperties "ThundertuskBoarStrike",
      name: [ expect: "Thundertusk Boar Strike" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attack: [
        { str: 10, dex: 10, expect: "+0 vs. AC (melee) or +0 vs. AC (ranged) (special)" },
        { str: 16, dex: 10, expect: "+3 vs. AC (melee) or +0 vs. AC (ranged) (special)" },
        { str: 10, dex: 14, expect: "+0 vs. AC (melee) or +2 vs. AC (ranged) (special)" },
        { str: 16, dex: 14, expect: "+3 vs. AC (melee) or +2 vs. AC (ranged) (special)" } ]
      hit: [
        { str: 10, dex: 10, wis: 10, expect: "1[W] damage (melee) or 1[W] damage (ranged), push target 1 square (special)" },
        { str: 16, dex: 10, wis: 10, expect: "1[W]+3 damage (melee) or 1[W] damage (ranged), push target 1 square (special)" },
        { str: 10, dex: 14, wis: 10, expect: "1[W] damage (melee) or 1[W]+2 damage (ranged), push target 1 square (special)" },
        { str: 16, dex: 14, wis: 10, expect: "1[W]+3 damage (melee) or 1[W]+2 damage (ranged), push target 1 square (special)" },
        { str: 16, dex: 14, wis: 18, expect: "1[W]+3 damage (melee) or 1[W]+2 damage (ranged), push target 5 squares (special)" } ]

  "[ExcruciatingShot] should be defined":
    Verify.testProperties "ExcruciatingShot",
      name: [ expect: "Excruciating Shot" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attackTypes: [ expect: [ "ranged weapon" ] ]
      attack: [ { dex: 10, expect: "+0 vs. AC" }, { dex: 16, expect: "+3 vs. AC" } ]
      hit: [
        { dex: 10, expect: "3[W] damage (special)" },
        { dex: 16, expect: "3[W]+3 damage (special)" } ]

  "[FrenziedSkirmish] should be defined":
    Verify.testProperties "FrenziedSkirmish",
      name: [ expect: "Frenzied Skirmish" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [
        { str: 10, expect: "+0 vs. AC (special)" },
        { str: 16, expect: "+3 vs. AC (special)" } ]
      hit: [
        { str: 10, expect: "1[W] damage (special)" },
        { str: 16, expect: "1[W]+3 damage (special)" } ]

  "[SplinteringShot] should be defined":
    Verify.testProperties "SplinteringShot",
      name: [ expect: "Splintering Shot" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attackTypes: [ expect: [ "ranged weapon" ] ]
      attack: [
        { dex: 10, expect: "+0 vs. AC" },
        { dex: 16, expect: "+3 vs. AC" } ]
      hit: [
        { dex: 10, expect: "3[W] damage (special)" },
        { dex: 16, expect: "3[W]+3 damage (special)" } ]

  "[TwoWolfPounce] should be defined":
    Verify.testProperties "TwoWolfPounce",
      name: [ expect: "Two-Wolf Pounce" ],
      keywords: [ expect: [ "martial", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [
        { str: 10, expect: "+0 vs. AC (special)" },
        { str: 16, expect: "+3 vs. AC (special)" } ]
      hit: [
        { str: 10, expect: "2[W] damage (main), 1[W] damage (off-hand) (special)" },
        { str: 16, expect: "2[W]+3 damage (main), 1[W]+3 damage (off-hand) (special)" } ]

  "[EvadeAmbush] should be defined":
    Verify.testProperties "EvadeAmbush",
      name: [ expect: "Evade Ambush" ],
      type: [ expect: "daily" ]
      keywords: [ expect: [ "martial" ] ]
      effect: [
        { wis: 10, expect: "0 allies avoid surprise" },
        { wis: 12, expect: "1 ally avoids surprise" },
        { wis: 16, expect: "3 allies avoid surprise" } ]

  "[SkilledCompanion] should be defined":
    Verify.testProperties "SkilledCompanion",
      name: [ expect: "Skilled Companion" ],
      type: [ expect: "daily" ]
      keywords: [ expect: [ "martial" ] ]
      effect: [
        { wis: 10, expect: "ally gets +0 to skill check" },
        { wis: 16, expect: "ally gets +3 to skill check" } ]

  "[WeaveThroughTheFray] should be defined":
    Verify.testProperties "WeaveThroughTheFray",
      name: [ expect: "Weave through the Fray" ],
      type: [ expect: "encounter" ]
      keywords: [ expect: [ "martial" ] ]
      effect: [
        { wis: 10, expect: "shift 0 squares" },
        { wis: 12, expect: "shift 1 square" },
        { wis: 16, expect: "shift 3 squares" } ]
