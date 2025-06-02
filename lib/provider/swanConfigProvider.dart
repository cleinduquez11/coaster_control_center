import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';

class SwanConfigFileProvider with ChangeNotifier {
  String inputfile = '';

  String start_Time = '';
  String end_time = '';
  String tout_pl = '';
  String tout_p0 = '';
  String calc_time_interval = '';
  String wind_speed_time_interval = '';
  String ncolsChild = '';
  String nrowsChild = '';
  String xllChildcorner = '';
  String yllChildcorner = '';
  String dxChild = '';
  String dyChild = '';

//Computational Area Parameters
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final toutPLTimeController = TextEditingController();
  final toutPOController = TextEditingController();
  final calcTimeInterval = TextEditingController();
  final windSpeedTimeController = TextEditingController();

  final ncolsChildController = TextEditingController(text: '1');
  final nrowsChildController = TextEditingController(text: '1');
  final xllcornerChildController = TextEditingController(text: '0');
  final yllcornerChildController = TextEditingController(text: '0');
  final dxChildController = TextEditingController(text: '0');
  final dyChildController = TextEditingController(text: '0');

  String level = '';
  String nor = '';
  String depmin = '';
  String maxmes = '';
  String maxerr = '';
  String grav = '';
  String rho = '';
  String inrhog = '';
  String hserr = '';
  String pwtail = '';
  String froudmax = '';
  String printf = '';
  String prtest = '';

//General Parameters
  final levelController = TextEditingController(text: '0.09');
  final norController = TextEditingController(text: '90');
  final depminController = TextEditingController(text: '0.01');
  final maxmesController = TextEditingController(text: '300');
  final maxerrController = TextEditingController(text: '1');
  final gravController = TextEditingController(text: '9.81');
  final rhoController = TextEditingController(text: '1025.');
  final inrhogController = TextEditingController(text: '0');
  final hsrerrController = TextEditingController(text: '0.1');
  final pwtailController = TextEditingController(text: '5');
  final froudmaxController = TextEditingController(text: '0.8');
  final printfController = TextEditingController(text: '4');
  final prtestController = TextEditingController(text: '4');

//Time Series Parameters
  List<TextEditingController> xControllers =
      List.generate(14, (index) => TextEditingController());

  List<TextEditingController> yControllers =
      List.generate(14, (index) => TextEditingController());

  List<String> xS = List.generate(14, (index) => '');

  List<String> yS = List.generate(14, (index) => '');

  List<String> xSInit = List.generate(14, (index) => '');

  List<String> xSTable = List.generate(14, (index) => '');

  String bounds = '';

  void reset() {
    inputfile = '';

    end_time = '';
    end_time = '';
    start_Time = '';
    tout_pl = '';
    tout_p0 = '';
    calc_time_interval = '';
    wind_speed_time_interval = '';
    ncolsChild = '';
    nrowsChild = '';
    xllChildcorner = '';
    yllChildcorner = '';
    dxChild = '';
    dyChild = '';

    // startTimeController.clear();
    // endTimeController.clear();
    // toutPLTimeController.clear();
    // toutPOController.clear();
    // calcTimeInterval.clear();
    // windSpeedTimeController.clear();

    // ncolsChildController.clear();
    // nrowsChildController.clear();
    // xllcornerChildController.clear();
    // yllcornerChildController.clear();
    // dxChildController.clear();
    // dyChildController.clear();

    for (var i = 0; i < 14; i++) {
      xS[i] = '';
      yS[i] = '';
      // xControllers[i].clear();
      // yControllers[i].clear();
    }

    notifyListeners();
  }

  void getVals(ncols, nrows, xllcorner, yllcorner, cellsize, nf) async {
    String curDir = Directory.current.path;

    start_Time = startTimeController.text.toString();
    end_time = endTimeController.text.toString();
    tout_pl = toutPLTimeController.text.toString();
    tout_p0 = toutPOController.text.toString();
    calc_time_interval = calcTimeInterval.text.toString();
    wind_speed_time_interval = windSpeedTimeController.text.toString();

    level = levelController.text.toString();
    nor = norController.text.toString();
    depmin = depminController.text.toString();
    maxmes = maxmesController.text.toString();
    maxerr = maxerrController.text.toString();
    grav = gravController.text.toString();
    rho = rhoController.text.toString();
    inrhog = inrhogController.text.toString();
    hserr = hsrerrController.text.toString();
    pwtail = pwtailController.text.toString();
    froudmax = froudmaxController.text.toString();
    printf = printfController.text.toString();
    prtest = prtestController.text.toString();

    ncolsChild = ncolsChildController.text.toString();
    nrowsChild = nrowsChildController.text.toString();
    xllChildcorner = xllcornerChildController.text.toString();
    yllChildcorner = yllcornerChildController.text.toString();
    dxChild = dxChildController.text.toString();
    dyChild = dyChildController.text.toString();

    double xpc = (double.parse(xllcorner) + double.parse(cellsize) / 2);
    double ypc = (double.parse(yllcorner) + double.parse(cellsize) / 2);
    double mxc = (double.parse(ncols) - 1);
    double myc = double.parse(nrows) - 1;

    print('''
    $ncols
    $nrows
    $xllcorner
    $yllcorner
    $cellsize
''');

    double xlenc = mxc * double.parse(cellsize);
    double ylenc = myc * double.parse(cellsize);

    double xpn = (double.parse(xllChildcorner) + double.parse(dxChild) / 2);
    double ypn = (double.parse(yllChildcorner) + double.parse(dyChild) / 2);

    double mxn = double.parse(ncolsChild) - 1;
    double myn = double.parse(nrowsChild) - 1;

    double xlenn = mxn * double.parse(dxChild);
    double ylenn = myn * double.parse(dyChild);

    int valueDecimalPlace = 3;

    for (var i = 0; i < 14; i++) {
      var tmp = double.tryParse(xControllers[i].text) ?? 0;
      double temp = tmp - 1 * double.parse(cellsize) + xpc;
      xS[i] = temp.toStringAsFixed(valueDecimalPlace);
    }

    for (var i = 0; i < 14; i++) {
      var temp = double.tryParse(yControllers[i].text) ?? 0;
      temp = (temp - 1) * double.parse(cellsize) + ypc;
      yS[i] = temp.toStringAsFixed(valueDecimalPlace);
    }

    for (var i = 0; i < 14; i++) {
      if (xControllers[i].text.isEmpty && yControllers[i].text.isEmpty) {
        xSInit[i] = '!POINTS	\'P${i + 1}\'';
      } else {
        xSInit[i] = 'POINTS	\'P${i + 1}\'';
      }
    }

    for (var i = 0; i < 14; i++) {
      if (xControllers[i].text.isEmpty && yControllers[i].text.isEmpty) {
        xSTable[i] = '!TABLE';
      } else {
        xSTable[i] = 'TABLE';
      }
    }

    //  int dateDecimalPlace = 8;

    if (nf == '-') {
      bounds = '!BOUNdnest1	NEST	\'$nf	CLOSed';
    } else {
      bounds = 'BOUNdnest1	NEST	\'$nf\'	CLOSed';
    }

    inputfile = '''
PROJECT	'Number'	'01'																		
!																				
!***********MODEL	INPUT**************************************************************************************************																			
!																				
SET	level=$level	nor=$nor	depmin=$depmin	maxmes=$maxmes	maxerr=$maxerr	grav=$grav	rho=$rho	inrhog=$inrhog	&											
	hsrerr=$hserr	CARTesian	pwtail=$pwtail	froudmax=$froudmax	printf=$printf	prtest=$prtest														
!																				
MODE	DYNAMIC	TWODimensional																		
!																				
COORDinates	CARTesian																			
!																				
CGRID	REGular	xpc=	${xpc.toStringAsFixed(valueDecimalPlace)} 	ypc=	${ypc.toStringAsFixed(valueDecimalPlace)} 	alpc=0.	xlenc=	${xlenc.toStringAsFixed(valueDecimalPlace)} 	ylenc=	${ylenc.toStringAsFixed(valueDecimalPlace)} 	&									
	mxc=	${mxc.toStringAsFixed(0)}	myc=	${myc.toStringAsFixed(0)}	CIRcle	mdc=36	flow=0.04	fhigh=1.0	msc=33											
!																				
INP	BOTtom	REG	${xpc.toStringAsFixed(valueDecimalPlace)} 	${ypc.toStringAsFixed(valueDecimalPlace)} 	0	${mxc.toStringAsFixed(0)}	${myc.toStringAsFixed(0)}	$cellsize	$cellsize											
INP	WInd	REG	${xpc.toStringAsFixed(valueDecimalPlace)} 	${ypc.toStringAsFixed(valueDecimalPlace)} 	0	${mxc.toStringAsFixed(0)}	${myc.toStringAsFixed(0)}	$cellsize	$cellsize	NONSTAT	$start_Time 	$wind_speed_time_interval	Sec	$end_time 						
!																				
READinp	BOTtom	1		'domain1.txt'	1	0	FREE													
READinp	WInd	1		'SWAN-WIND-DATA01.txt'	nhedf=0	nhedt=3	nhedvec=1	FREE												
!																				
!BOUNd	SHAPespec	JONswap	3.3	PEAK	DSPR	POWER														
!																				
$bounds																
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
GROUP	'GRID2'	SUBGRID	ix1=	0	ix2=	${mxc.toStringAsFixed(0)}	iy1=	0	iy2=	${myc.toStringAsFixed(0)}										
NGRID	'NEST'	xpn=	${xpn.toStringAsFixed(valueDecimalPlace)}	ypn=	${ypn.toStringAsFixed(valueDecimalPlace)}	alpn=0	xlenn=	${ylenn.toStringAsFixed(valueDecimalPlace)} 	ylenn=	${xlenn.toStringAsFixed(valueDecimalPlace)}	mxn=	${myn.toStringAsFixed(0)}	myn=	${mxn.toStringAsFixed(0)}						
QUANTITY	FORCE	HSIGN	DIR	PER	HSWELL	excv=-999.0														
!																				
${xSInit[0]}	${xS[0]} 	${yS[0]} 																	
${xSInit[1]}	${xS[1]} 	${yS[1]} 																	
${xSInit[2]}	${xS[2]} 	${yS[2]} 																	
${xSInit[3]}	${xS[3]} 	${yS[3]} 																	
${xSInit[4]}	${xS[4]} 	${yS[4]} 																	
${xSInit[5]}	${xS[5]} 	${yS[5]} 																	
${xSInit[6]}	${xS[6]} 	${yS[6]} 																	
${xSInit[7]}	${xS[7]} 	${yS[7]} 																	
${xSInit[8]}	${xS[8]} 	${yS[8]} 																	
${xSInit[9]}	${xS[9]} 	${yS[9]} 																	
${xSInit[10]}	${xS[10]} 	${yS[10]} 																	
${xSInit[11]}	${xS[11]} 	${yS[11]} 																	
${xSInit[12]}	${xS[12]} 	${yS[12]} 																	
${xSInit[13]}	${xS[13]} 	${yS[13]} 																																				
!																				
OUTPut	OPTIons	'%'	TABle	field=12																
OUTPut	OPTIons	'%'	BLOck	ndec=9	len=6															
OUTPut	OPTIons	'%'	SPEC	ndec=9																
!																				
!BLOCK	'GRID2'	HEADER	'rs'	LAY-OUT	IDLA=1	FORCE	OUTput	tbegblk=	$start_Time 	deltblk=	$tout_pl	Min	! It must be same with interchange time							
!BLOCK	'GRID2'	HEADER	'max_hsign'	LAY-OUT	idla=1	HSIGN	OUTput	tbegblk=	$start_Time 	deltblk=	$tout_pl	Min	! It is avaiable to change the time you want							
!BLOCK	'GRID2'	HEADER	'max_direction'	LAY-OUT	IDLA=1	DIR	OUTput	tbegblk=	$start_Time 	deltblk=	$tout_pl	Min	! It is avaiable to turn it on if you want							
!BLOCK	'GRID2'	HEADER	'max_period'	LAY-OUT	IDLA=1	PER	OUTput	tbegblk=	$start_Time 	deltblk=	$tout_pl	Min	! It is avaiable to turn it on if you want							
!BLOCK	'GRID2'	HEADER	'max_swell'	LAY-OUT	IDLA=1	HSWELL	OUTput	tbegblk=	$start_Time 	deltblk=	$tout_pl	Min								
!BLOCK	'GRID2'	HEADER	'wind'	LAY-OUT	IDLA=1	WIND	OUTput	tbegblk=	$start_Time 	deltblk=	$tout_pl	Min								
!BLOCK	'GRID2'	HEADER	'waterl'	LAY-OUT	IDLA=1	WATLEV	OUTput	tbegblk=	$start_Time 	deltblk=	$tout_pl	Min								
!BLOCK	'GRID2'	HEADER	'bottom'	LAY-OUT	IDLA=1	BOTLEV	OUTput	tbegblk=	$start_Time 	deltblk=	$tout_pl	Min								
!BLOCK	'GRID2'	HEADER	'vel'	LAY-OUT	IDLA=1	VEL	OUTput	tbegblk=	$start_Time 	deltblk=	$tout_pl	Min								
BLOCK	'COMPGRID'	NOHEADER	'./out.mat'	LAY	3	&														
	HSIGN	TM01	TM02	DIR	BFI	WIND	&													
	OUTPUT	$start_Time 	$tout_pl	Min																
!																				
${xSTable[0]}	'P1'	HEAD	'./P1'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[1]}	'P2'	HEAD	'./P2'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[2]}	'P3'	HEAD	'./P3'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[3]}	'P4'	HEAD	'./P4'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[4]}	'P5'	HEAD	'./P5'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[5]}	'P6'	HEAD	'./P6'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[6]}	'P7'	HEAD	'./P7'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[7]}	'P8'	HEAD	'./P8'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[8]}	'P9'	HEAD	'./P9'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[9]}	'P10'	HEAD	'./P10'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[10]}	'P11'	HEAD	'./P11'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[11]}	'P12'	HEAD	'./P12'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	WATLEV	OUTput	$start_Time 	$tout_pl	Min
${xSTable[12]}	'P13'	HEAD	'./P13'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	FORCE	OUTput	$start_Time 	$tout_pl	Min
${xSTable[13]}	'P14'	HEAD	'./P14'	TIME	HSWE	WLEN	HS	DIR	PDIR	PER	RPER	DEP	VEL	SETUP	WIND	FORCE	OUTput	$start_Time 	$tout_pl	Min
!																				
NESTOUT	'NEST'	'for_area02.nest'	OUTPUT	tbegnst=	$start_Time 	deltnst=	10	Min												
!																				
COMPute	NONSTAT	tbegc=	$start_Time 	deltc=	$calc_time_interval	Sec	tendc=	$end_time 												
!																				
STOP																				

''';

    await File('$curDir${sndPath}input\\wind_estimation\\swan\\INPUT')
        .writeAsString(inputfile);
    print('Created Input File for SWAN');
  }
}
