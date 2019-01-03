PROGRAM_NAME='events'

DEFINE_EVENT (* Hardware Events Get processed here *)

DATA_EVENT[dvIOPortsS1]
{
    ONLINE:
    {
	// Set house back door input to low
	SEND_COMMAND dvIOPortsS1, 'SET INPUT 1 LOW'
	// Set house back door input debounce to 250ms
	SEND_COMMAND dvIOPortsS1, 'SET DBT 1 50'
    }
}
DATA_EVENT[dvIOPortsS2]
{
    ONLINE:
    {
        // Set garage door closed input to low
	SEND_COMMAND dvIOPortsS2, 'SET INPUT 1 LOW'
	// Setup garage door closed input debounce to 250ms
	SEND_COMMAND dvIOPortsS2, 'SET DBT 1 50'
	//Set standby sense input 1 to low
	SEND_COMMAND dvIOPortsS2, 'SET INPUT 2 LOW'
	//Set power sense input 1 to low
	SEND_COMMAND dvIOPortsS2, 'SET INPUT 3 LOW'
	//Set standby sense input 2 to low (garage door light)
	SEND_COMMAND dvIOPortsS2, 'SET INPUT 4 LOW'
	//Set power sense input 2 to low (garage door motor)
	SEND_COMMAND dvIOPortsS2, 'SET INPUT 5 LOW'
	//Set power sense output 6 to low (patio lighting)
	SEND_COMMAND dvIOPortsS2, 'SET OUTPUT 6 LOW'
	OFF[dvIOPortsS2, IO_PATIO_SSR] //Start in an off state
    }
}
DATA_EVENT[dvIP_Server]
{
    STRING:
    {
	SEND_STRING 0, "'Incoming string from IP Client:'"
	SEND_STRING 0, "'"',DATA.TEXT,'"'"
	PULSE[dvRelaysS2, RELAY_GARAGE_DOOR]
    }
}
DATA_EVENT[dvIP_Pioneer_Client]
{
    ONERROR:
    {
	SEND_STRING 0,"'error: client=',ITOA(Data.Number)"
    }
    ONLINE:
    {
	SEND_STRING 0,"'online: client'"
    }
    OFFLINE:
    {
	SEND_STRING 0,"'offline: client'"
    }
    STRING:
    {
	SEND_STRING 0,"'string: client=',Data.Text"
    }
}
BUTTON_EVENT[vdv_TPs, BUTTON_REBOOT_MASTER]
{
    PUSH:
    {
	REBOOT(0:0:0)
    }
}
(*
- Power On - PO
- Power Off - PF
- Volume Up - VU
- Volume Down - VD
- Volume Set - ***VL (000 to 185)
- Volume Query - ?V (VOL160)
- Mute On - MO
- Mute Off - MF
- Input Set - **FN (19 - PS3, 20 - Computer, 01 - Chrome Cast, 02 - Tuner?, 05 - TV)
- Input Query - ?F (FN01)
- Listening Mode? - See Manual (to turn off the center channel if needed)
- Channel Level (for basement speaker) - C__**CLV (26 to 74)
- Channel Level Query - ?C__CLV (CLVC__50)
- Projector On
- Projector Off
- Listen to Chrome Cast (PO, VOL100, MF, 01FN, Projector Off)
- Play Playstation (PO, VOL100, MF, 19FN, Projector On)
- Watch Computer (PO, VOL100, MF, 20FN, Projector On)
- Watch TV (PO, VOL100, MF, 05FN, Projector On)
- Listen To Radio? (PO, VOL100, MF, 02FN, Set Station, Projector Off)
- OFF (PF, Projector Off)
*)
BUTTON_EVENT[vdv_TPs, BUTTON_TEST]
{
    PUSH:
    {
	SEND_STRING 0, "'TEST BUTTON PUSHED'"
	IP_CLIENT_OPEN(dvIP_Pioneer_Client.Port, PioneerIPAddress, PioneerPort, IP_TCP)
	wait 50
	SEND_STRING dvIP_Pioneer_Client, "'PO', $0D"
	IP_CLIENT_CLOSE(dvIP_Pioneer_Client.Port)
    }
}
BUTTON_EVENT[vdv_TPs,BTNS_GARAGE]
{
    PUSH:
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BUTTON_GARAGE_DOOR:
	    {
		PULSE[dvRelaysS2, RELAY_GARAGE_DOOR]
		TIMELINE_KILL(TL1)
		TLLoopCount = 0;
		TimeArray[1] = 1000
		TIMELINE_CREATE(TL1, TimeArray, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT)
	    }
	    CASE BUTTON_PATIO_LIGHTING:
	    {
		if (patio_lights_state == 0) {
		    ON[dvIOPortsS2, IO_PATIO_SSR]
		    ON[vdv_TPs, BUTTON_PATIO_LIGHTING]
		    patio_lights_state = 1
		} else {
		    OFF[dvIOPortsS2, IO_PATIO_SSR]
		    OFF[vdv_TPs, BUTTON_PATIO_LIGHTING]
		    patio_lights_state = 0
		}
	    }
	}
    }
}

// House Back Door Sensor
CHANNEL_EVENT[dvIOPortsS1, IO_HOUSE_BACK_DOOR_SENSOR]
{
    ON:
    {
	SEND_STRING 0, "'House Back Door is Closed!'"
	OFF[vdv_TPs, FEEDBACK_HOUSE_BACK_DOOR]
    }
    OFF:
    {
	SEND_STRING 0, "'House Back Door is Open!'"
	ON[vdv_TPs, FEEDBACK_HOUSE_BACK_DOOR]
    }
}
// Garage Door Closed Sensor
CHANNEL_EVENT[dvIOPortsS2, IO_GARAGE_DOOR_SENSOR] // Stuff that happens when Input 1 is activated
{
    ON:
    {
	SEND_STRING 0, "'Garage Door is Closed!'"
	OFF[vdv_TPs, FEEDBACK_GARAGE_DOOR]
	garage_door_closed = 1
	garage_door_prev_state = 1
    }
    OFF:
    {
	SEND_STRING 0, "'Garage Door is Open!'"
	ON[vdv_TPs, FEEDBACK_GARAGE_DOOR]
	garage_door_closed = 0
	garage_door_prev_state = 0
	SEND_STRING dvSerial_PI, "'GD OPEN0'"
    }
}
// Garage Door Light
CHANNEL_EVENT[dvIOPortsS2, IO_GARAGE_DOOR_LIGHT]
{
    ON:
    {
	SEND_STRING 0, "'Garage Door light is ON!'"
	ON[vdv_TPs, FEEDBACK_GARAGE_LIGHT]
    }
    OFF:
    {
	SEND_STRING 0, "'Garage Door light is OFF!'"
	OFF[vdv_TPS, FEEDBACK_GARAGE_LIGHT]
    }
}
// Garage Door Motor
CHANNEL_EVENT[dvIOPortsS2, IO_GARAGE_DOOR_MOTOR]
{
    ON:
    {
	SEND_STRING 0, "'Garage Door motor is RUNNING!'"
	ON[vdv_TPs, FEEDBACK_GARAGE_DOOR_MOTOR]
	SWITCH (garage_door_prev_state)
	{
	    CASE 0:
		SEND_LEVEL vdv_TPs, FEEDBACK_GARAGE_DOOR_LVL, GARAGE_DOOR_CLOSING
	    CASE 1:
		SEND_LEVEL vdv_TPs, FEEDBACK_GARAGE_DOOR_LVL, GARAGE_DOOR_OPENING
	}
    }
    OFF:
    {
	SEND_STRING 0, "'Garage Door motor is OFF!'"
	OFF[vdv_TPs, FEEDBACK_GARAGE_DOOR_MOTOR]
	SEND_LEVEL vdv_TPs, FEEDBACK_GARAGE_DOOR_LVL, GARAGE_DOOR_STATIONARY
	garage_door_prev_state = garage_door_closed
    }
}
TIMELINE_EVENT[TL1]
{
    TLLoopCount = TLLoopCount + 1
    SEND_LEVEL vdv_TPs, FEEDBACK_GARAGE_LIGHT_TIMER, TLLoopCount
    if (TLLoopCount >= 285) {
	TIMELINE_KILL(TL1)
    }
}
DATA_EVENT[dvSerial_PI]
{
    STRING:
    {
	pos = FIND_STRING(DATA.TEXT, "','", 0)
	send_string 0, "'position:', pos"
    }
}
DATA_EVENT[dvNI3000]
{
  ONLINE:
  {
    ON[vdv_TPs, FEEDBACK_NI3000]
  }
  OFFLINE:
  {
    OFF[vdv_TPs, FEEDBACK_NI3000]
  }
  ONERROR:
  {
    OFF[vdv_TPs, FEEDBACK_NI3000]
  }
}
DATA_EVENT[dvTP_Kitchen]
{
  ONLINE:
  {
    ON[vdv_TPs, FEEDBACK_TPKITCHEN]
  }
  OFFLINE:
  {
    OFF[vdv_TPs, FEEDBACK_TPKITCHEN]
  }
  ONERROR:
  {
    OFF[vdv_TPs, FEEDBACK_TPKITCHEN]
  }
}
DATA_EVENT[dvTP_Garage]
{
  ONLINE:
  {
    ON[vdv_TPs, FEEDBACK_TPGARAGE]
  }
  OFFLINE:
  {
    OFF[vdv_TPs, FEEDBACK_TPGARAGE]
  }
  ONERROR:
  {
    OFF[vdv_TPs, FEEDBACK_TPGARAGE]
  }
}