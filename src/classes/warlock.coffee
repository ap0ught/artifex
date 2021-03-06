Powers = require '../powers'

module.exports = class Warlock
  constructor: (npc) ->
    @options = npc.options.warlock ? {}
    @name = Warlock.simpleName
    @powerSource = Warlock.powerSource
    @powerName = "spell"
    @powers = Warlock.powers
    @skills = Warlock.skills
    @keyAttributes = [ "cha", "con", "int" ]

    npc.proficiencies.armor.push "cloth"
    npc.proficiencies.armor.push "leather"

    npc.proficiencies.weapons.push "simple melee"
    npc.proficiencies.weapons.push "simple ranged"

    npc.supportedImplements.push "rod"
    npc.supportedImplements.push "wand"

    npc.defenses.ref.adjust "class", 1
    npc.defenses.will.adjust "class", 1
    npc.hitPoints.adjust "class", 12
    npc.hitPointsPerLevel = 5
    npc.healingSurge.count.adjust "class", 6

    npc.pendingSkills.push count: 4, list: Warlock.skills

    npc.feature "class", "Eldritch Blast"
    eldritchBlast = Powers.get "warlock", "EldritchBlast", npc: npc
    npc.powers.atWill.push eldritchBlast

    npc.when "scoresAssigned", =>
      if npc.abilities.cha.modifier() > npc.abilities.con.modifier()
        eldritchBlast.ability = "cha"
      else
        eldritchBlast.ability = "con"

    pact = @options.pact ? npc.random.pick "Fey", "Infernal", "Star"
    npc.feature "class", "#{pact} Pact"

    switch pact
      when "Fey"
        power = "Eyebite"
        boon  = "Misty Step"
      when "Infernal"
        power = "HellishRebuke"
        boon  = "Dark One's Blessing"
      when "Star"
        power = "DireRadiance"
        boon  = "Fate of the Void"
      else throw new Error "unknown pact `#{pact}'"

    npc.feature "class", "Pact Boon: #{boon}"
    npc.powers.atWill.push Powers.get("warlock", power, npc: npc)

    npc.feature "class", "Prime Shot"
    npc.feature "class", "Shadow Walk"

    npc.feature "class", "Warlock's Curse"
    npc.powers.atWill.push Powers.get("warlock", "WarlocksCurse", npc: npc)

    npc.selectInitialPowers = ->
      @selectPowersFor "encounter", 1
      @selectPowersFor "daily", 1

Warlock.simpleName = "warlock"
Warlock.source = "phb"
Warlock.powerSource = "arcane"
Warlock.skills = [ "arcana", "bluff", "history", "insight", "intimidate", "religion", "streetwise", "thievery" ]

Warlock.powers =
  atWill:
    1: [ "DireRadiance", "EldritchBlast", "Eyebite", "HellishRebuke" ]

  encounter:
    1 : [ "DiabolicGrasp", "DreadfulWord", "VampiricEmbrace", "Witchfire" ]
    3 : [ "EldritchRain", "FieryBolt", "FrigidDarkness", "OtherwindStride" ]
    7 : [ "HowlOfDoom", "InfernalMoonCurse", "MireTheMind", "SignOfIllOmen" ]
    13: [ "BewitchingWhispers", "ColdfireVortex", "Harrowstorm", "SoulFlaying" ]
    17: [ "StrandOfFate", "ThirstingTendrils", "WarlocksBargain" ]

  daily:
    1 : [ "ArmorOfAgathys", "CurseOfTheDarkDream", "DreadStar", "FlamesOfPhlegethos" ]
    5 : [ "AvernianEruption", "CrownOfMadness", "CurseOfTheBloodyFangs", "HungerOfHadar" ]
    9 : [ "CurseOfTheBlackFrost", "IronSpikeOfDis", "SummonsOfKhirad", "ThiefOfFiveFates" ]
    15: [ "CurseOfTheGoldenMist", "Fireswarm", "TendrilsOfThuban", "ThirstingMaw" ]
    19: [ "DelusionsOfLoyalty", "MinionsOfMalbolge", "WrathOfAcamar" ]

  utility:
    2 : [ "BeguilingTongue", "EtherealStride", "FiendishResilience", "ShadowVeil" ]
    6 : [ "DarkOnesOwnLuck", "FeySwitch", "ShroudOfBlackSteel", "SpiderClimb" ]
    10: [ "AmbassadorImp", "ShadowForm", "ShieldingShades", "WarlocksLeap" ]
    16: [ "CloakOfShadow", "EyeOfTheWarlock", "InfuriatingElusiveness" ]
