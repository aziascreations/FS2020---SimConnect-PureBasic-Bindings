
;- Compiler Directives

XIncludeFile "./Includes/SimConnectFS2020.pbi"

EnableExplicit


;- Declarations

Global Quit.b = 0

Define hr.HRESULT
Define hSimConnect.HANDLE
Define StartTime.q

Procedure DispatchProc(*pData.SIMCONNECT_RECV, cbData.DWORD, *pContext)
	Debug "Callback has been called !"
	Debug "Data size: "+Str(cbData)
	
	Debug "Version: "+Str(*pData\dwVersion)
	
	Select *pData\dwID
		Case #SIMCONNECT_RECV_ID_NULL
			Debug "#SIMCONNECT_RECV_ID_NULL"
			
		Case #SIMCONNECT_RECV_ID_EXCEPTION
			Debug "#SIMCONNECT_RECV_ID_EXCEPTION"
			
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
			Quit = 1
			
		Case #SIMCONNECT_RECV_ID_EVENT
			Debug "#SIMCONNECT_RECV_ID_EVENT"
			
			
			
		Case #SIMCONNECT_RECV_ID_EVENT_OBJECT_ADDREMOVE
			Debug "#SIMCONNECT_RECV_ID_EVENT_OBJECT_ADDREMOVE"
		Case #SIMCONNECT_RECV_ID_EVENT_FILENAME
			Debug "#SIMCONNECT_RECV_ID_EVENT_FILENAME"
		Case #SIMCONNECT_RECV_ID_EVENT_FRAME
			Debug "#SIMCONNECT_RECV_ID_EVENT_FRAME"
		Case #SIMCONNECT_RECV_ID_SIMOBJECT_DATA
			Debug "#SIMCONNECT_RECV_ID_SIMOBJECT_DATA"
		Case #SIMCONNECT_RECV_ID_SIMOBJECT_DATA_BYTYPE
			Debug "#SIMCONNECT_RECV_ID_SIMOBJECT_DATA_BYTYPE"
		Case #SIMCONNECT_RECV_ID_CLOUD_STATE
			Debug "#SIMCONNECT_RECV_ID_CLOUD_STATE"
		Case #SIMCONNECT_RECV_ID_WEATHER_OBSERVATION
			Debug "#SIMCONNECT_RECV_ID_WEATHER_OBSERVATION"
		Case #SIMCONNECT_RECV_ID_ASSIGNED_OBJECT_ID
			Debug "#SIMCONNECT_RECV_ID_ASSIGNED_OBJECT_ID"
		Case #SIMCONNECT_RECV_ID_RESERVED_KEY
			Debug "#SIMCONNECT_RECV_ID_RESERVED_KEY"
		Case #SIMCONNECT_RECV_ID_CUSTOM_ACTION
			Debug "#SIMCONNECT_RECV_ID_CUSTOM_ACTION"
		Case #SIMCONNECT_RECV_ID_SYSTEM_STATE
			Debug "#SIMCONNECT_RECV_ID_SYSTEM_STATE"
		Case #SIMCONNECT_RECV_ID_CLIENT_DATA
			Debug "#SIMCONNECT_RECV_ID_CLIENT_DATA"
		Case #SIMCONNECT_RECV_ID_EVENT_WEATHER_MODE
			Debug "#SIMCONNECT_RECV_ID_EVENT_WEATHER_MODE"
		Case #SIMCONNECT_RECV_ID_AIRPORT_LIST
			Debug "#SIMCONNECT_RECV_ID_AIRPORT_LIST"
		Case #SIMCONNECT_RECV_ID_VOR_LIST
			Debug "#SIMCONNECT_RECV_ID_VOR_LIST"
		Case #SIMCONNECT_RECV_ID_NDB_LIST
			Debug "#SIMCONNECT_RECV_ID_NDB_LIST"
		Case #SIMCONNECT_RECV_ID_WAYPOINT_LIST
			Debug "#SIMCONNECT_RECV_ID_WAYPOINT_LIST"
		Case #SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_SERVER_STARTED
			Debug "#SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_SERVER_STARTED"
		Case #SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_CLIENT_STARTED
			Debug "#SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_CLIENT_STARTED"
		Case #SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_SESSION_ENDED
			Debug "#SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_SESSION_ENDED"
		Case #SIMCONNECT_RECV_ID_EVENT_RACE_END
			Debug "#SIMCONNECT_RECV_ID_EVENT_RACE_END"
		Case #SIMCONNECT_RECV_ID_EVENT_RACE_LAP
			Debug "#SIMCONNECT_RECV_ID_EVENT_RACE_LAP"
	EndSelect
EndProcedure


;- Program

hr = SimConnect_Open(@hSimConnect, "PureBasic Test App", #Null, 0, 0, #SIMCONNECT_OPEN_CONFIGINDEX_LOCAL)

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
		Debug "Error: Is the simulator running ?"
		End 3
EndSelect


StartTime = ElapsedMilliseconds()

; Keep looping until quitting or until 1 mins passed (debug).
While (Not Quit) And StartTime + (1000*60*2) > ElapsedMilliseconds()
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

Debug "Closing Handle..."
SimConnect_Close(hSimConnect)
