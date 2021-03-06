AlwaysOpenOnDesktopNumber(num, exe:=""){
	DetectHiddenWindows On ; FuncOrMethod will be called with DetectHiddenWindows On
	WinHook.Shell.Add(Func("MoveAndFocus").Bind(num),,,exe,1) ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=86967
}

MoveAndFocus(num, hwndToMove){
	currentDesktop := GetCurrentDesktop()
	if (currentDesktop != num) ; if the window is opening in the desktop that is suposed to: then dont do nothing
	{
		DllCall(MoveWindowToDesktopNumberProc, UInt, hwndToMove, UInt, num - 1)
		altTabList := GetAltTabList()
		lastWindow := altTabList[1]
		WinActivate, ahk_id %lastWindow%
	}
}

AlwaysOpenOnDesktopNumberAndGo(num, exe:=""){
	WinHook.Shell.Add(Func("GoMoveAndFocus").Bind(num),,,exe,1) ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=86967
}

GoMoveAndFocus(num, hwndToMove){
	currentDesktop := GetCurrentDesktop()
	if (currentDesktop != num) ; if the window is opening in the desktop that is suposed to: then dont do nothing
	{
		GoToDesktop(num)
		DllCall(MoveWindowToDesktopNumberProc, UInt, hwndToMove, UInt, num - 1)
		WinActivate, ahk_id %hwndToMove%
	}
}
