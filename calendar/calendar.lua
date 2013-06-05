--[[
	 できあがりイメージ
	 　 　 　  1  2  3  4
	  5  6  7  8  9 10 11
	 12 13 14 15 16 17 18
	 19 20 21 22 23 24 25
	 26 27 28 29 30 31
]]--
 
function Update()
	-- 現在のシリアルから月初を求める(「時分秒」と「日付」を切り捨てる)
	-- 時分秒を切り捨てるときに、timezone(+09:00)で発生する1日分の+誤差を修正する
	secInAday = 86400
	zeroHourOffset = secInAday -- 86400
	if (os.date("%H")+0 >= 9 ) then zeroHourOffset = 0 end
	ser = os.time() - (os.time() % secInAday - zeroHourOffset ) - ( (os.date("%d")-1) * secInAday)

	-- 月末日判別Tbl
	termDay = {Jan=31,Feb=28,Mar=31,Apr=30,May=31,Jun=30,Jul=31,Aug=31,Sep=30,Oct=31,Nov=30,Dec=31}
	thisYear = os.date("%Y")
	if (thisYear % 4 == 0) or ( (thisYear % 400 == 0) and (thisYear % 100 ~= 0) ) then termDay['Feb'] = 29 end

	-- 月初の曜日によってオフセット追加
	youbi = os.date("%w", ser)
	offset = ''
	for i=1, youbi do
		offset = offset..'   '
	end

	-- 成型
	daysOfMonth = ""
	strLenOfAWeek = 3 * 7 -- day( blank1 + number2) * days in week(7)
	tempW=offset
	today=os.date("%d")+0 -- 型変換のために0加算

	for i=1,termDay[os.date("%b")] do
		-- 1週間ずつ連結したものをtempから戻し用に移す
		if (tempW:len() >= 21) then
			daysOfMonth = daysOfMonth..tempW.."\n"
			tempW = ""
		end
		
		-- くっつける／10以下は半spを充填
		if (today == i) then
			tempW = tempW.."["
		elseif (today+1 == i) then
			tempW = tempW.."]"
		else
			tempW = tempW.." "
		end
		if i < 10 then tempW = tempW..' ' end
		tempW = tempW..i

	end
	-- 最終週回収
	daysOfMonth = daysOfMonth..tempW

	return daysOfMonth
end

