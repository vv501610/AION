
local DEF = 200 -- 방어상수
local LUK_TO_CRI = 0.01 -- luk스탯 1당 크리티컬 확률 0.01% 상승
local AGI_TO_DEAL = 2.5 -- agi스탯 1당 크리티컬 대미지 2.5% 상승
local DEFAULT_CRI_DEAL = 20 -- 크리 터졌을 때 기본 20% 추가대미지


-- local function reDmg(damage, defense)
-- 	return damage * (1-defense / (defense+DEF))
-- end

Server.damageCallback = function(a, b, damage, skID, cri, visible)
	if not a or not b then
		return false
	end

	-- if damage < 1 then -- 대미지가 1 미만일 때 대미지 미표시
	-- 	return 0, false, false
	-- end

	local bdef = b.def

	print(a.GetStat(109)) -- 방어력 관통률

	damage = damage*math.ceil(1000*(1-bdef/(bdef+15000)))/1000 ---뒤에 15000은 방어 상수

	print((math.floor(bdef/(bdef+15000)*100*10)/10)..' %피해를 덜 받습니다.')

	
	-- damage = reDmg(damage, b.def)
	
	-- if rand(1, 100/LUK_TO_CRI+1) <= a.luk then
	-- 	damage = damage * (1+DEFAULT_CRI_DEAL*0.01 + a.agi*AGI_TO_DEAL*0.01)
	-- 	cri = true
	-- end
	
	-- damage = damage*rand(100-AMP, 101+AMP)*0.01

	
	return damage, cri
end

