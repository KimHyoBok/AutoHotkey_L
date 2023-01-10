#Include lib\TaskAutoLab.ahk

vInitDialog:
{
	Gui, -SysMenu
	Gui, Add, Button, x10 y10 w100 h20 vBtnEvent gBtnEvent, 비활성 클릭
	Gui, Add, Button, x10 y40 w100 h20 vBtnClose gBtnClose, 종료
	Gui, Show, x1322 y5 w120 h70,

	return
}

BtnEvent:
{
	bStat := TAL_ImageSearch("LDPlayer", OutX, OutY, 0, 0, 960, 540, 30, 1, "Img/Neddle.png", OutError)
	if(bStat)
	{
		TAL_LDPostMouseClick("LDPlayer", "LEFT", OutX, OutY)
	}
	else
	{
		msgbox, 오류 발생! (%OutError%)
	}

	return
}

BtnClose:
	exitapp
return



