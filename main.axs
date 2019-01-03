PROGRAM_NAME='main'
include 'http'
include 'devices'
include 'variables'
include 'events'


DEFINE_START
    IP_SERVER_OPEN(dvIP_Server.Port, 3000, IP_UDP)
    
    
    COMBINE_DEVICES (vdv_TPs, dvTP_Garage, dvTP_Kitchen)
    
    SEND_COMMAND dvSerial_PI, "'BAUD 9600,N,8,1'"

DEFINE_PROGRAM