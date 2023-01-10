#Include lib\Gdip_All.ahk
#Include lib\Gdip_ImageSearch.ahk

;비활성이미지서치
;WindowTitle : 윈도우명
;OutputVarX : 결과 X좌표
;OutputVarY : 결과 Y좌표
;X1 : 시작 X좌표
;Y1 : 시작 Y좌표
;X2 : 종료 X좌표
;Y2 : 종료 Y좌표
;Variation : 오차율(0~255)
;Direct : 탐색방향
;Image : 이미지파일
;Error : 오류 메시지
TAL_ImageSearch(WindowTitle="", byref OutputVarX=0, byref OutputVarY=0, X1=0, Y1=0, X2=0, Y2=0, Variation=30, Direct=1, ImageFile="", byref Error="")
{
	WinGet, hwnd, ID, %WindowTitle%

	pToken := Gdip_Startup()

	pBitmapHayStack := Gdip_BitmapFromhwnd(hwnd)
	if(pBitmapHayStack = 0)
	{
		Error := "타겟 윈도우의 정보를 가져오지 못했습니다!"
		return false
	}

	pBitmapNeedle := Gdip_CreateBitmapFromFile(ImageFile)
	if(pBitmapNeedle = 0)
	{
		Error := "이미지 파일을 로딩하지 못했습니다!"
		return false
	}

	sleep, 10

	if(Gdip_ImageSearch(pBitmapHayStack, pBitmapNeedle, list, X1, Y1, X2, Y2, Variation, 0x000000, Direct, 1) )
	{
		StringSplit, LISTArray, LIST, `,

		OutputVarX := LISTArray1
		OutputVarY := LISTArray2

		Gdip_DisposeImage(pBitmapHayStack)
		Gdip_DisposeImage(pBitmapNeedle)
		Gdip_Shutdown(pToken)

		return true
	}
	else
	{
		Gdip_DisposeImage(pBitmapHayStack)
		Gdip_DisposeImage(pBitmapNeedle)
		Gdip_Shutdown(pToken)

		Error := "이미지를 찾지 못했습니다."
		return false
	}
}



;비활성 클릭
;LR : 왼쪽클릭(LEFT)/오른쪽클릭(RIGHT)
;X  : X좌표
;Y  : Y좌표
global TitleBarHeight = 35
TAL_LDPostMouseClick(WindowTitle="", LR="", X=0, Y=0)
{
	WinGet, hwndPlayer, ID, %WindowTitle%

	Y -= TitleBarHeight

	lparam := X | Y << 16

	if		(LR = "LEFT")
	{
		PostMessage, 0x201, 1, %lparam%, RenderWindow1, ahk_id %hwndPlayer%
		randSleep(10, 0, 50)
		PostMessage, 0x202, 0, %lparam%, RenderWindow1, ahk_id %hwndPlayer%
	}
	else if (LR = "RIGHT")
	{
		PostMessage, 0x204, 1, %lparam%, TheRender, ahk_id %hwndPlayer%
		randSleep(10, 0, 50)
		PostMessage, 0x205, 0, %lparam%, TheRender, ahk_id %hwndPlayer%
	}
}


randSleep(Org, MinRand, MaxRand)
{
	nDelay := Org
	Random, randDelay, MinRand,  MaxRand
	Sleep, nDelay + randDelay
}