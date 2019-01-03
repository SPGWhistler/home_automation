

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING (* Not used very frequently *)

// Kind of an old way of doing things
// Consult the help file for a definition 

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE (* List of channels and only one can be "on" in the list *)

//([dvRelays,1],[dvRelays,2]) // if relay 1 is turned on, 2 is turned off or vice versa
//([dvRelays,3] .. [dvRelays,8]) // if any relay between 3-8 is on, the others 3-8 are turned off

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START (* This code runs when the controller first powers up *)

//intSystemPower = TRUE
//strSystemName = A_PHRASE

// ON[dvRelays,1] // Turn on the relay at power up
//OFF[dvTP_Main,12] // Turn off channel feedback on channel 12 of the main TP page

(* Define the server parameter *)
//IPDevice.strIP_Device_Name = 'Server Device'
//IPDevice.strIP_Address = '192.168.1.246'
//IPDevice.intLocal_Port_Number = dvIP_Client.PORT // Pull the port number from the Device definition
//IPDevice.lngIP_Port_Number = 3000
//IPDevice.intIP_Protocol = IP_TCP // IP_TCP is a system constant for "1"

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

//SEND_STRING 0,'System is ready.'
*)
*)
(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See “Differences in DEFINE_PROGRAM Program Execution” section *)
(* of the NX-Series Controllers WebConsole & Programming Guide   *)
(* for additional and alternate coding methodologies.            *)
(*****************************************************************)

DEFINE_PROGRAM (* There is no reason to use this section! *)

// This code runs constantly
// Any progmammer worth her salt, should be able to handle everything with events

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


