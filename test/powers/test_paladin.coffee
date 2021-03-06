{Verify} = require '../helpers'

module.exports =
  "[DivineMettle] should be defined":
    Verify.testProperties "paladin", "DivineMettle",
      name: [ expect: "Channel Divinity: Divine Mettle" ]
      keywords: [ expect: [ "divine" ] ]
      effect: [
        { cha:  6, expect: "target makes a save with +0 bonus" },
        { cha: 10, expect: "target makes a save with +0 bonus" },
        { cha: 18, expect: "target makes a save with +4 bonus" } ]
    
  "[DivineStrength] should be defined":
    Verify.testProperties "paladin", "DivineStrength",
      name: [ expect: "Channel Divinity: Divine Strength" ]
      keywords: [ expect: [ "divine" ] ]
      effect: [
        { str: 10, expect: "apply +0 extra damage on next attack" },
        { str: 18, expect: "apply +4 extra damage on next attack" } ]
    
  "[DivineChallenge] should be defined":
    Verify.testProperties "paladin", "DivineChallenge",
      name: [ expect: "Divine Challenge" ]
      keywords: [ expect: [ "divine", "radiant" ] ]
      effect: [
        { level: 1, cha: 10, expect: "target takes 3 damage on first attack that excludes you (special)" },
        { level: 1, cha: 16, expect: "target takes 6 damage on first attack that excludes you (special)" },
        { level: 10, cha: 16, expect: "target takes 6 damage on first attack that excludes you (special)" },
        { level: 11, cha: 16, expect: "target takes 9 damage on first attack that excludes you (special)" },
        { level: 20, cha: 16, expect: "target takes 9 damage on first attack that excludes you (special)" },
        { level: 21, cha: 16, expect: "target takes 12 damage on first attack that excludes you (special)" } ]

  "[LayOnHands] should be defined":
    Verify.testProperties "paladin", "LayOnHands",
      name: [ expect: "Lay on Hands" ]
      keywords: [ expect: [ "divine", "healing" ] ]
      frequency: [ { wis: 10, expect: "1/day" }, { wis: 16, expect: "3/day" } ]

  "[BolsteringStrike] should be defined":
    Verify.testProperties "paladin", "BolsteringStrike",
      name: [ expect: "Bolstering Strike" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { cha: 10, expect: "+0 vs. AC" }, { cha: 16, expect: "+3 vs. AC" } ]
      hit: [
        { level:  1, cha: 10, wis: 10, expect: "1[W] damage, +0 temp HP" },
        { level:  1, cha: 16, wis: 10, expect: "1[W]+3 damage, +0 temp HP" },
        { level:  1, cha: 16, wis: 14, expect: "1[W]+3 damage, +2 temp HP" },
        { level: 20, cha: 16, wis: 14, expect: "1[W]+3 damage, +2 temp HP" },
        { level: 21, cha: 16, wis: 14, expect: "2[W]+3 damage, +2 temp HP" } ]

  "[EnfeeblingStrike] should be defined":
    Verify.testProperties "paladin", "EnfeeblingStrike",
      name: [ expect: "Enfeebling Strike" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { cha: 10, expect: "+0 vs. AC" }, { cha: 16, expect: "+3 vs. AC" } ]
      hit: [
        { level:  1, cha: 10, expect: "1[W] damage (special)" },
        { level:  1, cha: 16, expect: "1[W]+3 damage (special)" },
        { level: 20, cha: 16, expect: "1[W]+3 damage (special)" },
        { level: 21, cha: 16, expect: "2[W]+3 damage (special)" } ]

  "[HolyStrike] should be defined":
    Verify.testProperties "paladin", "HolyStrike",
      name: [ expect: "Holy Strike" ]
      keywords: [ expect: [ "divine", "radiant", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { str: 10, expect: "+0 vs. AC" }, { str: 16, expect: "+3 vs. AC" } ]
      hit: [
        { level:  1, str: 10, wis: 10, expect: "1[W] damage (+0 if marked)" },
        { level:  1, str: 16, wis: 10, expect: "1[W]+3 damage (+3 if marked)" },
        { level:  1, str: 16, wis: 14, expect: "1[W]+3 damage (+5 if marked)" },
        { level: 20, str: 16, wis: 14, expect: "1[W]+3 damage (+5 if marked)" },
        { level: 21, str: 16, wis: 14, expect: "2[W]+3 damage (+5 if marked)" } ]

  "[ValiantStrike] should be defined":
    Verify.testProperties "paladin", "ValiantStrike",
      name: [ expect: "Valiant Strike" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [
        { str: 10, expect: "+0 + 1/adjacent enemy vs. AC" },
        { str: 16, expect: "+3 + 1/adjacent enemy vs. AC" } ]
      hit: [
        { level:  1, str: 10, expect: "1[W] damage" },
        { level:  1, str: 16, expect: "1[W]+3 damage" },
        { level: 20, str: 16, expect: "1[W]+3 damage" },
        { level: 21, str: 16, expect: "2[W]+3 damage" } ]

  "[FearsomeSmite] should be defined":
    Verify.testProperties "paladin", "FearsomeSmite",
      name: [ expect: "Fearsome Smite" ]
      keywords: [ expect: [ "divine", "fear", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { cha: 10, expect: "+0 vs. AC" }, { cha: 16, expect: "+3 vs. AC" } ]
      hit: [
        { cha: 10, expect: "2[W] damage (special)" },
        { cha: 16, expect: "2[W]+3 damage (special)" } ]

  "[PiercingSmite] should be defined":
    Verify.testProperties "paladin", "PiercingSmite",
      name: [ expect: "Piercing Smite" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { str: 10, expect: "+0 vs. Reflex" }, { str: 16, expect: "+3 vs. Reflex" } ]
      hit: [
        { str: 10, wis: 10, expect: "2[W] damage, mark target and 0 adjacent enemies" },
        { str: 16, wis: 10, expect: "2[W]+3 damage, mark target and 0 adjacent enemies" },
        { str: 16, wis: 18, expect: "2[W]+3 damage, mark target and 4 adjacent enemies" } ]

  "[RadiantSmite] should be defined":
    Verify.testProperties "paladin", "RadiantSmite",
      name: [ expect: "Radiant Smite" ]
      keywords: [ expect: [ "divine", "radiant", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { str: 10, expect: "+0 vs. AC" }, { str: 16, expect: "+3 vs. AC" } ]
      hit: [
        { str: 10, wis: 10, expect: "2[W]+0 damage" },
        { str: 14, wis: 10, expect: "2[W]+2 damage" },
        { str: 14, wis: 16, expect: "2[W]+5 damage" } ]

  "[ShieldingSmite] should be defined":
    Verify.testProperties "paladin", "ShieldingSmite",
      name: [ expect: "Shielding Smite" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { cha: 10, expect: "+0 vs. AC" }, { cha: 16, expect: "+3 vs. AC" } ]
      hit: [
        { cha: 10, expect: "2[W] damage" },
        { cha: 14, expect: "2[W]+2 damage" } ]
      effect: [
        { wis: 10, expect: "ally w/in 5 squares gets +0 bonus to AC" },
        { wis: 16, expect: "ally w/in 5 squares gets +3 bonus to AC" } ]

  "[OnPainOfDeath] should be defined":
    Verify.testProperties "paladin", "OnPainOfDeath",
      name: [ expect: "On Pain of Death" ]
      keywords: [ expect: [ "divine", "implement" ] ]
      attack: [ { cha: 10, expect: "+0 vs. Will" }, { cha: 16, expect: "+3 vs. Will" } ]
      hit: [
        { cha: 10, expect: "3d8 damage (special)" },
        { cha: 16, expect: "3d8+3 damage (special)" } ]

  "[PaladinsJudgement] should be defined":
    Verify.testProperties "paladin", "PaladinsJudgement",
      name: [ expect: "Paladin's Judgement" ]
      keywords: [ expect: [ "divine", "healing", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { str: 10, expect: "+0 vs. AC" }, { str: 16, expect: "+3 vs. AC" } ]
      hit: [
        { str: 10, expect: "3[W] damage (special)" },
        { str: 16, expect: "3[W]+3 damage (special)" } ]

  "[RadiantDelirium] should be defined":
    Verify.testProperties "paladin", "RadiantDelirium",
      name: [ expect: "Radiant Delirium" ]
      keywords: [ expect: [ "divine", "implement", "radiant" ] ]
      attack: [ { cha: 10, expect: "+0 vs. Reflex" }, { cha: 16, expect: "+3 vs. Reflex" } ]
      hit: [
        { cha: 10, expect: "3d8 damage (special)" },
        { cha: 16, expect: "3d8+3 damage (special)" } ]

  "[AstralSpeech] should be defined":
    Verify.testProperties "paladin", "AstralSpeech",
      name: [ expect: "Astral Speech" ]
      type: [ expect: "daily" ]
      keywords: [ expect: [ "divine" ] ]

  "[MartyrsBlessing] should be defined":
    Verify.testProperties "paladin", "MartyrsBlessing",
      name: [ expect: "Martyr's Blessing" ]
      type: [ expect: "daily" ]
      keywords: [ expect: [ "divine" ] ]

  "[SacredCircle] should be defined":
    Verify.testProperties "paladin", "SacredCircle",
      name: [ expect: "Sacred Circle" ]
      type: [ expect: "daily" ]
      keywords: [ expect: [ "divine", "implement", "zone" ] ]

  "[ArcingSmite] should be defined":
    Verify.testProperties "paladin", "ArcingSmite",
      name: [ expect: "Arcing Smite" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { str: 10, expect: "+0 vs. AC" }, { str: 16, expect: "+3 vs. AC" } ]
      hit: [
        { str: 10, expect: "1[W] damage (special)" },
        { str: 16, expect: "1[W]+3 damage (special)" } ]

  "[InvigoratingSmite] should be defined":
    Verify.testProperties "paladin", "InvigoratingSmite",
      name: [ expect: "Invigorating Smite" ]
      keywords: [ expect: [ "divine", "healing", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { cha: 10, expect: "+0 vs. Will" }, { cha: 16, expect: "+3 vs. Will" } ]
      hit: [
        { cha: 10, wis: 10, expect: "2[W] damage, bloodied allies regain 5 HP" },
        { cha: 10, wis: 14, expect: "2[W] damage, bloodied allies regain 7 HP" },
        { cha: 16, wis: 10, expect: "2[W]+3 damage, bloodied allies regain 5 HP" },
        { cha: 16, wis: 14, expect: "2[W]+3 damage, bloodied allies regain 7 HP" } ]

  "[RighteousSmite] should be defined":
    Verify.testProperties "paladin", "RighteousSmite",
      name: [ expect: "Righteous Smite" ]
      keywords: [ expect: [ "divine", "healing", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { cha: 10, expect: "+0 vs. AC" }, { cha: 16, expect: "+3 vs. AC" } ]
      hit: [
        { cha: 10, wis: 10, expect: "2[W] damage, allies get 5 temp HP" },
        { cha: 10, wis: 14, expect: "2[W] damage, allies get 7 temp HP" },
        { cha: 16, wis: 10, expect: "2[W]+3 damage, allies get 5 temp HP" },
        { cha: 16, wis: 14, expect: "2[W]+3 damage, allies get 7 temp HP" } ]

  "[StaggeringSmite] should be defined":
    Verify.testProperties "paladin", "StaggeringSmite",
      name: [ expect: "Staggering Smite" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [ { str: 10, expect: "+0 vs. AC" }, { str: 16, expect: "+3 vs. AC" } ]
      hit: [
        { str: 10, wis: 10, expect: "2[W] damage" },
        { str: 10, wis: 12, expect: "2[W] damage, target pushed 1 square" },
        { str: 10, wis: 14, expect: "2[W] damage, target pushed 2 squares" },
        { str: 16, wis: 10, expect: "2[W]+3 damage" },
        { str: 16, wis: 14, expect: "2[W]+3 damage, target pushed 2 squares" } ]

  "[HallowedCircle] should be defined":
    Verify.testProperties "paladin", "HallowedCircle",
      name: [ expect: "Hallowed Circle" ]
      keywords: [ expect: [ "divine", "implement", "zone" ] ]
      attack: [ { cha: 10, expect: "+0 vs. Reflex" }, { cha: 16, expect: "+3 vs. Reflex" } ]
      hit: [ { cha: 10, expect: "2d6 damage" }, { cha: 16, expect: "2d6+3 damage" } ]

  "[MartyrsRetribution] should be defined":
    Verify.testProperties "paladin", "MartyrsRetribution",
      name: [ expect: "Martyr's Retribution" ]
      keywords: [ expect: [ "divine", "radiant", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [
        { str: 10, expect: "+0 vs. AC (special)" },
        { str: 16, expect: "+3 vs. AC (special)" } ]
      hit: [ { str: 10, expect: "4[W] damage" }, { str: 16, expect: "4[W]+3 damage" } ]

  "[SignOfVulnerability] should be defined":
    Verify.testProperties "paladin", "SignOfVulnerability",
      name: [ expect: "Sign of Vulnerability" ]
      keywords: [ expect: [ "divine", "implement", "radiant" ] ]
      attack: [
        { cha: 10, expect: "+0 vs. Fortitude" },
        { cha: 16, expect: "+3 vs. Fortitude" } ]
      hit: [
        { cha: 10, expect: "3d8 damage (special)" },
        { cha: 16, expect: "3d8+3 damage (special)" } ]

  "[DivineBodyguard] should be defined":
    Verify.testProperties "paladin", "DivineBodyguard",
      name: [ expect: "Divine Bodyguard" ]
      type: [expect: "daily" ]
      keywords: [ expect: [ "divine" ] ]

  "[OneHeartOneMind] should be defined":
    Verify.testProperties "paladin", "OneHeartOneMind",
      name: [ expect: "One Heart, One Mind" ]
      type: [ expect: "daily" ]
      keywords: [ expect: [ "divine" ] ]

  "[WrathOfTheGods] should be defined":
    Verify.testProperties "paladin", "WrathOfTheGods",
      name: [ expect: "Wrath of the Gods" ]
      type: [ expect: "daily" ]
      keywords: [ expect: [ "divine" ] ]
      effect: [
        { cha: 10, expect: "targets add +0 to damage rolls" },
        { cha: 16, expect: "targets add +3 to damage rolls" } ]

  "[BeckonFoe] should be defined":
    Verify.testProperties "paladin", "BeckonFoe",
      name: [ expect: "Beckon Foe" ]
      keywords: [ expect: [ "divine", "implement" ] ]
      attack: [ { cha: 10, expect: "+0 vs. Will" }, { cha: 16, expect: "+3 vs. Will" } ]
      hit: [
        { cha: 10, wis: 8, expect: "2d10 damage" },
        { cha: 10, wis: 10, expect: "2d10 damage" },
        { cha: 10, wis: 12, expect: "2d10 damage, pull target 1 square" },
        { cha: 10, wis: 14, expect: "2d10 damage, pull target 2 squares" },
        { cha: 16, wis: 10, expect: "2d10+3 damage" },
        { cha: 16, wis: 14, expect: "2d10+3 damage, pull target 2 squares" } ]

  "[BenignTransposition] should be defined":
    Verify.testProperties "paladin", "BenignTransposition",
      name: [ expect: "Benign Transposition" ]
      keywords: [ expect: [ "divine", "teleportation", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      target: [
        { wis: 10, expect: "one ally within 1 square (primary)" },
        { wis: 16, expect: "one ally within 3 squares (primary)" } ]
      attack: [
        { cha: 10, expect: "+0 vs. AC (secondary)" },
        { cha: 16, expect: "+3 vs. AC (secondary)" } ]
      hit: [
        { cha: 10, expect: "2[W] damage (secondary)" },
        { cha: 16, expect: "2[W]+3 damage (secondary)" } ]

  "[DivineReverence] should be defined":
    Verify.testProperties "paladin", "DivineReverence",
      name: [ expect: "Divine Reverence" ]
      keywords: [ expect: [ "divine", "implement", "radiant" ] ]
      attack: [ { cha: 10, expect: "+0 vs. Will" }, { cha: 16, expect: "+3 vs. Will" } ]
      hit: [
        { cha: 10, expect: "1d8 damage (special)" },
        { cha: 16, expect: "1d8+3 damage (special)" } ]

  "[ThunderSmite] should be defined":
    Verify.testProperties "paladin", "ThunderSmite",
      name: [ expect: "Thunder Smite" ]
      keywords: [ expect: [ "divine", "thunder", "weapon" ] ]
      attackTypes: [ expect: [ "melee weapon" ] ]
      attack: [
        { str: 10, expect: "+0 vs. AC (special)" },
        { str: 16, expect: "+3 vs. AC (special)" } ]
      hit: [
        { str: 10, expect: "2[W] damage (special)" },
        { str: 16, expect: "2[W]+3 damage (special)" } ]

  "[CrownOfGlory] should be defined":
    Verify.testProperties "paladin", "CrownOfGlory",
      name: [ expect: "Crown of Glory" ]
      keywords: [ expect: [ "divine", "implement", "radiant" ] ]
      attack: [ { cha: 10, expect: "+0 vs. Will" }, { cha: 16, expect: "+3 vs. Will" } ]
      hit: [
        { cha: 10, expect: "2d8 damage (special)" },
        { cha: 16, expect: "2d8+3 damage (special)" } ]

  "[OneStandsAlone] should be defined":
    Verify.testProperties "paladin", "OneStandsAlone",
      name: [ expect: "One Stands Alone" ]
      keywords: [ expect: [ "divine", "implement", "radiant" ] ]
      attack: [ { cha: 10, expect: "+0 vs. Will" }, { cha: 16, expect: "+3 vs. Will" } ]
      hit: [
        { cha: 10, expect: "2d8 damage (special)" },
        { cha: 16, expect: "2d8+3 damage (special)" } ]

  "[RadiantPulse] should be defined":
    Verify.testProperties "paladin", "RadiantPulse",
      name: [ expect: "Radiant Pulse" ]
      keywords: [ expect: [ "divine", "implement", "radiant" ] ]
      attack: [
        { cha: 10, expect: "+0 vs. Fortitude" },
        { cha: 16, expect: "+3 vs. Fortitude" } ]
      hit: [
        { cha: 10, expect: "1d10 damage (special)" },
        { cha: 16, expect: "1d10+3 damage (special)" } ]

  "[CleansingSpirit] should be defined":
    Verify.testProperties "paladin", "CleansingSpirit",
      name: [ expect: "Cleansing Spirit" ]
      type: [expect: "encounter" ]
      keywords: [ expect: [ "divine" ] ]

  "[NobleShield] should be defined":
    Verify.testProperties "paladin", "NobleShield",
      name: [ expect: "Noble Shield" ]
      type: [expect: "daily" ]
      keywords: [ expect: [ "divine" ] ]

  "[TurnTheTide] should be defined":
    Verify.testProperties "paladin", "TurnTheTide",
      name: [ expect: "Turn the Tide" ]
      type: [expect: "daily" ]
      keywords: [ expect: [ "divine" ] ]

  "[EntanglingSmite] should be defined":
    Verify.testProperties "paladin", "EntanglingSmite",
      name: [ expect: "Entangling Smite" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      requires: [ expect: { weapon: "melee" } ]

  "[RadiantCharge] should be defined":
    Verify.testProperties "paladin", "RadiantCharge",
      name: [ expect: "Radiant Charge" ]
      keywords: [ expect: [ "divine", "radiant", "weapon" ] ]
      requires: [ expect: { weapon: "melee" } ]

  "[RenewingSmite] should be defined":
    Verify.testProperties "paladin", "RenewingSmite",
      name: [ expect: "Renewing Smite" ]
      keywords: [ expect: [ "divine", "healing", "weapon" ] ]
      requires: [ expect: { weapon: "melee" } ]

  "[WhirlwindSmite] should be defined":
    Verify.testProperties "paladin", "WhirlwindSmite",
      name: [ expect: "Whirlwind Smite" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      requires: [ expect: { weapon: "melee" } ]

  "[BloodiedRetribution] should be defined":
    Verify.testProperties "paladin", "BloodiedRetribution",
      name: [ expect: "Bloodied Retribution" ]
      keywords: [ expect: [ "divine", "healing", "weapon" ] ]
      requires: [ expect: { weapon: "melee" } ]

  "[BreakTheWall] should be defined":
    Verify.testProperties "paladin", "BreakTheWall",
      name: [ expect: "Break the Wall" ]
      keywords: [ expect: [ "divine", "implement" ] ]
      requires: [ expect: undefined ]

  "[TrueNemesis] should be defined":
    Verify.testProperties "paladin", "TrueNemesis",
      name: [ expect: "True Nemesis" ]
      keywords: [ expect: [ "divine", "implement" ] ]
      requires: [ expect: undefined ]

  "[AngelicIntercession] should be defined":
    Verify.testProperties "paladin", "AngelicIntercession",
      name: [ expect: "Angelic Intercession" ]
      type: [ expect: "daily" ]
      keywords: [ expect: [ "divine", "teleportation" ] ]
      requires: [ expect: undefined ]

  "[DeathWard] should be defined":
    Verify.testProperties "paladin", "DeathWard",
      name: [ expect: "Death Ward" ]
      type: [ expect: "daily" ]
      keywords: [ expect: [ "divine", "healing" ] ]
      requires: [ expect: undefined ]

  "[EnervatingSmite] should be defined":
    Verify.testProperties "paladin", "EnervatingSmite",
      name: [ expect: "Enervating Smite" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      requires: [ expect: { weapon: "melee" } ]

  "[FortifyingSmite] should be defined":
    Verify.testProperties "paladin", "FortifyingSmite",
      name: [ expect: "Fortifying Smite" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      requires: [ expect: { weapon: "melee" } ]

  "[HandOfTheGods] should be defined":
    Verify.testProperties "paladin", "HandOfTheGods",
      name: [ expect: "Hand of the Gods" ]
      keywords: [ expect: [ "divine", "implement", "radiant" ] ]
      requires: [ expect: undefined ]

  "[TerrifyingSmite] should be defined":
    Verify.testProperties "paladin", "TerrifyingSmite",
      name: [ expect: "Terrifying Smite" ]
      keywords: [ expect: [ "divine", "fear", "weapon" ] ]
      requires: [ expect: { weapon: "melee" } ]

  "[CoronaOfBlindingRadiance] should be defined":
    Verify.testProperties "paladin", "CoronaOfBlindingRadiance",
      name: [ expect: "Corona of Blinding Radiance" ]
      keywords: [ expect: [ "divine", "radiant", "weapon" ] ]
      requires: [ expect: { weapon: "melee" } ]

  "[CrusadersBoon] should be defined":
    Verify.testProperties "paladin", "CrusadersBoon",
      name: [ expect: "Crusader's Boon" ]
      keywords: [ expect: [ "divine", "weapon" ] ]
      requires: [ expect: { weapon: "melee" } ]

  "[RighteousInferno] should be defined":
    Verify.testProperties "paladin", "RighteousInferno",
      name: [ expect: "Righteous Inferno" ]
      keywords: [ expect: [ "divine", "fire", "implement", "zone" ] ]
      requires: [ expect: undefined ]
