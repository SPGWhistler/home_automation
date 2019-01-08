PROGRAM_NAME='main'

include 'jsmn-util.axi'

DEFINE_VARIABLE

VOLATILE char json[] = '{
"status": "SUCCESS",
"settings":
	{"mac":"001102F1186E",
	"serial":"SNA1823-0552",
	"device_id":"Recorder-dec-0552",
	"FW_version":"3.12.0",
	"EXP_version":"21",
	"display_mode":"genlocked",
	"general_settings":
		{
		"vlx_model":"bx",
		"web_auth":
			{
			"enable":"n",
			"user":"admin",
			"pass":"admin"
			},
		"auto_sense":
			{
			"enable":"n",
			"priorities":
				{
				"in_port1":"2",
				"in_port2":"2",
				"stream":"2"
				}
			},
		"debug":"n",
		"front_panel_lock":"n",
		"serial_port":"",
		"bitmap_files":"",
		"bitmap_usage":"4955,13,4686,0%",
		"bitmap_busy":"false",
		"chmap_enable":"false",
		"chmap_ir_en":"0"
		},
	"hdmi":
		{
		"tx":"n",
		"hdcp":"Off",
		"local_display_source":"STREAM",
		"stream_source":"",
		"hdcp_capability":""
		},
	"ip":
		{
		"mode":"static",
		"address":"192.168.1.88",
		"mask":"255.255.255.0",
		"gateway":"192.168.1.1",
		"ip_mode":"static"
		},
	"streams":
		{
		"video":
			{
			"ip":"225.0.103.56",
			"status":"streaming",
			"wallsize_r":"0",
			"wallsize_c":"0",
			"row_idx":"0",
			"col_idx":"0",
			"overall_width":"1",
			"view_width":"1",
			"overall_height":"1",
			"view_height":"1",
			"h_scale":"0",
			"v_scale":"0",
			"h_shift":"0",
			"v_shift":"0",
			"rotate":"0",
			"frame_rate":"",
			"bit_rate":"",
			"h_size":"1920",
			"v_size":"1080",
			"fps":"60",
			"enable":"true",
			"colour_space":"",
			"bits_per_pixel":"24",
			"scan_mode":"Progressive",
			"source_stable":"true",
			"src1_audio_input":"",
			"src2_audio_input":"",
			"hdmi_audio_output":"hdmi",
			"remote_hostname":"PresentCam-enc-0356",
			"no_signal_timeout":"10",
			"turn_off_screen_on_video_lost":"false",
			"scalar_output_mode":"Pass-Through",
			"v_genlock":"y"
			},
		"rs232":
			{
			"soip_status":"off",
			"mode":"",
			"baudrate":"115200",
			"data_bit":"8",
			"stop_bit":"1",
			"parity":"n",
			"connected_device_id":"",
			"soip_connected":"false",
			"soip_ip":"0.0.0.0"
			}
		},
	"nodes":
		{
		"analog_audio_input":
			{
			"line_in_volume":"5",
			"mute":"off",
			"src1_bitrate_limit":"",
			"src2_bitrate_limit":"",
			"src1_dante_src":"",
			"src2_dante_src":"",
			"dec_dante_src":"line_in"
			},
		"analog_audio_output":
			{
			"src1_audio_enable":"",
			"src2_audio_enable":"",
			"dec_audio_enable":"false",
			"src1_dante_enable":"",
			"src2_dante_enable":"",
			"dec_dante_enable":"false",
			"src1_line_in_enable":"",
			"src2_line_in_enable":"",
			"dec_line_in_enable":"false",
			"line_out_volume":"5",
			"mute":"off"
			},
		"hdmi_monitor":
			{
			"connected ":"true"
			},
		"led":
			{
			"status":"normal"
			}
		}
	},
	"error": "NULL"
}';

define_function integer find_key(char json[], char keyName[], jsmn_token tokens[], integer start) {
    local_var jsmn_token t
    local_var integer i
    
    for (i = start; i < length_array(tokens); i++) {
	t = tokens[i]
	if (t.type == JSMN_STRING && t.size == 1) {
	    if (json_token_str_eq(json, t, keyName)) {
		return i;
	    }
	}
    }
    return 0;
}

define_function char test() {
    stack_var jsmn_token tokens[1000];
    local_var integer i;
    local_var integer j;
    local_var jsmn_token t
    local_var integer k1
    local_var integer k2
    local_var integer k3
    local_var integer k4
    
    json_tokenise(json, tokens)
    //send_string 0, json_get_token(json, tokens[20]) //'vlx_model'
    //settings.general_settings.web_auth.user = admin

    k1 = find_key(json, 'settings', tokens, 1)
    k2 = find_key(json, 'general_settings', tokens, k1)
    k3 = find_key(json, 'web_auth', tokens, k2)
    k4 = find_key(json, 'user', tokens, k3)
    send_string 0, "'found "settings.general_settings.web_auth.user" = ', json_get_token(json, tokens[k4 + 1])"
    
    /*
    for (i = 1; i < length_array(tokens); i++) {
	t = tokens[i]
	//send_string 0, "ITOA(i), ' = ', t.type, ' = ', ITOA(t.size),' = ', left_string(json_get_token(json, t), 3)"
	switch (t.type) {
	    case JSMN_OBJECT:
	    {
		send_string 0, "'object has ', ITOA(t.size), ' keys'"
	    }
	    case JSMN_ARRAY:
	    {
		send_string 0, "'array has ', ITOA(t.size), ' elements'"
	    }
	    case JSMN_STRING:
	    {
		switch (t.size) {
		    case 0:
		    {
			//value
			send_string 0, "'value is = ', json_get_token(json, t)"
		    }
		    case 1:
		    {
			//key
			send_string 0, "'key is = ', json_get_token(json, t)"
		    }
		}
	    }
	    case JSMN_PRIMITIVE:
	    {
		send_string 0, 'found primitive'
	    }
	}
    }
    */
}

DEFINE_EVENT
BUTTON_EVENT[10001:1:0,1]
{
    PUSH:
    {
	send_string 0, 'got button press'
	test()
    }
}