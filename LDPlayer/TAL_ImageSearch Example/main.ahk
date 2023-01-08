#Include lib\TaskAutoLab.ahk


F1::

	bStat := TAL_ImageSearch("LDPlayer", OutX, OutY, 0, 0, 960, 540, 30, 1, "Img/Neddle.png", OutError)
	if(bStat)
	{
		msgbox, 이미지를 찾았습니다. (%OutX%, %OutY%)
	}
	else
	{
		msgbox, 오류 발생! (%OutError%)
	}
return


F2::exitapp

