#Include lib\Gdip_All.ahk
#Include lib\Gdip_ImageSearch.ahk

;��Ȱ���̹�����ġ
;WindowTitle : �������
;OutputVarX : ��� X��ǥ
;OutputVarY : ��� Y��ǥ
;X1 : ���� X��ǥ
;Y1 : ���� Y��ǥ
;X2 : ���� X��ǥ
;Y2 : ���� Y��ǥ
;Variation : ������(0~255)
;Direct : Ž������
;Image : �̹�������
;Error : ���� �޽���
TAL_ImageSearch(WindowTitle="", byref OutputVarX=0, byref OutputVarY=0, X1=0, Y1=0, X2=0, Y2=0, Variation=30, Direct=1, ImageFile="", byref Error="")
{
	WinGet, hwnd, ID, %WindowTitle%

	pToken := Gdip_Startup()

	pBitmapHayStack := Gdip_BitmapFromhwnd(hwnd)
	if(pBitmapHayStack = 0)
	{
		Error := "Ÿ�� �������� ������ �������� ���߽��ϴ�!"
		return false
	}

	pBitmapNeedle := Gdip_CreateBitmapFromFile(ImageFile)
	if(pBitmapNeedle = 0)
	{
		Error := "�̹��� ������ �ε����� ���߽��ϴ�!"
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

		Error := "�̹����� ã�� ���߽��ϴ�."
		return false
	}
}