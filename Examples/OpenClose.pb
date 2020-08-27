
; Translation of OpenClose.cpp from the official SDK

XIncludeFile "../Includes/SimConnect.pbi"

EnableExplicit


Define hSimConnect.HANDLE = #Null

Define hr.HRESULT


; Remark: The application title might not work since PB uses unicode formatted strings.
;         To fix this you can make a buffer with the ascii text in it using the Ascii() procedure.
If SimConnect_Open(&hSimConnect, "Open and Close", #Null, 0, 0, 0) >= 0
	Debug "Connected to Flight Simulator !"
	
	hr = SimConnect_Close(hSimConnect)
	
	Debug "Disconnected from Flight Simulator"
Else
	Debug "Failed to connect to Flight Simulator"
EndIf
