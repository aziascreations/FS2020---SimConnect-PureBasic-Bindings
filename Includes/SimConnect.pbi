


;- Compiler Directives
;{

;XIncludeFile "./Includes/WinAPI_Types.pbi"
XIncludeFile "./PB-WinAPI-Additions/Includes/WinAPI_Types.pbi"

CompilerIf Not #PB_Compiler_OS = #PB_OS_Windows
	CompilerError "Error: Please compile the program on a Windows machine !"
CompilerEndIf

CompilerIf Not #PB_Compiler_Processor = #PB_Processor_x64
	CompilerError "Error: Please compile the program for a x64 cpu architecture !"
CompilerEndIf

; The following line is only use to see if it works with it and for debugging.
EnableExplicit

;}


;- Constants
;{

#DWORD_MAX = $FFFFFFFF

; DWORD
; special value to indicate unused event, ID
#SIMCONNECT_UNUSED = #DWORD_MAX

; DWORD
; proxy value for User vehicle ObjectID
#SIMCONNECT_OBJECT_ID_USER = 0

; float
; Used to tell the Camera API to NOT modify the value in this part of the argument.
;#SIMCONNECT_CAMERA_IGNORE_FIELD = #FLT_MAX

; Maximum value for SimConnect_CreateClientData dwSize parameter
#SIMCONNECT_CLIENTDATA_MAX_SIZE = 8192


; Notification Group priority values
#SIMCONNECT_GROUP_PRIORITY_HIGHEST          =          1 ; highest priority
#SIMCONNECT_GROUP_PRIORITY_HIGHEST_MASKABLE =   10000000 ; highest priority that allows events to be masked
#SIMCONNECT_GROUP_PRIORITY_STANDARD         = 1900000000 ; standard priority
#SIMCONNECT_GROUP_PRIORITY_DEFAULT          = 2000000000 ; default priority
#SIMCONNECT_GROUP_PRIORITY_LOWEST           = 4000000000 ; priorities lower than this will be ignored

; Weather observations Metar strings
#MAX_METAR_LENGTH = 2000

; Maximum thermal size is 100 km.
#MAX_THERMAL_SIZE = 100000.0
#MAX_THERMAL_RATE = 1000.0

; SIMCONNECT_DATA_INITPOSITION.Airspeed
#INITPOSITION_AIRSPEED_CRUISE = -1 ; aircraft's cruise airspeed
#INITPOSITION_AIRSPEED_KEEP = -2   ; keep current airspeed

; AddToClientDataDefinition dwSizeOrType parameter type values
#SIMCONNECT_CLIENTDATATYPE_INT8       = -1 ;  8-bit integer number
#SIMCONNECT_CLIENTDATATYPE_INT16      = -2 ; 16-bit integer number
#SIMCONNECT_CLIENTDATATYPE_INT32      = -3 ; 32-bit integer number
#SIMCONNECT_CLIENTDATATYPE_INT64      = -4 ; 64-bit integer number
#SIMCONNECT_CLIENTDATATYPE_FLOAT32    = -5 ; 32-bit floating-point number (float)
#SIMCONNECT_CLIENTDATATYPE_FLOAT64    = -6 ; 64-bit floating-point number (double)

; AddToClientDataDefinition dwOffset parameter special values
#SIMCONNECT_CLIENTDATAOFFSET_AUTO    = -1 ; automatically compute offset of the ClientData variable

; Open ConfigIndex parameter special value
#SIMCONNECT_OPEN_CONFIGINDEX_LOCAL   = -1 ; ignore SimConnect.cfg settings, and force local connection

;}


;- Typedefs
;{

Macro SIMCONNECT_OBJECT_ID : DWORD : EndMacro

Macro SIMCONNECT_NOTIFICATION_GROUP_ID : DWORD : EndMacro
Macro SIMCONNECT_CLIENT_EVENT_ID : DWORD : EndMacro

; //these came from substituteMacros
; #define SIMCONNECT_REFSTRUCT struct
; #define SIMCONNECT_STRUCT struct
; #define SIMCONNECT_STRING(name, size) char name[size]
; #define SIMCONNECT_GUID GUID
; #define SIMCONNECT_STRINGV(name) char name[1]
; #define SIMCONNECT_DATAV(name, id, count) DWORD name
; #define SIMCONNECT_FIXEDTYPE_DATAV(type, name, count, cliMarshalAs, cliType) type name[1]
; #define SIMCONNECT_GUID GUID
; #define SIMCONNECT_ENUM enum
; #define SIMCONNECT_ENUM_FLAGS typedef DWORD
; #define SIMCONNECT_USER_ENUM typedef DWORD

;}


;- Enums
;{

; //----------------------------------------------------------------------------
; //        Enum definitions
; //----------------------------------------------------------------------------

; Receive data types
Enumeration SIMCONNECT_RECV_ID
	#SIMCONNECT_RECV_ID_NULL
	#SIMCONNECT_RECV_ID_EXCEPTION
	#SIMCONNECT_RECV_ID_OPEN
	#SIMCONNECT_RECV_ID_QUIT
	#SIMCONNECT_RECV_ID_EVENT
	#SIMCONNECT_RECV_ID_EVENT_OBJECT_ADDREMOVE
	#SIMCONNECT_RECV_ID_EVENT_FILENAME
	#SIMCONNECT_RECV_ID_EVENT_FRAME
	#SIMCONNECT_RECV_ID_SIMOBJECT_DATA
	#SIMCONNECT_RECV_ID_SIMOBJECT_DATA_BYTYPE
	#SIMCONNECT_RECV_ID_WEATHER_OBSERVATION
	#SIMCONNECT_RECV_ID_CLOUD_STATE
	#SIMCONNECT_RECV_ID_ASSIGNED_OBJECT_ID
	#SIMCONNECT_RECV_ID_RESERVED_KEY
	#SIMCONNECT_RECV_ID_CUSTOM_ACTION
	#SIMCONNECT_RECV_ID_SYSTEM_STATE
	#SIMCONNECT_RECV_ID_CLIENT_DATA
	#SIMCONNECT_RECV_ID_EVENT_WEATHER_MODE
	#SIMCONNECT_RECV_ID_AIRPORT_LIST
	#SIMCONNECT_RECV_ID_VOR_LIST
	#SIMCONNECT_RECV_ID_NDB_LIST
	#SIMCONNECT_RECV_ID_WAYPOINT_LIST
	#SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_SERVER_STARTED
	#SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_CLIENT_STARTED
	#SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_SESSION_ENDED
	#SIMCONNECT_RECV_ID_EVENT_RACE_END
	#SIMCONNECT_RECV_ID_EVENT_RACE_LAP
EndEnumeration

; Data data types
Enumeration SIMCONNECT_DATATYPE
	#SIMCONNECT_DATATYPE_INVALID      ; invalid data type
	#SIMCONNECT_DATATYPE_INT32		  ; 32-bit integer number
	#SIMCONNECT_DATATYPE_INT64		  ; 64-bit integer number
	#SIMCONNECT_DATATYPE_FLOAT32	  ; 32-bit floating-point number (float)
	#SIMCONNECT_DATATYPE_FLOAT64	  ; 64-bit floating-point number (double)
	#SIMCONNECT_DATATYPE_STRING8	  ; 8-byte string
	#SIMCONNECT_DATATYPE_STRING32	  ; 32-byte string
	#SIMCONNECT_DATATYPE_STRING64	  ; 64-byte string
	#SIMCONNECT_DATATYPE_STRING128	  ; 128-byte string
	#SIMCONNECT_DATATYPE_STRING256	  ; 256-byte string
	#SIMCONNECT_DATATYPE_STRING260	  ; 260-byte string
	#SIMCONNECT_DATATYPE_STRINGV	  ; variable-length string
	
	#SIMCONNECT_DATATYPE_INITPOSITION ; see SIMCONNECT_DATA_INITPOSITION
	#SIMCONNECT_DATATYPE_MARKERSTATE  ; see SIMCONNECT_DATA_MARKERSTATE
	#SIMCONNECT_DATATYPE_WAYPOINT	  ; see SIMCONNECT_DATA_WAYPOINT
	#SIMCONNECT_DATATYPE_LATLONALT	  ; see SIMCONNECT_DATA_LATLONALT
	#SIMCONNECT_DATATYPE_XYZ		  ; see SIMCONNECT_DATA_XYZ
	
	#SIMCONNECT_DATATYPE_MAX          ; enum limit
EndEnumeration

; Exception error types
Enumeration SIMCONNECT_EXCEPTION
	#SIMCONNECT_EXCEPTION_NONE
	
	#SIMCONNECT_EXCEPTION_ERROR
	#SIMCONNECT_EXCEPTION_SIZE_MISMATCH
	#SIMCONNECT_EXCEPTION_UNRECOGNIZED_ID
	#SIMCONNECT_EXCEPTION_UNOPENED
	#SIMCONNECT_EXCEPTION_VERSION_MISMATCH
	#SIMCONNECT_EXCEPTION_TOO_MANY_GROUPS
	#SIMCONNECT_EXCEPTION_NAME_UNRECOGNIZED
	#SIMCONNECT_EXCEPTION_TOO_MANY_EVENT_NAMES
	#SIMCONNECT_EXCEPTION_EVENT_ID_DUPLICATE
	#SIMCONNECT_EXCEPTION_TOO_MANY_MAPS
	#SIMCONNECT_EXCEPTION_TOO_MANY_OBJECTS
	#SIMCONNECT_EXCEPTION_TOO_MANY_REQUESTS
	#SIMCONNECT_EXCEPTION_WEATHER_INVALID_PORT
	#SIMCONNECT_EXCEPTION_WEATHER_INVALID_METAR
	#SIMCONNECT_EXCEPTION_WEATHER_UNABLE_TO_GET_OBSERVATION
	#SIMCONNECT_EXCEPTION_WEATHER_UNABLE_TO_CREATE_STATION
	#SIMCONNECT_EXCEPTION_WEATHER_UNABLE_TO_REMOVE_STATION
	#SIMCONNECT_EXCEPTION_INVALID_DATA_TYPE
	#SIMCONNECT_EXCEPTION_INVALID_DATA_SIZE
	#SIMCONNECT_EXCEPTION_DATA_ERROR
	#SIMCONNECT_EXCEPTION_INVALID_ARRAY
	#SIMCONNECT_EXCEPTION_CREATE_OBJECT_FAILED
	#SIMCONNECT_EXCEPTION_LOAD_FLIGHTPLAN_FAILED
	#SIMCONNECT_EXCEPTION_OPERATION_INVALID_FOR_OBJECT_TYPE
	#SIMCONNECT_EXCEPTION_ILLEGAL_OPERATION
	#SIMCONNECT_EXCEPTION_ALREADY_SUBSCRIBED
	#SIMCONNECT_EXCEPTION_INVALID_ENUM
	#SIMCONNECT_EXCEPTION_DEFINITION_ERROR
	#SIMCONNECT_EXCEPTION_DUPLICATE_ID
	#SIMCONNECT_EXCEPTION_DATUM_ID
	#SIMCONNECT_EXCEPTION_OUT_OF_BOUNDS
	#SIMCONNECT_EXCEPTION_ALREADY_CREATED
	#SIMCONNECT_EXCEPTION_OBJECT_OUTSIDE_REALITY_BUBBLE
	#SIMCONNECT_EXCEPTION_OBJECT_CONTAINER
	#SIMCONNECT_EXCEPTION_OBJECT_AI
	#SIMCONNECT_EXCEPTION_OBJECT_ATC
	#SIMCONNECT_EXCEPTION_OBJECT_SCHEDULE
EndEnumeration

; Object types
Enumeration SIMCONNECT_SIMOBJECT_TYPE
	#SIMCONNECT_SIMOBJECT_TYPE_USER
	#SIMCONNECT_SIMOBJECT_TYPE_ALL
	#SIMCONNECT_SIMOBJECT_TYPE_AIRCRAFT
	#SIMCONNECT_SIMOBJECT_TYPE_HELICOPTER
	#SIMCONNECT_SIMOBJECT_TYPE_BOAT
	#SIMCONNECT_SIMOBJECT_TYPE_GROUND
EndEnumeration

; EventState values
Enumeration SIMCONNECT_STATE
	#SIMCONNECT_STATE_OFF
	#SIMCONNECT_STATE_ON
EndEnumeration

; Object Data Request Period values
Enumeration SIMCONNECT_PERIOD
	#SIMCONNECT_PERIOD_NEVER
	#SIMCONNECT_PERIOD_ONCE
	#SIMCONNECT_PERIOD_VISUAL_FRAME
	#SIMCONNECT_PERIOD_SIM_FRAME
	#SIMCONNECT_PERIOD_SECOND
EndEnumeration

Enumeration SIMCONNECT_MISSION_END
	#SIMCONNECT_MISSION_FAILED
	#SIMCONNECT_MISSION_CRASHED
	#SIMCONNECT_MISSION_SUCCEEDED
EndEnumeration

; ClientData Request Period values
Enumeration SIMCONNECT_CLIENT_DATA_PERIOD
	#SIMCONNECT_CLIENT_DATA_PERIOD_NEVER
	#SIMCONNECT_CLIENT_DATA_PERIOD_ONCE
	#SIMCONNECT_CLIENT_DATA_PERIOD_VISUAL_FRAME
	#SIMCONNECT_CLIENT_DATA_PERIOD_ON_SET
	#SIMCONNECT_CLIENT_DATA_PERIOD_SECOND
EndEnumeration

Enumeration SIMCONNECT_TEXT_TYPE
	#SIMCONNECT_TEXT_TYPE_SCROLL_BLACK
	#SIMCONNECT_TEXT_TYPE_SCROLL_WHITE
	#SIMCONNECT_TEXT_TYPE_SCROLL_RED
	#SIMCONNECT_TEXT_TYPE_SCROLL_GREEN
	#SIMCONNECT_TEXT_TYPE_SCROLL_BLUE
	#SIMCONNECT_TEXT_TYPE_SCROLL_YELLOW
	#SIMCONNECT_TEXT_TYPE_SCROLL_MAGENTA
	#SIMCONNECT_TEXT_TYPE_SCROLL_CYAN
	#SIMCONNECT_TEXT_TYPE_PRINT_BLACK = $0100
	#SIMCONNECT_TEXT_TYPE_PRINT_WHITE
	#SIMCONNECT_TEXT_TYPE_PRINT_RED
	#SIMCONNECT_TEXT_TYPE_PRINT_GREEN
	#SIMCONNECT_TEXT_TYPE_PRINT_BLUE
	#SIMCONNECT_TEXT_TYPE_PRINT_YELLOW
	#SIMCONNECT_TEXT_TYPE_PRINT_MAGENTA
	#SIMCONNECT_TEXT_TYPE_PRINT_CYAN
	#SIMCONNECT_TEXT_TYPE_MENU = $0200
EndEnumeration

Enumeration SIMCONNECT_TEXT_RESULT
	#SIMCONNECT_TEXT_RESULT_MENU_SELECT_1
	#SIMCONNECT_TEXT_RESULT_MENU_SELECT_2
	#SIMCONNECT_TEXT_RESULT_MENU_SELECT_3
	#SIMCONNECT_TEXT_RESULT_MENU_SELECT_4
	#SIMCONNECT_TEXT_RESULT_MENU_SELECT_5
	#SIMCONNECT_TEXT_RESULT_MENU_SELECT_6
	#SIMCONNECT_TEXT_RESULT_MENU_SELECT_7
	#SIMCONNECT_TEXT_RESULT_MENU_SELECT_8
	#SIMCONNECT_TEXT_RESULT_MENU_SELECT_9
	#SIMCONNECT_TEXT_RESULT_MENU_SELECT_10
	#SIMCONNECT_TEXT_RESULT_DISPLAYED = $00010000
	#SIMCONNECT_TEXT_RESULT_QUEUED
	#SIMCONNECT_TEXT_RESULT_REMOVED
	#SIMCONNECT_TEXT_RESULT_REPLACED
	#SIMCONNECT_TEXT_RESULT_TIMEOUT
EndEnumeration

Enumeration SIMCONNECT_WEATHER_MODE
	#SIMCONNECT_WEATHER_MODE_THEME
	#SIMCONNECT_WEATHER_MODE_RWW
	#SIMCONNECT_WEATHER_MODE_CUSTOM
	#SIMCONNECT_WEATHER_MODE_GLOBAL
EndEnumeration

Enumeration SIMCONNECT_FACILITY_LIST_TYPE
	#SIMCONNECT_FACILITY_LIST_TYPE_AIRPORT
	#SIMCONNECT_FACILITY_LIST_TYPE_WAYPOINT
	#SIMCONNECT_FACILITY_LIST_TYPE_NDB
	#SIMCONNECT_FACILITY_LIST_TYPE_VOR
	#SIMCONNECT_FACILITY_LIST_TYPE_COUNT ; invalid 
EndEnumeration


;SIMCONNECT_ENUM_FLAGS SIMCONNECT_VOR_FLAGS            ; flags for SIMCONNECT_RECV_ID_VOR_LIST 
#SIMCONNECT_RECV_ID_VOR_LIST_HAS_NAV_SIGNAL  = $00000001   ; Has Nav signal
#SIMCONNECT_RECV_ID_VOR_LIST_HAS_LOCALIZER   = $00000002   ; Has localizer
#SIMCONNECT_RECV_ID_VOR_LIST_HAS_GLIDE_SLOPE = $00000004   ; Has Nav signal
#SIMCONNECT_RECV_ID_VOR_LIST_HAS_DME         = $00000008   ; Station has DME



; bits for the Waypoint Flags field: may be combined
;SIMCONNECT_ENUM_FLAGS SIMCONNECT_WAYPOINT_FLAGS
#SIMCONNECT_WAYPOINT_NONE                    = $00
#SIMCONNECT_WAYPOINT_SPEED_REQUESTED         = $04    ; requested speed at waypoint is valid
#SIMCONNECT_WAYPOINT_THROTTLE_REQUESTED      = $08	  ; request a specific throttle percentage
#SIMCONNECT_WAYPOINT_COMPUTE_VERTICAL_SPEED  = $10	  ; compute vertical to speed to reach waypoint altitude when crossing the waypoint
#SIMCONNECT_WAYPOINT_ALTITUDE_IS_AGL         = $20	  ; AltitudeIsAGL
#SIMCONNECT_WAYPOINT_ON_GROUND               = $00100000   ; place this waypoint on the ground
#SIMCONNECT_WAYPOINT_REVERSE                 = $00200000   ; Back up to this waypoint. Only valid on first waypoint
#SIMCONNECT_WAYPOINT_WRAP_TO_FIRST           = $00400000   ; Wrap around back to first waypoint. Only valid on last waypoint.

;SIMCONNECT_ENUM_FLAGS SIMCONNECT_EVENT_FLAG
#SIMCONNECT_EVENT_FLAG_DEFAULT                  = $00000000
#SIMCONNECT_EVENT_FLAG_FAST_REPEAT_TIMER        = $00000001      ; set event repeat timer to simulate fast repeat
#SIMCONNECT_EVENT_FLAG_SLOW_REPEAT_TIMER        = $00000002		 ; set event repeat timer to simulate slow repeat
#SIMCONNECT_EVENT_FLAG_GROUPID_IS_PRIORITY      = $00000010		 ; interpret GroupID parameter as priority value

;SIMCONNECT_ENUM_FLAGS SIMCONNECT_DATA_REQUEST_FLAG
#SIMCONNECT_DATA_REQUEST_FLAG_DEFAULT           = $00000000
#SIMCONNECT_DATA_REQUEST_FLAG_CHANGED           = $00000001      ; send requested data when value(s) change
#SIMCONNECT_DATA_REQUEST_FLAG_TAGGED            = $00000002		 ; send requested data in tagged format

;SIMCONNECT_ENUM_FLAGS SIMCONNECT_DATA_SET_FLAG
#SIMCONNECT_DATA_SET_FLAG_DEFAULT               = $00000000
#SIMCONNECT_DATA_SET_FLAG_TAGGED                = $00000001      ; data is in tagged format

;SIMCONNECT_ENUM_FLAGS SIMCONNECT_CREATE_CLIENT_DATA_FLAG
#SIMCONNECT_CREATE_CLIENT_DATA_FLAG_DEFAULT     = $00000000
#SIMCONNECT_CREATE_CLIENT_DATA_FLAG_READ_ONLY   = $00000001      ; permit only ClientData creator to write into ClientData


;SIMCONNECT_ENUM_FLAGS SIMCONNECT_CLIENT_DATA_REQUEST_FLAG
#SIMCONNECT_CLIENT_DATA_REQUEST_FLAG_DEFAULT    = $00000000
#SIMCONNECT_CLIENT_DATA_REQUEST_FLAG_CHANGED    = $00000001      ; send requested ClientData when value(s) change
#SIMCONNECT_CLIENT_DATA_REQUEST_FLAG_TAGGED     = $00000002		 ; send requested ClientData in tagged format

;SIMCONNECT_ENUM_FLAGS SIMCONNECT_CLIENT_DATA_SET_FLAG
#SIMCONNECT_CLIENT_DATA_SET_FLAG_DEFAULT        = $00000000
#SIMCONNECT_CLIENT_DATA_SET_FLAG_TAGGED         = $00000001      ; data is in tagged format


;SIMCONNECT_ENUM_FLAGS SIMCONNECT_VIEW_SYSTEM_EVENT_DATA                ; dwData contains these flags for the "View" System Event
#SIMCONNECT_VIEW_SYSTEM_EVENT_DATA_COCKPIT_2D      = $00000001      ; 2D Panels in cockpit view
#SIMCONNECT_VIEW_SYSTEM_EVENT_DATA_COCKPIT_VIRTUAL = $00000002		; Virtual (3D) panels in cockpit view
#SIMCONNECT_VIEW_SYSTEM_EVENT_DATA_ORTHOGONAL      = $00000004		; Orthogonal (Map) view

;SIMCONNECT_ENUM_FLAGS SIMCONNECT_SOUND_SYSTEM_EVENT_DATA            ; dwData contains these flags for the "Sound" System Event
#SIMCONNECT_SOUND_SYSTEM_EVENT_DATA_MASTER    = $00000001      ; Sound Master


;#ifdef ENABLE_SIMCONNECT_EXPERIMENTAL
;SIMCONNECT_ENUM_FLAGS SIMCONNECT_PICK_FLAGS
#SIMCONNECT_PICK_GROUND           = $01  ; pick ground/ pick result item is ground location
#SIMCONNECT_PICK_AI               = $02	 ; pick AI    / pick result item is AI, (dwSimObjectID is valid)
#SIMCONNECT_PICK_SCENERY          = $04	 ; pick scenery/ pick result item is scenery object (hSceneryObject is valid)
#SIMCONNECT_PICK_ALL              = #SIMCONNECT_PICK_SCENERY | #SIMCONNECT_PICK_AI | #SIMCONNECT_PICK_GROUND ; pick all / (not valid on pick result item)
#SIMCONNECT_PICK_COORDSASPIXELS   = $08



; //----------------------------------------------------------------------------
; //        User-defined enums
; //----------------------------------------------------------------------------

; #SIMCONNECT_NOTIFICATION_GROUP_ID      ; client-defined notification group ID
; #SIMCONNECT_INPUT_GROUP_ID             ; client-defined input group ID
; #SIMCONNECT_DATA_DEFINITION_ID         ; client-defined data definition ID
; #SIMCONNECT_DATA_REQUEST_ID            ; client-defined request data ID
;  
; #SIMCONNECT_CLIENT_EVENT_ID            ; client-defined client event ID
; #SIMCONNECT_CLIENT_DATA_ID             ; client-defined client data ID
; #SIMCONNECT_CLIENT_DATA_DEFINITION_ID  ; client-defined client data definition ID

;}


;- Structures
;{

; ~L375
; #pragma pack(push, 1) => Align 1


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV
; {
;     DWORD   dwSize;         // record size
;     DWORD   dwVersion;      // interface version
;     DWORD   dwID;           // see SIMCONNECT_RECV_ID
; };

Structure SIMCONNECT_RECV Align 1
	dwSize.DWORD
	dwVersion.DWORD
	dwID.DWORD
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_EXCEPTION : public SIMCONNECT_RECV   // when dwID == SIMCONNECT_RECV_ID_EXCEPTION
; {
;     DWORD   dwException;    // see SIMCONNECT_EXCEPTION
;     Static const DWORD UNKNOWN_SENDID = 0;
;     DWORD   dwSendID;       // see SimConnect_GetLastSentPacketID
;     Static const DWORD UNKNOWN_INDEX = DWORD_MAX;
;     DWORD   dwIndex;        // index of parameter that was source of error
; };

; (24|24)
Structure SIMCONNECT_RECV_EXCEPTION Extends SIMCONNECT_RECV Align 1
	dwException.DWORD
	dwSendID.DWORD
	dwIndex.DWORD
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_OPEN : public SIMCONNECT_RECV   // when dwID == SIMCONNECT_RECV_ID_OPEN
; {
;     SIMCONNECT_STRING(    szApplicationName, 256);
;     DWORD   dwApplicationVersionMajor;
;     DWORD   dwApplicationVersionMinor;
;     DWORD   dwApplicationBuildMajor;
;     DWORD   dwApplicationBuildMinor;
;     DWORD   dwSimConnectVersionMajor;
;     DWORD   dwSimConnectVersionMinor;
;     DWORD   dwSimConnectBuildMajor;
;     DWORD   dwSimConnectBuildMinor;
;     DWORD   dwReserved1;
;     DWORD   dwReserved2;
; };

; (308|308)
Structure SIMCONNECT_RECV_OPEN Extends SIMCONNECT_RECV Align 1
	szApplicationName.a[256] ; Can't be read with a PeekS apparently...
	dwApplicationVersionMajor.DWORD
	dwApplicationVersionMinor.DWORD
	dwApplicationBuildMajor.DWORD
	dwApplicationBuildMinor.DWORD
	dwSimConnectVersionMajor.DWORD
	dwSimConnectVersionMinor.DWORD
	dwSimConnectBuildMajor.DWORD
	dwSimConnectBuildMinor.DWORD
	dwReserved1.DWORD
	dwReserved2.DWORD
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_QUIT : public SIMCONNECT_RECV   // when dwID == SIMCONNECT_RECV_ID_QUIT
; {};

Structure SIMCONNECT_RECV_QUIT Extends SIMCONNECT_RECV Align 1 : EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_EVENT : public SIMCONNECT_RECV       // when dwID == SIMCONNECT_RECV_ID_EVENT
; {
;     Static const DWORD UNKNOWN_GROUP = DWORD_MAX;
;     DWORD   uGroupID;
;     DWORD   uEventID; 
;     DWORD   dwData;       // uEventID-dependent context
; };

; (24|24)
Structure SIMCONNECT_RECV_EVENT Extends SIMCONNECT_RECV Align 1
	uGroupID.DWORD
	uEventID.DWORD
	dwData.DWORD
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_EVENT_FILENAME : public SIMCONNECT_RECV_EVENT       // when dwID == SIMCONNECT_RECV_ID_EVENT_FILENAME
; {
;     SIMCONNECT_STRING(    szFileName, MAX_PATH);   // uEventID-dependent context
;     DWORD   dwFlags;
; };

; (288|288)
Structure SIMCONNECT_RECV_EVENT_FILENAME Extends SIMCONNECT_RECV_EVENT Align 1
	szApplicationName.a[#MAX_PATH]
	dwFlags.DWORD
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_EVENT_OBJECT_ADDREMOVE : public SIMCONNECT_RECV_EVENT       // when dwID == SIMCONNECT_RECV_ID_EVENT_FILENAME
; {
;     SIMCONNECT_SIMOBJECT_TYPE   eObjType;
; };

Structure SIMCONNECT_RECV_EVENT_OBJECT_ADDREMOVE Extends SIMCONNECT_RECV_EVENT Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_EVENT_FRAME : public SIMCONNECT_RECV_EVENT       // when dwID == SIMCONNECT_RECV_ID_EVENT_FRAME
; {
;     float   fFrameRate;
;     float   fSimSpeed;
; };

Structure SIMCONNECT_RECV_EVENT_FRAME Extends SIMCONNECT_RECV_EVENT Align 1
	fFrameRate.f
	fSimSpeed.f
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_EVENT_MULTIPLAYER_SERVER_STARTED : public SIMCONNECT_RECV_EVENT       // when dwID == SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_SERVER_STARTED
; {
;     // No event specific Data, For now
; };

Structure SIMCONNECT_RECV_EVENT_MULTIPLAYER_SERVER_STARTED Extends SIMCONNECT_RECV_EVENT Align 1
	; No event specific Data, For now
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_EVENT_MULTIPLAYER_CLIENT_STARTED : public SIMCONNECT_RECV_EVENT       // when dwID == SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_CLIENT_STARTED
; {
;     // No event specific Data, For now
; };

Structure SIMCONNECT_RECV_EVENT_MULTIPLAYER_CLIENT_STARTED Extends SIMCONNECT_RECV_EVENT Align 1
	; No event specific Data, For now
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_EVENT_MULTIPLAYER_SESSION_ENDED : public SIMCONNECT_RECV_EVENT       // when dwID == SIMCONNECT_RECV_ID_EVENT_MULTIPLAYER_SESSION_ENDED
; {
;     // No event specific Data, For now
; };

Structure SIMCONNECT_RECV_EVENT_MULTIPLAYER_SESSION_ENDED Extends SIMCONNECT_RECV_EVENT Align 1
	; No event specific Data, For now
EndStructure


; // SIMCONNECT_DATA_RACE_RESULT
; SIMCONNECT_STRUCT SIMCONNECT_DATA_RACE_RESULT
; {
;     DWORD   dwNumberOfRacers;                         // The total number of racers
;     SIMCONNECT_GUID MissionGUID;                      // The name of the mission to execute, NULL if no mission
;     SIMCONNECT_STRING( szPlayerName, MAX_PATH);       // The name of the player
;     SIMCONNECT_STRING( szSessionType, MAX_PATH);      // The type of the multiplayer session: "LAN", "GAMESPY")
;     SIMCONNECT_STRING( szAircraft, MAX_PATH);         // The aircraft type 
;     SIMCONNECT_STRING( szPlayerRole, MAX_PATH);       // The player role in the mission
;     double   fTotalTime;                              // Total time in seconds, 0 means DNF
;     double   fPenaltyTime;                            // Total penalty time in seconds
;     DWORD   dwIsDisqualified;                         // non 0 - disqualified, 0 - not disqualified
; };

Structure SIMCONNECT_DATA_RACE_RESULT Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_EVENT_RACE_END : public SIMCONNECT_RECV_EVENT       // when dwID == SIMCONNECT_RECV_ID_EVENT_RACE_END
; {
;     DWORD   dwRacerNumber;                            // The index of the racer the results are for
;     SIMCONNECT_DATA_RACE_RESULT RacerData;
; };

Structure SIMCONNECT_RECV_EVENT_RACE_END  Extends SIMCONNECT_RECV_EVENT Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_EVENT_RACE_LAP : public SIMCONNECT_RECV_EVENT       // when dwID == SIMCONNECT_RECV_ID_EVENT_RACE_LAP
; {
;     DWORD   dwLapIndex;                               // The index of the lap the results are for
;     SIMCONNECT_DATA_RACE_RESULT RacerData;
; };

Structure SIMCONNECT_RECV_EVENT_RACE_LAP Extends SIMCONNECT_RECV_EVENT Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_SIMOBJECT_DATA : public SIMCONNECT_RECV           // when dwID == SIMCONNECT_RECV_ID_SIMOBJECT_DATA
; {
;     DWORD   dwRequestID;
;     DWORD   dwObjectID;
;     DWORD   dwDefineID;
;     DWORD   dwFlags;            // SIMCONNECT_DATA_REQUEST_FLAG
;     DWORD   dwentrynumber;      // if multiple objects returned, this is number <entrynumber> out of <outof>.
;     DWORD   dwoutof;            // note: starts with 1, not 0.          
;     DWORD   dwDefineCount;      // data count (number of datums, *not* byte count)
;     SIMCONNECT_DATAV(   dwData, dwDefineID, );             // data begins here, dwDefineCount data items
; };

Structure SIMCONNECT_RECV_SIMOBJECT_DATA Extends SIMCONNECT_RECV Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_SIMOBJECT_DATA_BYTYPE : public SIMCONNECT_RECV_SIMOBJECT_DATA           // when dwID == SIMCONNECT_RECV_ID_SIMOBJECT_DATA_BYTYPE
; {
; };

Structure SIMCONNECT_RECV_SIMOBJECT_DATA_BYTYPE Extends SIMCONNECT_RECV_SIMOBJECT_DATA Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_CLIENT_DATA : public SIMCONNECT_RECV_SIMOBJECT_DATA    // when dwID == SIMCONNECT_RECV_ID_CLIENT_DATA
; {
; };

Structure SIMCONNECT_RECV_CLIENT_DATA Extends SIMCONNECT_RECV_SIMOBJECT_DATA Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_WEATHER_OBSERVATION : public SIMCONNECT_RECV // when dwID == SIMCONNECT_RECV_ID_WEATHER_OBSERVATION
; {
;     DWORD   dwRequestID;
;     SIMCONNECT_STRINGV( szMetar);      // Variable length string whose maximum size is MAX_METAR_LENGTH
; };

Structure SIMCONNECT_RECV_WEATHER_OBSERVATION Extends SIMCONNECT_RECV Align 1
	
EndStructure


; Static const int SIMCONNECT_CLOUD_STATE_ARRAY_WIDTH = 64;
; Static const int SIMCONNECT_CLOUD_STATE_ARRAY_SIZE = SIMCONNECT_CLOUD_STATE_ARRAY_WIDTH*SIMCONNECT_CLOUD_STATE_ARRAY_WIDTH;


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_CLOUD_STATE : public SIMCONNECT_RECV // when dwID == SIMCONNECT_RECV_ID_CLOUD_STATE
; {
;     DWORD   dwRequestID;
;     DWORD   dwArraySize;
;     SIMCONNECT_FIXEDTYPE_DATAV(BYTE,    rgbData, dwArraySize, U1 /*member of UnmanagedType enum*/ , System::Byte /*cli type*/);
; };

Structure SIMCONNECT_RECV_CLOUD_STATE Extends SIMCONNECT_RECV Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_ASSIGNED_OBJECT_ID : public SIMCONNECT_RECV // when dwID == SIMCONNECT_RECV_ID_ASSIGNED_OBJECT_ID
; {
;     DWORD   dwRequestID;
;     DWORD   dwObjectID;
; };

Structure SIMCONNECT_RECV_ASSIGNED_OBJECT_ID Extends SIMCONNECT_RECV Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_RESERVED_KEY : public SIMCONNECT_RECV // when dwID == SIMCONNECT_RECV_ID_RESERVED_KEY
; {
;     SIMCONNECT_STRING(    szChoiceReserved, 30);
;     SIMCONNECT_STRING(    szReservedKey, 50);
; };

Structure SIMCONNECT_RECV_RESERVED_KEY Extends SIMCONNECT_RECV Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_SYSTEM_STATE : public SIMCONNECT_RECV // when dwID == SIMCONNECT_RECV_ID_SYSTEM_STATE
; {
;     DWORD   dwRequestID;
;     DWORD   dwInteger;
;     float   fFloat;
;     SIMCONNECT_STRING(    szString, MAX_PATH);
; };

Structure SIMCONNECT_RECV_SYSTEM_STATE Extends SIMCONNECT_RECV Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_CUSTOM_ACTION : public SIMCONNECT_RECV_EVENT
; {
;     SIMCONNECT_GUID guidInstanceId;      // Instance id of the action that executed
;     DWORD dwWaitForCompletion;           // Wait for completion flag on the action
;     SIMCONNECT_STRINGV( szPayLoad);      // Variable length string payload associated with the mission action.  
; };

Structure SIMCONNECT_RECV_CUSTOM_ACTION Extends SIMCONNECT_RECV_EVENT Align 1
	
EndStructure


; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_EVENT_WEATHER_MODE : public SIMCONNECT_RECV_EVENT
; {
;     // No event specific Data - the new weather mode is in the base Structure dwData member.
; };

Structure SIMCONNECT_RECV_EVENT_WEATHER_MODE Extends SIMCONNECT_RECV_EVENT Align 1
	
EndStructure


; // SIMCONNECT_RECV_FACILITIES_LIST
; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_FACILITIES_LIST : public SIMCONNECT_RECV
; {
;     DWORD   dwRequestID;
;     DWORD   dwArraySize;
;     DWORD   dwEntryNumber;  // when the array of items is too big for one send, which send this is (0..dwOutOf-1)
;     DWORD   dwOutOf;        // total number of transmissions the list is chopped into
; };

Structure SIMCONNECT_RECV_FACILITIES_LIST Extends SIMCONNECT_RECV Align 1
	
EndStructure


; // SIMCONNECT_DATA_FACILITY_AIRPORT
; SIMCONNECT_REFSTRUCT SIMCONNECT_DATA_FACILITY_AIRPORT
; {
;     SIMCONNECT_STRING(Icao, 9);     // ICAO of the object
;     double  Latitude;               // degrees
;     double  Longitude;              // degrees
;     double  Altitude;               // meters   
; };

Structure SIMCONNECT_DATA_FACILITY_AIRPORT Align 1
	
EndStructure


; // SIMCONNECT_RECV_AIRPORT_LIST
; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_AIRPORT_LIST : public SIMCONNECT_RECV_FACILITIES_LIST
; {
;     SIMCONNECT_FIXEDTYPE_DATAV(SIMCONNECT_DATA_FACILITY_AIRPORT, rgData, dwArraySize, U1 /*member of UnmanagedType enum*/, SIMCONNECT_DATA_FACILITY_AIRPORT /*cli type*/);
; };

Structure SIMCONNECT_RECV_AIRPORT_LIST Extends SIMCONNECT_RECV_FACILITIES_LIST Align 1
	
EndStructure


; // SIMCONNECT_DATA_FACILITY_WAYPOINT
; SIMCONNECT_REFSTRUCT SIMCONNECT_DATA_FACILITY_WAYPOINT : public SIMCONNECT_DATA_FACILITY_AIRPORT
; {
;     float   fMagVar;                // Magvar in degrees
; };

Structure SIMCONNECT_DATA_FACILITY_WAYPOINT Extends SIMCONNECT_DATA_FACILITY_AIRPORT Align 1
	
EndStructure


; // SIMCONNECT_RECV_WAYPOINT_LIST
; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_WAYPOINT_LIST : public SIMCONNECT_RECV_FACILITIES_LIST
; {
;     SIMCONNECT_FIXEDTYPE_DATAV(SIMCONNECT_DATA_FACILITY_WAYPOINT, rgData, dwArraySize, U1 /*member of UnmanagedType enum*/, SIMCONNECT_DATA_FACILITY_WAYPOINT /*cli type*/);
; };

Structure SIMCONNECT_RECV_WAYPOINT_LIST Extends SIMCONNECT_RECV_FACILITIES_LIST Align 1
	
EndStructure


; // SIMCONNECT_DATA_FACILITY_NDB
; SIMCONNECT_REFSTRUCT SIMCONNECT_DATA_FACILITY_NDB : public SIMCONNECT_DATA_FACILITY_WAYPOINT
; {
;     DWORD   fFrequency;             // frequency in Hz
; };

Structure SIMCONNECT_DATA_FACILITY_NDB Extends SIMCONNECT_DATA_FACILITY_WAYPOINT Align 1
	
EndStructure


; // SIMCONNECT_RECV_NDB_LIST
; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_NDB_LIST : public SIMCONNECT_RECV_FACILITIES_LIST
; {
;     SIMCONNECT_FIXEDTYPE_DATAV(SIMCONNECT_DATA_FACILITY_NDB, rgData, dwArraySize, U1 /*member of UnmanagedType enum*/, SIMCONNECT_DATA_FACILITY_NDB /*cli type*/);
; };

Structure SIMCONNECT_RECV_NDB_LIST Extends SIMCONNECT_RECV_FACILITIES_LIST Align 1
	
EndStructure


; // SIMCONNECT_DATA_FACILITY_VOR
; SIMCONNECT_REFSTRUCT SIMCONNECT_DATA_FACILITY_VOR : public SIMCONNECT_DATA_FACILITY_NDB
; {
;     DWORD   Flags;                  // SIMCONNECT_VOR_FLAGS
;     float   fLocalizer;             // Localizer in degrees
;     double  GlideLat;               // Glide Slope Location (deg, deg, meters)
;     double  GlideLon;
;     double  GlideAlt;
;     float   fGlideSlopeAngle;       // Glide Slope in degrees
; };

Structure SIMCONNECT_DATA_FACILITY_VOR Extends SIMCONNECT_DATA_FACILITY_NDB Align 1
	
EndStructure


; // SIMCONNECT_RECV_VOR_LIST
; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_VOR_LIST : public SIMCONNECT_RECV_FACILITIES_LIST
; {
;     SIMCONNECT_FIXEDTYPE_DATAV(SIMCONNECT_DATA_FACILITY_VOR, rgData, dwArraySize, U1 /*member of UnmanagedType enum*/, SIMCONNECT_DATA_FACILITY_VOR /*cli type*/);
; };

Structure SIMCONNECT_RECV_VOR_LIST Extends SIMCONNECT_RECV_FACILITIES_LIST Align 1
	
EndStructure


; #ifdef ENABLE_SIMCONNECT_EXPERIMENTAL
; 
; SIMCONNECT_REFSTRUCT SIMCONNECT_RECV_PICK : public SIMCONNECT_RECV // when dwID == SIMCONNECT_RECV_ID_RESERVED_KEY
; {
;     HANDLE  hContext;
;     DWORD   dwFlags;  //
;     double  Latitude;   // degrees
;     double  Longitude;  // degrees
;     double  Altitude;   // feet   
;     int     xPos; //reserved
;     int     yPos; //reserved;
;     DWORD   dwSimObjectID;
;     HANDLE  hSceneryObject;
;     DWORD   dwentrynumber;      // if multiple objects returned, this is number <entrynumber> out of <outof>.
;     DWORD   dwoutof;            // note: starts with 1, not 0.          
; };

Structure SIMCONNECT_RECV_PICK Extends SIMCONNECT_RECV Align 1
	
EndStructure


; #endif //ENABLE_SIMCONNECT_EXPERIMENTAL


; // SIMCONNECT_DATATYPE_INITPOSITION
; SIMCONNECT_STRUCT SIMCONNECT_DATA_INITPOSITION
; {
;     double  Latitude;   // degrees
;     double  Longitude;  // degrees
;     double  Altitude;   // feet   
;     double  Pitch;      // degrees
;     double  Bank;       // degrees
;     double  Heading;    // degrees
;     DWORD   OnGround;   // 1=force to be on the ground
;     DWORD   Airspeed;   // knots
; };

Structure SIMCONNECT_DATA_INITPOSITION Align 1
	
EndStructure


; // SIMCONNECT_DATATYPE_MARKERSTATE
; SIMCONNECT_STRUCT SIMCONNECT_DATA_MARKERSTATE
; {
;     SIMCONNECT_STRING(    szMarkerName, 64);
;     DWORD   dwMarkerState;
; };

Structure SIMCONNECT_DATA_MARKERSTATE Align 1
	
EndStructure


; // SIMCONNECT_DATATYPE_WAYPOINT
; SIMCONNECT_STRUCT SIMCONNECT_DATA_WAYPOINT
; {
;     double          Latitude;   // degrees
;     double          Longitude;  // degrees
;     double          Altitude;   // feet   
;     unsigned long   Flags;
;     double          ktsSpeed;   // knots
;     double          percentThrottle;
; };

Structure SIMCONNECT_DATA_WAYPOINT Align 1
	
EndStructure


; // SIMCONNECT_DATA_LATLONALT (24:24)
; SIMCONNECT_STRUCT SIMCONNECT_DATA_LATLONALT
; {
;     double  Latitude;
;     double  Longitude;
;     double  Altitude;
; };

Structure SIMCONNECT_DATA_LATLONALT Align 1
	Latitude.d
	Longitude.d
	Altitude.d
EndStructure


; // SIMCONNECT_DATA_XYZ (24:24)
; SIMCONNECT_STRUCT SIMCONNECT_DATA_XYZ
; {
;     double  x;
;     double  y;
;     double  z;
; };

Structure SIMCONNECT_DATA_XYZ Align 1
	x.d
	y.d
	z.d
EndStructure

;}


; #pragma pack(pop)
; 
; //----------------------------------------------------------------------------
; //        End of Struct definitions
; //----------------------------------------------------------------------------
; 
; typedef void (CALLBACK *DispatchProc)(SIMCONNECT_RECV* pData, DWORD cbData, void* pContext);
; 
; #if !Defined(SIMCONNECTAPI)
; 	#ifdef _MSFS_WASM
; 		#ifdef __INTELLISENSE__
; 			#define MODULE_EXPORT
; 			#define SIMCONNECTAPI extern "C" HRESULT
; 		#else
; 			#define MODULE_EXPORT __attribute__( ( visibility( "default" ) ) )
; 			#define SIMCONNECTAPI extern "C" __attribute__((import_module(SIMCONNECT_WASM_MODULE))) HRESULT
; 		#endif
; 	#else
; 		#define MODULE_EXPORT
; 		#define SIMCONNECTAPI extern "C" HRESULT __stdcall
; 	#endif
; #endif

Prototype.HRESULT DispatchProc(*pData.SIMCONNECT_RECV, cbData.DWORD, *pContext)


;- Imports
;{

;Import "C:\MSFS SDK\SimConnect SDK\lib\static\SimConnect.lib"
Import "C:\MSFS SDK\SimConnect SDK\lib\SimConnect.lib"
	
	; SIMCONNECTAPI SimConnect_MapClientEventToSimEvent(HANDLE hSimConnect, SIMCONNECT_CLIENT_EVENT_ID EventID, const char * EventName = "");
	; SIMCONNECTAPI SimConnect_TransmitClientEvent(HANDLE hSimConnect, SIMCONNECT_OBJECT_ID ObjectID, SIMCONNECT_CLIENT_EVENT_ID EventID, DWORD dwData, SIMCONNECT_NOTIFICATION_GROUP_ID GroupID, SIMCONNECT_EVENT_FLAG Flags);
	; SIMCONNECTAPI SimConnect_SetSystemEventState(HANDLE hSimConnect, SIMCONNECT_CLIENT_EVENT_ID EventID, SIMCONNECT_STATE dwState);
	
	; SIMCONNECTAPI SimConnect_AddClientEventToNotificationGroup(HANDLE hSimConnect, SIMCONNECT_NOTIFICATION_GROUP_ID GroupID, SIMCONNECT_CLIENT_EVENT_ID EventID, BOOL bMaskable = FALSE);
	SimConnect_AddClientEventToNotificationGroup(hSimConnect.HANDLE, GroupID.SIMCONNECT_NOTIFICATION_GROUP_ID, EventID.SIMCONNECT_CLIENT_EVENT_ID, bMaskable.BOOL = #False)
	
	; SIMCONNECTAPI SimConnect_RemoveClientEvent(HANDLE hSimConnect, SIMCONNECT_NOTIFICATION_GROUP_ID GroupID, SIMCONNECT_CLIENT_EVENT_ID EventID);
	; SIMCONNECTAPI SimConnect_SetNotificationGroupPriority(HANDLE hSimConnect, SIMCONNECT_NOTIFICATION_GROUP_ID GroupID, DWORD uPriority);
	; SIMCONNECTAPI SimConnect_ClearNotificationGroup(HANDLE hSimConnect, SIMCONNECT_NOTIFICATION_GROUP_ID GroupID);
	; SIMCONNECTAPI SimConnect_RequestNotificationGroup(HANDLE hSimConnect, SIMCONNECT_NOTIFICATION_GROUP_ID GroupID, DWORD dwReserved = 0, DWORD Flags = 0);
	; SIMCONNECTAPI SimConnect_AddToDataDefinition(HANDLE hSimConnect, SIMCONNECT_DATA_DEFINITION_ID DefineID, const char * DatumName, const char * UnitsName, SIMCONNECT_DATATYPE DatumType = SIMCONNECT_DATATYPE_FLOAT64, float fEpsilon = 0, DWORD DatumID = SIMCONNECT_UNUSED);
	; SIMCONNECTAPI SimConnect_ClearDataDefinition(HANDLE hSimConnect, SIMCONNECT_DATA_DEFINITION_ID DefineID);
	; SIMCONNECTAPI SimConnect_RequestDataOnSimObject(HANDLE hSimConnect, SIMCONNECT_DATA_REQUEST_ID RequestID, SIMCONNECT_DATA_DEFINITION_ID DefineID, SIMCONNECT_OBJECT_ID ObjectID, SIMCONNECT_PERIOD Period, SIMCONNECT_DATA_REQUEST_FLAG Flags = 0, DWORD origin = 0, DWORD interval = 0, DWORD limit = 0);
	; SIMCONNECTAPI SimConnect_RequestDataOnSimObjectType(HANDLE hSimConnect, SIMCONNECT_DATA_REQUEST_ID RequestID, SIMCONNECT_DATA_DEFINITION_ID DefineID, DWORD dwRadiusMeters, SIMCONNECT_SIMOBJECT_TYPE type);
	; SIMCONNECTAPI SimConnect_SetDataOnSimObject(HANDLE hSimConnect, SIMCONNECT_DATA_DEFINITION_ID DefineID, SIMCONNECT_OBJECT_ID ObjectID, SIMCONNECT_DATA_SET_FLAG Flags, DWORD ArrayCount, DWORD cbUnitSize, void * pDataSet);
	; SIMCONNECTAPI SimConnect_MapInputEventToClientEvent(HANDLE hSimConnect, SIMCONNECT_INPUT_GROUP_ID GroupID, const char * szInputDefinition, SIMCONNECT_CLIENT_EVENT_ID DownEventID, DWORD DownValue = 0, SIMCONNECT_CLIENT_EVENT_ID UpEventID = (SIMCONNECT_CLIENT_EVENT_ID)SIMCONNECT_UNUSED, DWORD UpValue = 0, BOOL bMaskable = FALSE);
	; SIMCONNECTAPI SimConnect_SetInputGroupPriority(HANDLE hSimConnect, SIMCONNECT_INPUT_GROUP_ID GroupID, DWORD uPriority);
	; SIMCONNECTAPI SimConnect_RemoveInputEvent(HANDLE hSimConnect, SIMCONNECT_INPUT_GROUP_ID GroupID, const char * szInputDefinition);
	; SIMCONNECTAPI SimConnect_ClearInputGroup(HANDLE hSimConnect, SIMCONNECT_INPUT_GROUP_ID GroupID);
	; SIMCONNECTAPI SimConnect_SetInputGroupState(HANDLE hSimConnect, SIMCONNECT_INPUT_GROUP_ID GroupID, DWORD dwState);
	; SIMCONNECTAPI SimConnect_RequestReservedKey(HANDLE hSimConnect, SIMCONNECT_CLIENT_EVENT_ID EventID, const char * szKeyChoice1 = "", const char * szKeyChoice2 = "", const char * szKeyChoice3 = "");
	; SIMCONNECTAPI SimConnect_SubscribeToSystemEvent(HANDLE hSimConnect, SIMCONNECT_CLIENT_EVENT_ID EventID, const char * SystemEventName);
	; SIMCONNECTAPI SimConnect_UnsubscribeFromSystemEvent(HANDLE hSimConnect, SIMCONNECT_CLIENT_EVENT_ID EventID);
	; SIMCONNECTAPI SimConnect_WeatherRequestInterpolatedObservation(HANDLE hSimConnect, SIMCONNECT_DATA_REQUEST_ID RequestID, float lat, float lon, float alt);
	; SIMCONNECTAPI SimConnect_WeatherRequestObservationAtStation(HANDLE hSimConnect, SIMCONNECT_DATA_REQUEST_ID RequestID, const char * szICAO);
	; SIMCONNECTAPI SimConnect_WeatherRequestObservationAtNearestStation(HANDLE hSimConnect, SIMCONNECT_DATA_REQUEST_ID RequestID, float lat, float lon);
	; SIMCONNECTAPI SimConnect_WeatherCreateStation(HANDLE hSimConnect, SIMCONNECT_DATA_REQUEST_ID RequestID, const char * szICAO, const char * szName, float lat, float lon, float alt);
	; SIMCONNECTAPI SimConnect_WeatherRemoveStation(HANDLE hSimConnect, SIMCONNECT_DATA_REQUEST_ID RequestID, const char * szICAO);
	; SIMCONNECTAPI SimConnect_WeatherSetObservation(HANDLE hSimConnect, DWORD Seconds, const char * szMETAR);
	; SIMCONNECTAPI SimConnect_WeatherSetModeServer(HANDLE hSimConnect, DWORD dwPort, DWORD dwSeconds);
	; SIMCONNECTAPI SimConnect_WeatherSetModeTheme(HANDLE hSimConnect, const char * szThemeName);
	; SIMCONNECTAPI SimConnect_WeatherSetModeGlobal(HANDLE hSimConnect);
	; SIMCONNECTAPI SimConnect_WeatherSetModeCustom(HANDLE hSimConnect);
	; SIMCONNECTAPI SimConnect_WeatherSetDynamicUpdateRate(HANDLE hSimConnect, DWORD dwRate);
	; SIMCONNECTAPI SimConnect_WeatherRequestCloudState(HANDLE hSimConnect, SIMCONNECT_DATA_REQUEST_ID RequestID, float minLat, float minLon, float minAlt, float maxLat, float maxLon, float maxAlt, DWORD dwFlags = 0);
	; SIMCONNECTAPI SimConnect_WeatherCreateThermal(HANDLE hSimConnect, SIMCONNECT_DATA_REQUEST_ID RequestID, float lat, float lon, float alt, float radius, float height, float coreRate = 3.0f, float coreTurbulence = 0.05f, float sinkRate = 3.0f, float sinkTurbulence = 0.2f, float coreSize = 0.4f, float coreTransitionSize = 0.1f, float sinkLayerSize = 0.4f, float sinkTransitionSize = 0.1f);
	; SIMCONNECTAPI SimConnect_WeatherRemoveThermal(HANDLE hSimConnect, SIMCONNECT_OBJECT_ID ObjectID);
	; SIMCONNECTAPI SimConnect_AICreateParkedATCAircraft(HANDLE hSimConnect, const char * szContainerTitle, const char * szTailNumber, const char * szAirportID, SIMCONNECT_DATA_REQUEST_ID RequestID);
	; SIMCONNECTAPI SimConnect_AICreateEnrouteATCAircraft(HANDLE hSimConnect, const char * szContainerTitle, const char * szTailNumber, int iFlightNumber, const char * szFlightPlanPath, double dFlightPlanPosition, BOOL bTouchAndGo, SIMCONNECT_DATA_REQUEST_ID RequestID);
	; SIMCONNECTAPI SimConnect_AICreateNonATCAircraft(HANDLE hSimConnect, const char * szContainerTitle, const char * szTailNumber, SIMCONNECT_DATA_INITPOSITION InitPos, SIMCONNECT_DATA_REQUEST_ID RequestID);
	; SIMCONNECTAPI SimConnect_AICreateSimulatedObject(HANDLE hSimConnect, const char * szContainerTitle, SIMCONNECT_DATA_INITPOSITION InitPos, SIMCONNECT_DATA_REQUEST_ID RequestID);
	; SIMCONNECTAPI SimConnect_AIReleaseControl(HANDLE hSimConnect, SIMCONNECT_OBJECT_ID ObjectID, SIMCONNECT_DATA_REQUEST_ID RequestID);
	; SIMCONNECTAPI SimConnect_AIRemoveObject(HANDLE hSimConnect, SIMCONNECT_OBJECT_ID ObjectID, SIMCONNECT_DATA_REQUEST_ID RequestID);
	; SIMCONNECTAPI SimConnect_AISetAircraftFlightPlan(HANDLE hSimConnect, SIMCONNECT_OBJECT_ID ObjectID, const char * szFlightPlanPath, SIMCONNECT_DATA_REQUEST_ID RequestID);
	; SIMCONNECTAPI SimConnect_ExecuteMissionAction(HANDLE hSimConnect, const GUID guidInstanceId);
	; SIMCONNECTAPI SimConnect_CompleteCustomMissionAction(HANDLE hSimConnect, const GUID guidInstanceId);
	
	; SIMCONNECTAPI SimConnect_Close(HANDLE hSimConnect);
	SimConnect_Close(hSimConnect.HANDLE)
	
	; SIMCONNECTAPI SimConnect_RetrieveString(SIMCONNECT_RECV * pData, DWORD cbData, void * pStringV, char ** pszString, DWORD * pcbString);
	; SIMCONNECTAPI SimConnect_GetLastSentPacketID(HANDLE hSimConnect, DWORD * pdwError);
	
	; SIMCONNECTAPI SimConnect_Open(HANDLE * phSimConnect, LPCSTR szName, HWND hWnd, DWORD UserEventWin32, HANDLE hEventHandle, DWORD ConfigIndex);
	SimConnect_Open(*phSimConnect, szName.s, hWnd.HWND, UserEventWin32.DWORD, hEventHandle.HANDLE, ConfigIndex.DWORD)
	
	; SIMCONNECTAPI SimConnect_CallDispatch(HANDLE hSimConnect, DispatchProc pfcnDispatch, void * pContext);
	SimConnect_CallDispatch(hSimConnect.HANDLE, pfcnDispatch.DispatchProc, *pContext)
	
	; SIMCONNECTAPI SimConnect_GetNextDispatch(HANDLE hSimConnect, SIMCONNECT_RECV ** ppData, DWORD * pcbData);
	; SIMCONNECTAPI SimConnect_RequestResponseTimes(HANDLE hSimConnect, DWORD nCount, float * fElapsedSeconds);
	; SIMCONNECTAPI SimConnect_InsertString(char * pDest, DWORD cbDest, void ** ppEnd, DWORD * pcbStringV, const char * pSource);
	; SIMCONNECTAPI SimConnect_CameraSetRelative6DOF(HANDLE hSimConnect, float fDeltaX, float fDeltaY, float fDeltaZ, float fPitchDeg, float fBankDeg, float fHeadingDeg);
	; SIMCONNECTAPI SimConnect_MenuAddItem(HANDLE hSimConnect, const char * szMenuItem, SIMCONNECT_CLIENT_EVENT_ID MenuEventID, DWORD dwData);
	; SIMCONNECTAPI SimConnect_MenuDeleteItem(HANDLE hSimConnect, SIMCONNECT_CLIENT_EVENT_ID MenuEventID);
	; SIMCONNECTAPI SimConnect_MenuAddSubItem(HANDLE hSimConnect, SIMCONNECT_CLIENT_EVENT_ID MenuEventID, const char * szMenuItem, SIMCONNECT_CLIENT_EVENT_ID SubMenuEventID, DWORD dwData);
	; SIMCONNECTAPI SimConnect_MenuDeleteSubItem(HANDLE hSimConnect, SIMCONNECT_CLIENT_EVENT_ID MenuEventID, const SIMCONNECT_CLIENT_EVENT_ID SubMenuEventID);
	; SIMCONNECTAPI SimConnect_RequestSystemState(HANDLE hSimConnect, SIMCONNECT_DATA_REQUEST_ID RequestID, const char * szState);
	; SIMCONNECTAPI SimConnect_SetSystemState(HANDLE hSimConnect, const char * szState, DWORD dwInteger, float fFloat, const char * szString);
	; SIMCONNECTAPI SimConnect_MapClientDataNameToID(HANDLE hSimConnect, const char * szClientDataName, SIMCONNECT_CLIENT_DATA_ID ClientDataID);
	; SIMCONNECTAPI SimConnect_CreateClientData(HANDLE hSimConnect, SIMCONNECT_CLIENT_DATA_ID ClientDataID, DWORD dwSize, SIMCONNECT_CREATE_CLIENT_DATA_FLAG Flags);
	; SIMCONNECTAPI SimConnect_AddToClientDataDefinition(HANDLE hSimConnect, SIMCONNECT_CLIENT_DATA_DEFINITION_ID DefineID, DWORD dwOffset, DWORD dwSizeOrType, float fEpsilon = 0, DWORD DatumID = SIMCONNECT_UNUSED);
	; SIMCONNECTAPI SimConnect_ClearClientDataDefinition(HANDLE hSimConnect, SIMCONNECT_CLIENT_DATA_DEFINITION_ID DefineID);
	; SIMCONNECTAPI SimConnect_RequestClientData(HANDLE hSimConnect, SIMCONNECT_CLIENT_DATA_ID ClientDataID, SIMCONNECT_DATA_REQUEST_ID RequestID, SIMCONNECT_CLIENT_DATA_DEFINITION_ID DefineID, SIMCONNECT_CLIENT_DATA_PERIOD Period = SIMCONNECT_CLIENT_DATA_PERIOD_ONCE, SIMCONNECT_CLIENT_DATA_REQUEST_FLAG Flags = 0, DWORD origin = 0, DWORD interval = 0, DWORD limit = 0);
	; SIMCONNECTAPI SimConnect_SetClientData(HANDLE hSimConnect, SIMCONNECT_CLIENT_DATA_ID ClientDataID, SIMCONNECT_CLIENT_DATA_DEFINITION_ID DefineID, SIMCONNECT_CLIENT_DATA_SET_FLAG Flags, DWORD dwReserved, DWORD cbUnitSize, void * pDataSet);
	; SIMCONNECTAPI SimConnect_FlightLoad(HANDLE hSimConnect, const char * szFileName);
	; SIMCONNECTAPI SimConnect_FlightSave(HANDLE hSimConnect, const char * szFileName, const char * szTitle, const char * szDescription, DWORD Flags);
	; SIMCONNECTAPI SimConnect_FlightPlanLoad(HANDLE hSimConnect, const char * szFileName);
	; SIMCONNECTAPI SimConnect_Text(HANDLE hSimConnect, SIMCONNECT_TEXT_TYPE type, float fTimeSeconds, SIMCONNECT_CLIENT_EVENT_ID EventID, DWORD cbUnitSize, void * pDataSet);
	; SIMCONNECTAPI SimConnect_SubscribeToFacilities(HANDLE hSimConnect, SIMCONNECT_FACILITY_LIST_TYPE type, SIMCONNECT_DATA_REQUEST_ID RequestID);
	; SIMCONNECTAPI SimConnect_UnsubscribeToFacilities(HANDLE hSimConnect, SIMCONNECT_FACILITY_LIST_TYPE type);
	; SIMCONNECTAPI SimConnect_RequestFacilitiesList(HANDLE hSimConnect, SIMCONNECT_FACILITY_LIST_TYPE type, SIMCONNECT_DATA_REQUEST_ID RequestID);
	
EndImport

;}
