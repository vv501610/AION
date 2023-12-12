
local DEF = 200 -- 방어상수
local LUK_TO_CRI = 0.01 -- luk스탯 1당 크리티컬 확률 0.01% 상승
local AGI_TO_DEAL = 2.5 -- agi스탯 1당 크리티컬 대미지 2.5% 상승
local DEFAULT_CRI_DEAL = 20 -- 크리 터졌을 때 기본 20% 추가대미지
local AMP = 12 -- 대미지 진폭 88 ~ 112

local statName = {[0]='def', [1]='magicDef'}
local skillType = {[-1]=0}
local index = 0
while Server.GetSkill(index) do
	skillType[index] = Server.GetSkill(index).type
	index = index+1
end
-- Server.GetSkill 에서 호출하는것보다 서버 시작시 테이블에 담아놓고 호출하는것이 월등히 빠름

local function reDmg(damage, defense)
	return damage * (1-defense / (defense+DEF))
end

Server.damageCallback = function(a, b, damage, skID, cri, visible)
	if damage < 1 then -- 대미지가 1 미만일 때 대미지 미표시
		return 0, false, false
	end
	
	damage = reDmg(damage, b[statName[skillType[skID]]])
	
	if rand(1, 100/LUK_TO_CRI+1) <= a.luk then
		damage = damage * (1+DEFAULT_CRI_DEAL*0.01 + a.agi*AGI_TO_DEAL*0.01)
		cri = true
	end
	
	damage = damage*rand(100-AMP, 101+AMP)*0.01
	
	return damage, cri
end
