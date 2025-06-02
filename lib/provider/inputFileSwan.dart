
import 'package:flutter/material.dart';

class InputFileProvider with ChangeNotifier {

String inputfile = '';
 

void getInputFile(){
  
inputfile = '''
PROJECT	'Number'	'01'																		
!																				
!***********MODEL	INPUT**************************************************************************************************																			
!																				
SET	level=0.09	nor=90	depmin=0.01	maxmes=200	maxerr=1	grav=9.81	rho=1025.	inrhog=0	&											
	hsrerr=0.1	CARTesian	pwtail=5	froudmax=0.8	printf=4	prtest=4														
!																				
MODE	DYNAMIC	TWODimensional																		
!																				
COORDinates	CARTesian																			
!																				
CGRID	REGular	xpc=	-1195000.000 	ypc=	235000.000 	alpc=0.	xlenc=	2990000.000 	ylenc=	2990000.000 	&									
	mxc=	299	myc=	299	CIRcle	mdc=36	flow=0.04	fhigh=1.0	msc=33											
!																				
INP	BOTtom	REG	-1195000.000 	235000.000 	0	299	299	10000	10000											
INP	WInd	REG	-1195000.000 	235000.000 	0	299	299	10000	10000	NONSTAT	20151012.00000000 	600	Sec	20151021.06000000 						
!																				
READinp	BOTtom	1		'domain1.txt'	1	0	FREE													
READinp	WInd	1		'SWAN-WIND-DATA01.txt'	nhedf=0	nhedt=3	nhedvec=1	FREE												
!																				
!BOUNd	SHAPespec	JONswap	3.3	PEAK	DSPR	POWER														
!																				
!BOUNdnest1	NEST	'-	CLOSed																	
!																				
INITial	DEFAULT																			
!																				
GEN3	KOMEN	AGROW	0.0015																	
!																				
BREAKING																				
!																				
FRICTION	JONSWAP																			
!																				
LIMITER																				
!																				
PROP	BSBT																			
!																				
!************	OUTPUT	REQUESTS	*******************************************************************************************																	
!																				
GROUP	'GRID2'	SUBGRID	ix1=	0	ix2=	299	iy1=	0	iy2=	299										
NGRID	'NEST'	xpn=	51000	ypn=	1701000	alpn=0	xlenn=	238000.000 	ylenn=	378000	mxn=	119	myn=	189						
QUANTITY	FORCE	HSIGN	DIR	PER	HSWELL	excv=-999.0														
!																				
!POINTS	'P1'	-1205000.000 	225000.000 																	
!POINTS	'P2'	-1205000.000 	225000.000 																	
!POINTS	'P3'	-1205000.000 	225000.000 																	
!POINTS	'P4'	-1205000.000 	225000.000 																	
!POINTS	'P5'	-1205000.000 	225000.000 																	
!POINTS	'P6'	-1205000.000 	225000.000 																	
!POINTS	'P7'	-1205000.000 	225000.000 																	
!POINTS	'P8'	-1205000.000 	225000.000 																	
!POINTS	'P9'	-1205000.000 	225000.000 																	
!POINTS	'P10'	-1205000.000 	225000.000 																	
!POINTS	'P11'	-1205000.000 	225000.000 																	
!POINTS	'P12'	-1205000.000 	225000.000 																	
!POINTS	'P13'	-1205000.000 	225000.000 																	
!POINTS	'P14'	-1205000.000 	225000.000 																	
!POINTS																				
!POINTS																				
!																				
OUTPut	OPTIons	'%'	TABle	field=12																
OUTPut	OPTIons	'%'	BLOck	ndec=9	len=6															
OUTPut	OPTIons	'%'	SPEC	ndec=9																
!																				
!BLOCK	'GRID2'	HEADER	'rs'	LAY-OUT	IDLA=1	FORCE	OUTput	tbegblk=	20151012.00000000 	deltblk=	60	Min	! It must be same with interchange time							
!BLOCK	'GRID2'	HEADER	'max_hsign'	LAY-OUT	idla=1	HSIGN	OUTput	tbegblk=	20151012.00000000 	deltblk=	60	Min	! It is avaiable to change the time you want							
!BLOCK	'GRID2'	HEADER	'max_direction'	LAY-OUT	IDLA=1	DIR	OUTput	tbegblk=	20151012.00000000 	deltblk=	60	Min	! It is avaiable to turn it on if you want							
!BLOCK	'GRID2'	HEADER	'max_period'	LAY-OUT	IDLA=1	PER	OUTput	tbegblk=	20151012.00000000 	deltblk=	60	Min	! It is avaiable to turn it on if you want							
!BLOCK	'GRID2'	HEADER	'max_swell'	LAY-OUT	IDLA=1	HSWELL	OUTput	tbegblk=	20151012.00000000 	deltblk=	60	Min								
!BLOCK	'GRID2'	HEADER	'wind'	LAY-OUT	IDLA=1	WIND	OUTput	tbegblk=	20151012.00000000 	deltblk=	60	Min								
!BLOCK	'GRID2'	HEADER	'waterl'	LAY-OUT	IDLA=1	WATLEV	OUTput	tbegblk=	20151012.00000000 	deltblk=	60	Min								
!BLOCK	'GRID2'	HEADER	'bottom'	LAY-OUT	IDLA=1	BOTLEV	OUTput	tbegblk=	20151012.00000000 	deltblk=	60	Min								
!BLOCK	'GRID2'	HEADER	'vel'	LAY-OUT	IDLA=1	VEL	OUTput	tbegblk=	20151012.00000000 	deltblk=	60	Min								
BLOCK	'COMPGRID'	NOHEADER	'./out.mat'	LAY	3	&														
	HSIGN	TM01	TM02	DIR	BFI	WIND	&													
	OUTPUT	20151012.000000 	60	Min																
!																				
!TABLE	'P1'	HEAD	'./P1'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P2'	HEAD	'./P2'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P3'	HEAD	'./P3'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P4'	HEAD	'./P4'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P5'	HEAD	'./P5'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P6'	HEAD	'./P6'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P7'	HEAD	'./P7'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P8'	HEAD	'./P8'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P9'	HEAD	'./P9'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P10'	HEAD	'./P10'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P11'	HEAD	'./P11'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P12'	HEAD	'./P12'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	20151012.000000 	60	Min
!TABLE	'P13'	HEAD	'./P13'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	FORCE	OUTput	20151012.000000 	60	Min
!TABLE	'P14'	HEAD	'./P14'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	FORCE	OUTput	20151012.000000 	60	Min
!																				
NESTOUT	'NEST'	'for_area02.nest'	OUTPUT	tbegnst=	20151012.000000 	deltnst=	10	Min												
!																				
COMPute	NONSTAT	tbegc=	20151012.000000 	deltc=	300	Sec	tendc=	20151021.060000 												
!																				
STOP																				

''';

}

       
}

