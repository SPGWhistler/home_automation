PROGRAM_NAME='variables'
(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT (* System Constants *)
(* These are basically fixed "variables" *)

//VOLATILE INTEGER NUMBER_OF_LIGHTS 		= 4 // INTEGER -> 16 bit var, Range: 0 - 65535 (unsigned)
//VOLATILE INTEGER LEXI_S_HOTNESS_FACTOR		= 10 // ;)
//VOLATILE SINTEGER LOWEST_VOLUME			= -24 // SINTEGER -> 16 bit var,  Range: ±32768 (singed) 
//VOLATILE LONG A_VERY_BIG_NUMBER			= 1234567 // LONG -> 32 bit var, Range 0 - 4,294,967,295 (unsigned)
//VOLATILE SLONG A_VERY_NEGATIVE_NUMBER		= -53486 // SLONG -> 32 bit var, Range: ±2,147,483,647 (signed)
//VOLATILE FLOAT A_VERY_SMALL_NUMBER		= 0.001	// FLOAT -> 64 bit var, Range: ±1.17549E-38 to ±3.40282E+38 (signed)
//VOLATILE DOUBLE A_DOUBLE_PRECISION_NUMBER 	= 1.234567890123 // DOUBLE -> 64 bit var, Range: ±2.22507E-308 to ±1.79769E+308 (signed)

//VOLATILE INTEGER AN_INTEGER_ARRAY[5]		= {1,2,7,9,56} // All arrays data can be addressed by the VaribleHandle[x]
							     // AN_INTEGER_ARRAY[3] = 7
//VOLATILE INTEGER MULTI_DIMENSIONAL_ARRAY[3][3] 	=
//    {
//	{ 1,2,3 },
//	{ 27,99,100 },
//	{ 999,1,35}
//    } // MULTI_DIMENSIONAL_ARRAY[2][3] = 100


//VOLATILE CHAR A_SINGLE_LETTER			= 'A' // can be any ASCII character
//VOLATILE CHAR AN_ACTUAL_WORD[8]			= 'Hello' // An array of characters defined to be no longer than 8 characters
//VOLATILE CHAR A_PHRASE[55]			= 'Hey Sweetie!' // Defined to be less than 56 characters
(*
VOLATILE CHAR A_BUNCH_OF_WORDS[5][10]		=
    { // Multi-dimensional character array
	'Hello',
	'GOOD-BYE',
	'WTF?!',
	'YUMMM!',
	'asdf'
    } // The word YUMMM! can be reaclled using "A_BUNCH_OF_WORDS[4]"
    *)
//VOLATILE INTEGER BUTTON_POWER			= 9
VOLATILE INTEGER BUTTON_GARAGE_DOOR		= 10
VOLATILE INTEGER BUTTON_PLAY		= 11
VOLATILE INTEGER BUTTON_NEXT		= 12
VOLATILE INTEGER BUTTON_PREV		= 13
VOLATILE INTEGER HTTP_RESPONSE_CALLBACK = 1
VOLATILE INTEGER HTTP_ERROR_CALLBACK = 1
//VOLATILE INTEGER VIRTUAL_CHANNEL_1		= 1
//VOLATILE INTEGER VIRTUAL_CHANNELS[4]		= {1,2,3,4}
//VOLATILE INTEGER TP_LEVEL_3			= 3

//VOLATILE LONG SAMPLE_TIMELINE_ID		= 9274 // unique timeline ID
//VOLATILE LONG SAMPLE_TIMELINE_TIMES[3]		= {1000,5000,10000} //time intervals in milliseconds
//VOLATILE LONG SAMPLE_TIMELINE_COUNT		= 3 // how many ticks in the timeline



(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE (* Used to define data structures *)
(*
STRUCTURE STRC_IP_INFO
    {
	CHAR strIP_Device_Name[32]
	CHAR strIP_Address[32]	// can be IP Address (192.168.1.1) or DNS name if DNS is configured on the box
	INTEGER intLocal_Port_Number //DPS -> 0:X:0
	LONG lngIP_Port_Number // The TCP/UDP port number to communicate on
	INTEGER intIP_Protocol // 1 = TCP, 2 = UDP, 3 = UDP with Recieve
	LONG lngIP_Error
	CHAR strDataToSend[255]
    }
*)
// Ask me later if you want to know more about this

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE (* Define global varibles here *)

//VOLATILE INTEGER intX_Coordinate
//VOLATILE INTEGER intY_Coordinate
//VOLATILE INTEGER intZ_Coordinate		= 42 // can be defined now or later
//VOLATILE INTEGER intSystemPower

//VOLATILE LONG lngLongNumber

//VOLATILE CHAR chrPlanLetter			= 'B'
//VOLATILE CHAR strSystemState[12]			// String Varible that will accept 12 ascii characters 
//VOLATILE CHAR strSystemName[32]				// String Varible that will accept 32 ascii characters 
//VOLATILE CHAR strListofSystems[10][32]			// mulit-dimensional string (a list of 10 names no longer than 32 characters each)

//VOLATILE STRC_IP_INFO IPDevice				// structured var to hold the IP device info

//VOLATILE LONG lngServerIPPort			= 23	// the IP port to listen on
//VOLATILE CHAR strIPServerData[255]
//VOLATILE SLONG	slngIPServerError
