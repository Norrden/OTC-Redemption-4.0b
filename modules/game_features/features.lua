controller = Controller:new()
controller:registerEvents(g_game, {
    onClientVersionChange = function(version)
        -- Special Features  
        -- g_game.enableFeature(GameKeepUnawareTiles)
        -- g_game.enableFeature(GameSmoothWalkElevation)
        -- g_game.enableFeature(GameNegativeOffset)
        -- g_game.enableFeature(GameWingsAurasEffectsShader)
        g_game.enableFeature(GameAllowCustomBotScripts)   
        g_game.enableFeature(GameFormatCreatureName)

        -- Features BELOW v860
        if version <= 860 then
            g_game.enableFeature(GameSoul) --750
            g_game.enableFeature(GameLevelU16) --760
            g_game.enableFeature(GameLooktypeU16) --770
            g_game.enableFeature(GameMessageStatements)
            g_game.enableFeature(GameLoginPacketEncryption)
            g_game.enableFeature(GamePlayerAddons) --780
            g_game.enableFeature(GamePlayerStamina)
            g_game.enableFeature(GameNewFluids)
            g_game.enableFeature(GameMessageLevel)
            g_game.enableFeature(GamePlayerStateU16)
            g_game.enableFeature(GameNewOutfitProtocol)
            g_game.enableFeature(GameWritableDate) --790
            g_game.enableFeature(GameProtocolChecksum) --840
            g_game.enableFeature(GameAccountNames)
            g_game.enableFeature(GameDoubleFreeCapacity)
            g_game.enableFeature(GameChallengeOnLogin) --841
            g_game.enableFeature(GameMessageSizeCheck)
            g_game.enableFeature(GameCreatureEmblems) --854
            g_game.enableFeature(GameAttackSeq) --860
        else -- Features ABOVE v860
            g_game.enableFeature(GamePenalityOnDeath) --862
            g_game.enableFeature(GameDoubleExperience) --870
            g_game.enableFeature(GamePlayerMounts)
            g_game.enableFeature(GameSpellList)
            g_game.enableFeature(GameNameOnNpcTrade) --910
            g_game.enableFeature(GameTotalCapacity)
            g_game.enableFeature(GameSkillsBase)
            g_game.enableFeature(GamePlayerRegenerationTime)
            g_game.enableFeature(GameChannelPlayerList)
            g_game.enableFeature(GameEnvironmentEffect)
            g_game.enableFeature(GameItemAnimationPhase)
            g_game.enableFeature(GamePlayerMarket) --940
            g_game.enableFeature(GamePurseSlot) --953
            g_game.enableFeature(GameClientPing)
            g_game.enableFeature(GameSpritesU32) --960
            g_game.enableFeature(GameOfflineTrainingTime)
            g_game.enableFeature(GameAdditionalVipInfo) --963
            g_game.enableFeature(GamePreviewState) --980
            g_game.enableFeature(GameClientVersion)
            g_game.enableFeature(GameLoginPending) --981
            g_game.enableFeature(GameNewSpeedLaw)
            g_game.enableFeature(GameContainerPagination) --984
            g_game.enableFeature(GameBrowseField)
            g_game.enableFeature(GameThingMarks) --1000
            g_game.enableFeature(GamePVPMode)
            g_game.enableFeature(GameDoubleSkills) --1035
            g_game.enableFeature(GameBaseSkillU16)
            g_game.enableFeature(GameCreatureIcons) --1036
            g_game.enableFeature(GameHideNpcNames)
            g_game.enableFeature(GamePremiumExpiration) --1038
            g_game.enableFeature(GameEnhancedAnimations) --1050
            g_game.enableFeature(GameUnjustifiedPoints) --1053
            g_game.enableFeature(GameExperienceBonus) --1054
            g_game.enableFeature(GameDeathType) --1055
            g_game.enableFeature(GameIdleAnimations) --1057
            g_game.enableFeature(GameOGLInformation) --1061
            g_game.enableFeature(GameContentRevision) --1071
            g_game.enableFeature(GameAuthenticator) --1072
            g_game.enableFeature(GameSessionKey) --1074
            g_game.enableFeature(GameIngameStore) --1080
            g_game.enableFeature(GameIngameStoreServiceType) --1092
            g_game.enableFeature(GameIngameStoreHighlights) --1093
            g_game.enableFeature(GameAdditionalSkills) --1094
            g_game.enableFeature(GameLeechAmount)
            g_game.enableFeature(GamePrey) --1100
            g_game.enableFeature(GameColorizedLootValue) --1200
            g_game.enableFeature(GameThingQuickLoot)
            g_game.enableFeature(GameTournamentPackets)
            g_game.enableFeature(GameVipGroups)
            g_game.enableFeature(GameEnterGameShowAppearance)
            g_game.enableFeature(GameThingQuiver) --1260
            g_game.enableFeature(GameThingPodium) --1264
            g_game.enableFeature(GameThingUpgradeClassification) --1272
            g_game.disableFeature(GameEnvironmentEffect) --1281
            g_game.disableFeature(GameItemAnimationPhase)
            g_game.enableFeature(GameSequencedPackets) --1290
            g_game.enableFeature(GameBosstiary)
            g_game.enableFeature(GameThingClock)
            g_game.enableFeature(GameThingCounter)
            g_game.enableFeature(GameThingPodiumItemType)
            g_game.enableFeature(GameDoubleShopSellAmount)
            g_game.enableFeature(GameDoubleHealth) --1300
            g_game.enableFeature(GameUshortSpell)
            g_game.enableFeature(GameConcotions)
            g_game.enableFeature(GameAnthem)
            g_game.disableFeature(GameTournamentPackets) --1314
            g_game.enableFeature(GameDynamicForgeVariables)
            g_game.enableFeature(GameEffectU16) --1320
            g_game.enableFeature(GameContainerTypes)
            g_game.enableFeature(GameBosstiaryTracker)
            g_game.enableFeature(GamePlayerStateCounter)
            g_game.disableFeature(GameLeechAmount)
            g_game.enableFeature(GameItemAugment)
            g_game.enableFeature(GameDynamicBugReporter)
            g_game.enableFeature(GameWrapKit) --1321
            g_game.enableFeature(GameContainerFilter)
            g_game.enableFeature(GameForgeConvergence) --1332
        end
    end
})