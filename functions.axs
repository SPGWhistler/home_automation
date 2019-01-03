PROGRAM_NAME='functions'

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
(*
DEFINE_FUNCTION fnSystemPower(INTEGER intOnorOFF)
{
    IF (intOnorOFF == FALSE)
    {
	intSystemPower = 0
	strSystemState = 'OFF'
	// do other stuff to turn the system off
	TIMELINE_KILL(SAMPLE_TIMELINE_ID) //Defined later
    }
    ELSE IF (intOnorOFF == MULTI_DIMENSIONAL_ARRAY[2][3]) //(100)
    {
	chrPlanLetter = 'E' // for Error ?
	strSystemState = 'ERROR!'
    }
    ELSE
    {
	intSystemPower = TRUE // or "1"
	strSystemState = 'Ready'
	SEND_STRING 0,'System ready.'
	TIMELINE_CREATE(SAMPLE_TIMELINE_ID,SAMPLE_TIMELINE_TIMES,SAMPLE_TIMELINE_COUNT,TIMELINE_ABSOLUTE,TIMELINE_REPEAT)
    }
}

DEFINE_FUNCTION INTEGER fnSomeMathFunction(INTEGER intNumber, INTEGER intRepitions)
{
    LOCAL_VAR INTEGER intAnswer	//these variables cannot be used outside this function
    LOCAL_VAR INTEGER intLoop
    
    FOR(intLoop = 1; intLoop <= intRepitions; intLoop ++) // (Starting condition; execute code block while true; incrment (++) the var after each block exection) 
    {
	intAnswer = intNumber + intLoop + intAnswer
    }
    RETURN intAnswer
	// This function will return the sum
	// Example:
	// intSum = fnSomeMathFunction(2,4)
	// 'intSum' will be assgined the intger "18"
}

DEFINE_FUNCTION fnWordPluraization(CHAR strWord[20], CHAR strPluralWord[21])
{
    strPluralWord = "strWord , 's'"
	// This function adds the letter 's' to the initial var and outputs it to the second'
	// Example:
	// fnWordPluraization('Tony', strSystemName)
	// 'strSystemName' will contain the string 'Tonys' after the function runs
	// *important to remeber*: arguments are destructive when using varibles 
}
*)
(*
DEFINE_FUNCTION fnOpenIPServer(intTrueOrFalse)
{
    IF(intTrueOrFalse == TRUE)
    {
	slngIPServerError = IP_SERVER_OPEN(dvIP_Server.PORT,lngServerIPPort,IP_TCP)
    }
    ELSE
    {
	IP_SERVER_CLOSE(dvIP_Server.PORT)
    }
    
    SWITCH(ABS_VALUE(slngIPServerError))
    {
	CASE 0:
	{
	    SEND_STRING 0, "'IP Server Started successfully'"
	}
	CASE 1:
	CASE 2:
	CASE 3:
	{
	    SEND_STRING 0, "'IP Server failed to start'"
	    SEND_STRING 0, "'Error number: ',ITOA(slngIPServerError)"
	}
    }
}
*)
(*
DEFINE_FUNCTION fnIPSendStringToServer(CHAR strData[255])
{
    (* Open communication to the server *) 
    IP_CLIENT_OPEN(IPDevice.intLocal_Port_Number,
		    IPDevice.strIP_Address,
		    IPDevice.lngIP_Port_Number,
		    IPDevice.intIP_Protocol)
    (* Load the string data*)
    IPDevice.strDataToSend = strData
    (* The rest will be handled by DATA_EVENT[dvIP_Client] *)
}
*)
DEFINE_FUNCTION http_response_received(long seq, char host, http_request request, http_response response)
{
    send_string 0, response.code
    send_string 0, response.body
}
DEFINE_FUNCTION http_error(long seq, char host, http_request request, integer err_timeout)
{
    send_string 0, request.method
    send_string 0, request.uri
    send_string 0, request.body
}
