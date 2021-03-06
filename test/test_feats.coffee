{Classes, NPC, Feats, Powers, Races} = require '..'

hasPower = (collection, id, category) ->
  (npc) ->
    category ||= "atWill"
    npc.powers[category].push Powers.get(collection, id, npc: npc)

equippedWith = (item) ->
  (npc) -> npc.equipment.push(item)

hasPact = (pact) ->
  (npc) -> npc.feature "class", "#{pact} Pact"

hasPresence = (presence) ->
  (npc) -> npc.feature "class", "#{presence} Presence"

featDefined = (id, expectations) ->
  (test) ->
    feat = Feats[id]

    configureNPC = (conditions) ->
      npc = new NPC
      for attribute, value of conditions
        switch attribute
          when "str", "con", "dex", "int", "int_", "wis", "cha"
            npc.abilities[attribute].baseValue = value
          when "race"
            npc.race = { name: value, is: (name) -> name is @name }
          when "class"
            npc.class = name: value
          when "deity"
            npc.deity = value
          when "trained"
            for skill in value
              npc.skills[skill].trained = true
          when "feature"
            for category, features of value
              for feature in features
                npc.feature category, feature
          when "proficiencies"
            for category, list of value
              for item in list
                npc.proficiencies[category].push(item)
          when "weapon"
            npc.equipment.push(value)
          when "when"
            value(npc)
          else throw new Error "unsupported configure attribute: `#{attribute}'"
      npc

    for name, value of expectations
      switch name
        when "name"
          test.equal feat.name, value, "expected `#{id}' to be named `#{value}'"
        when "multiple"
          test.equal feat.multiple, value, "expected multiple to be `#{value}'"
        when "allows"
          for conditions in value
            test.ok feat.allows(configureNPC(conditions)), "`#{id}' should allow #{conditions}"
        when "disallows"
          for conditions in value
            test.ok !feat.allows(configureNPC(conditions)), "`#{id}' should disallow #{conditions}"
        when "grants"
          npc = configureNPC(value.setup ? {})
          feat.applyTo npc

          for grant, adjustment of value
            switch grant
              when "setup" then # ignore, this was handled when the NPC was configured
              when "skill"
                for skill, bonus of adjustment
                  test.ok npc.skills[skill].has(bonus...), "`#{id}' should grant #{bonus} to `#{skill}'"
              when "power"
                for category, list of adjustment
                  for power in list
                    test.ok npc.powers.find(category, power), "should have `#{power}' as #{category} power"
              when "proficiencies"
                for category, list of adjustment
                  for item in list
                    test.ok item in npc.proficiencies[category], "should have #{category} proficiency with `#{item}'"
              when "property"
                for name, value of adjustment
                  test.equal npc[name], value
              when "tests"
                for name, fn of adjustment
                  test.ok fn(npc), "expected test `#{name}' to be true"
              else throw new Error "unsupported grant: `#{grant}'"
    test.done()
            
module.exports =
  "[ActionSurge] should be defined":
    featDefined "ActionSurge",
      name: "Action Surge"
      allows: [{ race: "human" }]
      disallows: [{ race: "dragonborn" }]

  "[AgileHunter] should be defined":
    featDefined "AgileHunter",
      name: "Agile Hunter"
      allows: [
        { dex: 15, class: "ranger", feature: { class: ["Hunter's Quarry"] } } ]

      disallows: [
        { dex: 14, class: "ranger", feature: { class: ["Hunter's Quarry"] } },
        { dex: 15, class: "cleric", feature: { class: ["Hunter's Quarry"] } },
        { dex: 15, class: "ranger" } ]

  "[Alertness] should be defined":
    featDefined "Alertness",
      name: "Alertness"
      grants:
        skill: { perception: [2, "feat"] }

  "[ArmorOfBahamut] should be defined":
    featDefined "ArmorOfBahamut",
      name: "Armor of Bahamut"
      allows: [ { feature: { class: ["Channel Divinity"] }, deity: "Bahamut" } ]
      disallows: [
        { feature: { class: ["Channel Divinity"] }, deity: "Pelor" },
        { feature: { class: ["Hunter's Quarry"] }, deity: "Bahamut" } ]
      grants:
        power:
          encounter: [ "Channel Divinity: Armor of Bahamut" ]

  "[ChainmailProficiency] should be defined":
    featDefined "ChainmailProficiency",
      name: "Armor Proficiency (Chainmail)"
      allows: [
        { str: 13, con: 13, proficiencies: { armor: [ "leather" ] } },
        { str: 13, con: 13, proficiencies: { armor: [ "hide" ] } } ]
      disallows: [
        { str: 12, con: 13, proficiencies: { armor: [ "leather" ] } },
        { str: 13, con: 12, proficiencies: { armor: [ "hide" ] } },
        { str: 13, con: 13, proficiencies: { armor: [ "cloth" ] } },
        { str: 13, con: 13, proficiencies: { armor: [ "leather", "chainmail" ] } } ],
      grants:
        proficiencies:
          armor: [ "chainmail" ]

  "[HideProficiency] should be defined":
    featDefined "HideProficiency",
      name: "Armor Proficiency (Hide)"
      allows: [ { str: 13, con: 13, proficiencies: { armor: [ "leather" ] } } ]
      disallows: [
        { str: 12, con: 13, proficiencies: { armor: [ "leather" ] } },
        { str: 13, con: 13 },
        { str: 13, con: 13, proficiencies: { armor: [ "hide" } ] } ]
      grants:
        proficiencies:
          armor: [ "hide" ]

  "[LeatherProficiency] should be defined":
    featDefined "LeatherProficiency",
      name: "Armor Proficiency (Leather)"
      disallows: [ { proficiencies: { armor: [ "leather" ] } } ]
      grants:
        proficiencies:
          armor: [ "leather" ]

  "[PlateProficiency] should be defined":
    featDefined "PlateProficiency",
      name: "Armor Proficiency (Plate)"
      allows: [ { str: 15, con: 15, proficiencies: { armor: [ "scale" ] } } ]
      disallows: [
        { str: 14, con: 15, proficiencies: { armor: [ "scale" ] } },
        { str: 15, con: 14, proficiencies: { armor: [ "scale" ] } },
        { str: 15, con: 15, proficiencies: { armor: [ "chainmail" ] } },
        { str: 15, con: 15, proficiencies: { armor: [ "plate" ] } } ]
      grants:
        proficiencies:
          armor: [ "plate" ]

  "[ScaleProficiency] should be defined":
    featDefined "ScaleProficiency",
      name: "Armor Proficiency (Scale)"
      allows: [ { str: 13, con: 13, proficiencies: { armor: [ "chainmail" ] } } ]
      disallows: [
        { str: 12, con: 13, proficiencies: { armor: [ "chainmail" ] } },
        { str: 13, con: 12, proficiencies: { armor: [ "chainmail" ] } },
        { str: 13, con: 13, proficiencies: { armor: [ "scale" ] } } ]
      grants:
        proficiencies:
          armor: [ "scale" ]

  "[AstralFire] should be defined":
    featDefined "AstralFire",
      name: "Astral Fire"
      allows: [ { dex: 13, cha: 13 } ]
      disallows: [ { dex: 12, cha: 13 }, { dex: 13, cha: 12 } ]

  "[AvandrasRescue] should be defined":
    featDefined "AvandrasRescue",
      name: "Avandra's Rescue"
      allows: [ { feature: { class: ["Channel Divinity"] }, deity: "Avandra" } ]
      disallows: [
        { feature: { class: ["Channel Divinity"] }, deity: "Pelor" },
        { feature: { class: ["Hunter's Quarry"] }, deity: "Avandra" } ]
      grants:
        power:
          encounter: [ "Channel Divinity: Avandra's Rescue" ]

  "[Backstabber] should be defined":
    featDefined "Backstabber",
      name: "Backstabber"
      allows: [ { class: "rogue", feature: { class: ["Sneak Attack"] } } ]
      disallows: [
        { class: "wizard", feature: { class: ["Sneak Attack"] } },
        { class: "rogue" } ]
      grants:
        tests:
          damageDie: (npc) -> npc.attacks.sneakAttack.damageDie is 8

  "[BladeOpportunist] should be defined":
    featDefined "BladeOpportunist",
      name: "Blade Opportunist"
      allows: [ { str: 13, dex: 13 } ]
      disallows: [ { str: 12, dex: 13 }, { str: 13, dex: 12 } ]

  "[BurningBlizzard] should be defined":
    featDefined "BurningBlizzard",
      name: "Burning Blizzard"
      allows: [
        { int_: 13, wis: 13, when: hasPower("wizard", "AcidArrow") },
        { int_: 13, wis: 13, when: hasPower("warlock", "ArmorOfAgathys") } ]
      disallows: [
        { int_: 13, wis: 13, when: hasPower("wizard", "BurningHands") },
        { int_: 12, wis: 13, when: hasPower("wizard", "AcidArrow") },
        { int_: 13, wis: 12, when: hasPower("wizard", "AcidArrow") } ]
      grants:
        tests:
          conditionalBonus: (npc) ->
            npc.attacks.general.adjustment("acid") is 1 and
              npc.attacks.general.adjustment("cold") is 1
          paragonLevelDependentBonus: (npc) ->
            npc.level = 11
            npc.attacks.general.adjustment("acid") is 2 and
              npc.attacks.general.adjustment("cold") is 2
          epicLevelDependentBonus: (npc) ->
            npc.level = 21
            npc.attacks.general.adjustment("acid") is 3 and
              npc.attacks.general.adjustment("cold") is 3

  "[CombatReflexes] should be defined":
    featDefined "CombatReflexes",
      name: "Combat Reflexes"
      allows: [ dex: 13 ]
      disallows: [ dex: 12 ]
      grants:
        tests:
          conditionalBonus: (npc) ->
            npc.attacks.general.has 1, "feat", "opportunity attack"

  "[CorellonsGrace] should be defined":
    featDefined "CorellonsGrace",
      name: "Corellon's Grace"
      allows: [ { feature: { class: ["Channel Divinity"] }, deity: "Corellon" } ]
      disallows: [
        { feature: { class: ["Channel Divinity"] }, deity: "Pelor" },
        { feature: { class: ["Hunter's Quarry"] }, deity: "Corellon" } ]
      grants:
        power:
          encounter: [ "Channel Divinity: Corellon's Grace" ]

  "[DarkFury] should be defined":
    featDefined "DarkFury",
      name: "Dark Fury"
      allows: [
        { con: 13, wis: 13, when: hasPower("warlock", "VampiricEmbrace") },
        { con: 13, wis: 13, when: hasPower("warlock", "Eyebite") } ]
      disallows: [
        { con: 13, wis: 13, when: hasPower("wizard", "BurningHands") },
        { con: 12, wis: 13, when: hasPower("warlock", "Eyebite") },
        { con: 13, wis: 12, when: hasPower("warlock", "Eyebite") } ]
      grants:
        tests:
          conditionalBonus: (npc) ->
            npc.attacks.general.adjustment("necrotic") is 1 and
              npc.attacks.general.adjustment("psychic") is 1
          paragonLevelDependentBonus: (npc) ->
            npc.level = 11
            npc.attacks.general.adjustment("necrotic") is 2 and
              npc.attacks.general.adjustment("psychic") is 2
          epicLevelDependentBonus: (npc) ->
            npc.level = 21
            npc.attacks.general.adjustment("necrotic") is 3 and
              npc.attacks.general.adjustment("psychic") is 3

  "[DefensiveMobility] should be defined":
    featDefined "DefensiveMobility",
      name: "Defensive Mobility"
      allows: [ {} ]
      grants:
        tests:
          conditionalBonus: (npc) ->
            npc.defenses.ac.has 2, "feat", "vs opportunity attack"

  "[DistractingShield] should be defined":
    featDefined "DistractingShield",
      name: "Distracting Shield"
      allows: [
        { wis: 15, class: "fighter", feature: { class: ["Combat Challenge"] }, when: equippedWith("light shield") },
        { wis: 15, class: "fighter", feature: { class: ["Combat Challenge"] }, when: equippedWith("heavy shield") } ]
      disallows: [
        { wis: 14, class: "fighter", feature: { class: ["Combat Challenge"] }, when: equippedWith("light shield") },
        { wis: 15, class: "rogue", feature: { class: ["Combat Challenge"] }, when: equippedWith("light shield") },
        { wis: 15, class: "fighter", feature: { class: ["Ballet-a-thon"] }, when: equippedWith("light shield") },
        { wis: 15, class: "fighter", feature: { class: ["Combat Challenge"] } } ]

  "[DodgeGiants] should be defined":
    featDefined "DodgeGiants",
      name: "Dodge Giants"
      allows: [ race: "dwarf" ]
      disallows: [ race: "human" ]
      grants:
        tests:
          conditionalBonus: (npc) ->
            npc.defenses.ac.has(1, "feat", "vs large") and
              npc.defenses.ref.has(1, "feat", "vs large")

  "[DragonbornFrenzy] should be defined":
    featDefined "DragonbornFrenzy",
      name: "Dragonborn Frenzy"
      allows: [ race: "dragonborn" ]
      disallows: [ race: "human" ]
      grants:
        tests:
          conditionalBonus: (npc) ->
            npc.damage.general.has(2, "feat", "bloodied")

  "[DragonbornSenses] should be defined":
    featDefined "DragonbornSenses",
      name: "Dragonborn Senses"
      allows: [ race: "dragonborn" ]
      disallows: [ race: "human" ]
      grants:
        tests:
          lowLightVision: (npc) ->
            npc.vision is "low-light"

  "[Durable] should be defined":
    featDefined "Durable",
      name: "Durable"
      allows: [ {} ]
      grants:
        tests:
          moreHealingSurges: (npc) ->
            npc.healingSurge.count.has 2, "feat"

  "[DwarvenWeaponTraining] should be defined":
    featDefined "DwarvenWeaponTraining",
      name: "Dwarven Weapon Training"
      allows: [ race: "dwarf" ]
      disallows: [ race: "human" ]
      grants:
        proficiencies:
          weapons: [ "axe", "hammer" ]
        tests:
          conditionalBonus: (npc) ->
            npc.damage.general.has(2, "feat", "axe") and
              npc.damage.general.has(2, "feat", "hammer")

  "[EladrinSoldier] should be defined":
    featDefined "EladrinSoldier",
      name: "Eladrin Soldier"
      allows: [ race: "eladrin" ]
      disallows: [ race: "human" ]
      grants:
        proficiencies:
          weapons: [ "spear" ]
        tests:
          conditionalBonus: (npc) ->
            npc.damage.general.has(2, "feat", "longsword") and
              npc.damage.general.has(2, "feat", "spear")

  "[ElvenPrecision] should be defined":
    featDefined "ElvenPrecision",
      name: "Elven Precision"
      allows: [ race: "elf", when: hasPower("racial", "ElvenAccuracy", "encounter") ]
      disallows: [
        { race: "human", when: hasPower("racial", "ElvenAccuracy", "encounter") },
        { race: "elf" } ]
      grants:
        setup:
          when: hasPower "racial", "ElvenAccuracy", "encounter"
        tests:
          attackBonus: (npc) ->
            power = npc.powers.firstThat (whence, p) -> p.id is "ElvenAccuracy"
            power.bonus.has(2, "feat")

  "[EnlargedDragonBreath] should be defined":
    featDefined "EnlargedDragonBreath",
      name: "Enlarged Dragon Breath",
      allows: [ race: "dragonborn", when: hasPower("racial", "DragonBreath", "encounter") ],
      disallows: [
        { race: "human" },
        { race: "dragonborn" },
        { race: "human", when: hasPower("racial", "DragonBreath", "encounter") } ]
      grants:
        setup:
          when: (npc) -> npc.breath = {}
        tests:
          increasedRange: (npc) -> npc.breath.range is 5

  "[EscapeArtist] should be defined":
    featDefined "EscapeArtist",
      name: "Escape Artist"
      allows: [ trained: [ "acrobatics" ] ]
      disallows: [ trained: [ "athletics" ] ]
      grants:
        skill: { acrobatics: [2, "feat"] }

  "[ExpandedSpellbook] should be defined":
    featDefined "ExpandedSpellbook",
      name: "Expanded Spellbook"
      allows: [ wis: 13, class: "wizard" ]
      disallows: [
        { wis: 12, class: "wizard" },
        { wis: 13, class: "warlock" } ]
      grants:
        setup:
          when: (npc) ->
            npc.class = new Classes.Wizard(npc)
            npc.level = 9
        tests:
          shouldAddExtraDailyOfEachLevel: (npc) ->
            npc.powers.daily.length is 3 # 1, 5, 9
          shouldDefine_advanceItem_Daily: (npc) ->
            before = npc.powers.daily.length
            npc.advanceItem_Daily(npc)
            npc.powers.daily.length is before+3

  "[FarShot] should be defined":
    featDefined "FarShot",
      name: "Far Shot"
      allows: [
        { dex: 13, weapon: "longbow" },
        { dex: 13, weapon: "crossbow" } ]
      disallows: [
        { dex: 13, weapon: "longsword" },
        { dex: 13, weapon: "shuriken" },
        { dex: 12, weapon: "longbow" } ]

  "[FarThrow] should be defined":
    featDefined "FarThrow",
      name: "Far Throw"
      allows: [
        { str: 13, weapon: "shuriken" },
        { str: 13, weapon: "dagger" } ]
      disallows: [
        { str: 13, weapon: "longsword" },
        { str: 12, weapon: "longbow" } ]

  "[FastRunner] should be defined":
    featDefined "FastRunner",
      name: "Fast Runner"
      allows: [ con: 13 ]
      disallows: [ con: 12 ]

  "[FerociousRebuke] should be defined":
    featDefined "FerociousRebuke",
      name: "Ferocious Rebuke"
      allows: [ race: "tiefling" ]
      disallows: [ race: "human" ]

  "[GroupInsight] should be defined":
    featDefined "GroupInsight",
      name: "Group Insight"
      allows: [ race: "half-elf" ]
      disallows: [ race: "dwarf" ]

  "[HalflingAgility] should be defined":
    featDefined "HalflingAgility",
      name: "Halfling Agility"
      allows: [ race: "halfling" ]
      disallows: [ race: "dwarf" ]

  "[HarmonyOfErathis] should be defined":
    featDefined "HarmonyOfErathis",
      name: "Harmony of Erathis"
      allows: [ { feature: { class: ["Channel Divinity"] }, deity: "Erathis" } ]
      disallows: [
        { feature: { class: ["Channel Divinity"] }, deity: "Pelor" },
        { feature: { class: ["Hunter's Quarry"] }, deity: "Erathis" } ]
      grants:
        power:
          encounter: [ "Channel Divinity: Harmony of Erathis" ]

  "[HealingHands] should be defined":
    featDefined "HealingHands",
      name: "Healing Hands"
      allows: [ class: "paladin", when: hasPower("paladin", "LayOnHands", "encounter") ]
      disallows: [
        { class: "paladin" },
        { class: "rogue", when: hasPower("paladin", "LayOnHands", "encounter") } ]

  "[HellfireBlood] should be defined":
    featDefined "HellfireBlood",
      name: "Hellfire Blood"
      allows: [ race: "tiefling" ]
      disallows: [ race: "human" ]

  "[HumanPerseverance] should be defined":
    featDefined "HumanPerseverance",
      name: "Human Perseverance"
      allows: [ race: "human" ]
      disallows: [ race: "dwarf" ]
      grants:
        tests:
          "should grant +1 feat bonus to saving throws": (npc) ->
            npc.defenses.save.has 1, "feat"

  "[ImprovedDarkOnesBlessing] should be defined":
    featDefined "ImprovedDarkOnesBlessing",
      name: "Improved Dark One's Blessing"
      allows: [ con: 15, class: "warlock", when: hasPact("Infernal") ]
      disallows: [
        { con: 15, class: "warlock", when: hasPact("Fey") },
        { con: 14, class: "warlock", when: hasPact("Infernal") },
        { con: 15, class: "wizard", when: hasPact("Infernal") } ]

  "[ImprovedFateOfTheVoid] should be defined":
    featDefined "ImprovedFateOfTheVoid",
      name: "Improved Fate of the Void"
      allows: [
        { con: 13, cha: 12, class: "warlock", when: hasPact("Star") },
        { con: 12, cha: 13, class: "warlock", when: hasPact("Star") } ]
      disallows: [
        { con: 13, cha: 12, class: "warlock", when: hasPact("Fey") },
        { con: 12, cha: 13, class: "warlock", when: hasPact("Fey") },
        { con: 12, cha: 12, class: "warlock", when: hasPact("Star") },
        { con: 13, cha: 13, class: "wizard", when: hasPact("Star") } ]

  "[ImprovedInitiative] should be defined":
    featDefined "ImprovedInitiative",
      name: "Improved Initiative"
      allows: [ {} ]
      grants:
        tests:
          "should grant +4 feat bonus to initiative": (npc) ->
            npc.initiative.has 4, "feat"

  "[ImprovedMistyStep] should be defined":
    featDefined "ImprovedMistyStep",
      name: "Improved Misty Step"
      allows: [ int: 13, class: "warlock", when: hasPact("Fey") ]
      disallows: [
        { int: 13, class: "warlock", when: hasPact("Star") },
        { int: 12, class: "warlock", when: hasPact("Fey") },
        { int: 13, class: "wizard", when: hasPact("Fey") } ]

  "[InspiredRecovery] should be defined":
    featDefined "InspiredRecovery",
      name: "Inspired Recovery"
      allows: [ class: "warlord", when: hasPresence("Inspiring") ]
      disallows: [
        { class: "warlord", when: hasPresence("Tactical") },
        { class: "wizard", when: hasPresence("Inspiring") } ]

  "[IounsPoise] should be defined":
    featDefined "IounsPoise",
      name: "Ioun's Poise"
      allows: [ { feature: { class: ["Channel Divinity"] }, deity: "Ioun" } ]
      disallows: [
        { feature: { class: ["Channel Divinity"] }, deity: "Pelor" },
        { feature: { class: ["Hunter's Quarry"] }, deity: "Ioun" } ]
      grants:
        power:
          encounter: [ "Channel Divinity: Ioun's Poise" ]

  "[JackOfAllTrades] should be defined":
    featDefined "JackOfAllTrades",
      name: "Jack of All Trades"
      allows: [ int: 13 ]
      disallows: [ int: 12 ]
      grants:
        tests:
          "should gain +2 feat bonus to untrained skills": (npc) ->
            npc.skills.acrobatics.trained = true
            npc.skills.acrobatics.score() is 5 and
              npc.skills.diplomacy.score() is 2

  "[KordsFavor] should be defined":
    featDefined "KordsFavor",
      name: "Kord's Favor"
      allows: [ { feature: { class: ["Channel Divinity"] }, deity: "Kord" } ]
      disallows: [
        { feature: { class: ["Channel Divinity"] }, deity: "Pelor" },
        { feature: { class: ["Hunter's Quarry"] }, deity: "Kord" } ]
      grants:
        power:
          encounter: [ "Channel Divinity: Kord's Favor" ]

  "[LethalHunter] should be defined":
    featDefined "LethalHunter",
      name: "Lethal Hunter"
      allows: [ class: "ranger", feature: { class: ["Hunter's Quarry"] } ]
      disallows: [
        { class: "ranger", feature: { class: ["Channel Divinity"] } },
        { class: "wizard", feature: { class: ["Hunter's Quarry"] } } ]
      grants:
        tests:
          "should change quarryDie to 8": (npc) -> npc.quarryDie is 8

  "[LightStep] should be defined":
    featDefined "LightStep",
      name: "Light Step"
      allows: [ race: "elf" ]
      disallows: [ race: "dwarf" ]
      grants:
        tests:
          "should have feat bonus to acrobatics and stealth": (npc) ->
            npc.skills.acrobatics.has(1, "feat") and
              npc.skills.stealth.has(1, "feat")

  "[Linguist] should be defiend":
    featDefined "Linguist",
      name: "Linguist"
      allows: [ int: 13 ]
      disallows: [ int: 12 ]
      multiple: true
      grants:
        tests:
          "should have three more languages": (npc) ->
            npc.languages.length is 3

  "[LongJumper] should be defined":
    featDefined "LongJumper",
      name: "Long Jumper"
      allows: [ trained: ["athletics"] ]
      disallows: [ {} ]
      grants:
        tests:
          "should have +1 athletics bonus": (npc) ->
            npc.skills.athletics.has 1, "feat"

  "[LostInTheCrowd] should be defined":
    featDefined "LostInTheCrowd",
      name: "Lost in the Crowd"
      allows: [ race: "halfling" ]
      disallows: [ race: "human" ]

  "[RitualCaster] should be defined":
    featDefined "RitualCaster",
      name: "Ritual Caster"
      allows: [ { trained: [ "arcana" ] }, { trained: [ "religion" ] } ]
      disallows: [ {} ]
      grants:
        setup:
          when: (npc) ->
            npc.class = new Classes.Fighter(npc)
            npc.race = new Races.Human(npc)
        tests:
          "should add advancement hook for adding rituals": (npc) ->
            original = npc.advanceItem_RitualCaster
            return false unless original?
            npc.advanceItem_RitualCaster = -> npc.advancedRitualCaster = true
            npc.advance()
            npc.advanceItem_RitualCaster = original
            npc.advancedRitualCaster?

          "advancement hook can possibly add a ritual": (npc) ->
            loop
              npc.advanceItem_RitualCaster()
              return true if npc.rituals.count() > 0
