
XIncludeFile "../Includes/SimConnect.pbi"

EnableExplicit


Global IsRunning.b = #True

Define hr.HRESULT
Define hSimConnect.HANDLE


Procedure DispatchProc(*pData.SIMCONNECT_RECV, cbData.DWORD, *pContext)
	Debug "Callback has been called !"
	
	Debug "Data size: "+Str(cbData)
	Debug "Version: "+Str(*pData\dwVersion)
	
	Select *pData\dwID
		Case #SIMCONNECT_RECV_ID_OPEN
			Debug "#SIMCONNECT_RECV_ID_OPEN"
			Define *pDataTmp.SIMCONNECT_RECV_OPEN = *pData
			
			;Debug PeekS(*pDataTmp\szApplicationName, 256)
			Debug "Version: "+Str(*pDataTmp\dwApplicationVersionMajor)+"."+Str(*pDataTmp\dwApplicationVersionMinor)
			Debug "Build: "+Str(*pDataTmp\dwApplicationBuildMajor)+"."+Str(*pDataTmp\dwApplicationBuildMinor)
			Debug "SimConnect Version: "+Str(*pDataTmp\dwSimConnectVersionMajor)+"."+Str(*pDataTmp\dwSimConnectVersionMinor)
			Debug "SimConnect Build: "+Str(*pDataTmp\dwSimConnectBuildMajor)+"."+Str(*pDataTmp\dwSimConnectBuildMinor)
			
		Case #SIMCONNECT_RECV_ID_QUIT
			Debug "#SIMCONNECT_RECV_ID_QUIT"
			IsRunning = #False
			
		Default
			Debug "An unhandled dwID was received by the callback !"
	EndSelect
EndProcedure



hr = SimConnect_Open(@hSimConnect, "PureBasic - BasicConnection Example", #Null, 0, 0, #SIMCONNECT_OPEN_CONFIGINDEX_LOCAL)

Select hr
	Case #S_OK
		Debug "Connected !"
	Case #E_FAIL
		Debug "Error: Generic failure"
		End 1
	Case #E_INVALIDARG
		Debug "Error: Invalid argument(s)"
		End 2
	Default
		Debug "Error: Simulator might not be running"
		End 3
EndSelect


While IsRunning
	hr = SimConnect_CallDispatch(hSimConnect, @DispatchProc(), #Null)
	
	Select hr
		Case #S_OK
			;Debug "Dispatch success !"
		Case #E_FAIL
			Debug "Error: Generic failure"
		Case #E_INVALIDARG
			Debug "Error: Invalid Argument(s)"
		Default
			Debug "Error: Unknown"
	EndSelect
	
	Delay(10)
Wend


Debug "Closing SimConnect Handle..."
SimConnect_Close(hSimConnect)
