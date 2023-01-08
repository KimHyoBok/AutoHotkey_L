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