import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';

class DisasterType {
  final int? id;
  final String name;
  final String? description; // Optional

  const DisasterType({required this.name, this.description, this.id});
}

const List<DisasterType> disasterTypes = [
  DisasterType(
      id: 1,
      name: 'Tsunami',
      description:
          'Large ocean waves caused by earthquakes or underwater landslides.'),
  DisasterType(
      id: 2,
      name: 'Storm Surge',
      description: 'The abnormal rise in sea level accompanying a storm.'),
  DisasterType(
      id: 3,
      name: 'Typhoon',
      description: 'A large, intense tropical cyclone.'),
];

class DisasterTypeProvider extends ChangeNotifier {
  final ctiController = TextEditingController();
  DisasterType? selectedDisasterType;
  String dId = '';
  String cti = '';
  String paramFile = '';

  void selectDisasterType(DisasterType type) {
    selectedDisasterType = type;
    // dId = type.id.toString();
    // print(type.id);
    notifyListeners();
  }

  void reset() {
    cti = '';
    notifyListeners();
  }

  void windSubmit() async {
    String curDir = Directory.current.path;
    dId = selectedDisasterType!.id.toString();
    cti = ctiController.text.toString();
    notifyListeners();

    paramFile = '''
  &input_param1
!-----------------------------------------
!  
!-----------------------------------------
nthread = 9     !!Number of openMP threads
MDEL	= $dId	!!1:Tsunami calculation 2:Storm surge calculation 3:Typhoon model (output for SWAN)
!!
LVEL	= 1	!!Number of layers
MMDEL	= 93,93,93,93,93
!!MMDELFmodel used
!!
!!
!!
!!
!!
!!
MBOUN	= 1	!!
/

&input_param2
!-----------------------------------------
!  Setting of calculation conditions Part 1 (common)
!  Setting the latitude and longitude of the calculation reference point
!@Cartesian coordinate system 7 (JGD2000)
!-----------------------------------------
XLN1	= 118.0	!!degrees
XLN2	= 30.0	!!minutes
XLN3	= 40.522	!!seconds
!-----------------------------------------
YLT1	= 0.0	!!degree
YLT2	= 0.0	!!minute
YLT3	= 0.0	!!secondsss
!-----------------------------------------
NDO	= 0	!!Not used but left at 0
NCO	= 1	!!Not used, but left at 1
NGO	= 1 !0	!!Flooding calculation: 1 (normally left at 1)
!-----------------------------------------
NINI	= 0	!!Not used but left at 0
NINO	= 0	!!Not used, but left at 0
NINC	= 0	!!Not used but left at 0
!-----------------------------------------
!
!-----------------------------------------
!  Setting of calculation conditions Part 2 (common)
!@Calculation time, output time, etc.
!-----------------------------------------
DLT	= $cti		!!Computation time interval (s)
RKTDUR	= 10800.0		!!Output interval for plane distribution (s)
RMXDUR	= 10800.0	!!Output interval (s) for intermediate maxima
RLPDUR	= 3600.0		!!Interval between outputs in the middle of the value (in seconds) (not needed for the base)
RNPDUR	= 3600.0		!!Output interval of the representative point time series (seconds)
MOUTF	= 2		!!Output format of planar distribution, 1: normal output format, 2: matrix format for each time and region, 3: both output
RSTOUT	= -120.0 	!!Start time (in seconds) to refine the output interval of the planar distribution * Negative values are ignored.
REDOUT	= -240.0	!!End time (seconds) to refine the output interval of the planar distribution
RKOUT	= 3600.0		!!Output time interval within a specific time (seconds)
!-----------------------------------------
!
!-----------------------------------------
!  Setting up calculation conditions Part 3 (common)
!@Tide level, numerical viscosity, etc. setting
!-----------------------------------------
AV(1)	= 0.01,0.01,0.01,0.01,0.01,0.01	!!Default value 0.01, if you get strange water level, try to raise it a little
AH(1)	= 100.0,100.0,30.0,10.0,0.01,0.01	!!Recommend about 1/10 of the lattice spacing
CH	= 0.63	!!Tide level (m)
MSF1	= 1	!!How to set the initial water level (1: assume water surface below tide level, 2: use land area file to exclude initial water level on land)
FACT	= 0.00	!!Coefficient of numerical viscosity (continuous equation)
!-----------------------------------------
!  Setting of calculation conditions Part 4 (common)
!@Parameters such as gravity acceleration
!-----------------------------------------
GG	= 9.8	!!Gravitational acceleration (m/s2)
PP	= 3.1415926	!!Pi (pi)
RO	= 1.22	!!Air density (kg/m3) default 1.22
RW	= 1026.0	!!Seawater density (kg/m3)default 1026.
!!-----------------------------------------------------------
!
!-----------------------------------------
!  Setting up calculation conditions Part 6 (common)
!@Setting of water depth limits, etc.
!-----------------------------------------
RLIMNL	= 10.0	!!Minimum water depth for linear calculations (m)
RX1	= -49.9	!!Upper boundary of the run-up (m)
GV1	= 1.e-2	!!Limiting depth when calculating velocity (m) *Originally 1.0e-5
GX1	= 1.e-5	!!Total water depth for land area determination (m) *originally 1.0e-5
GX2 	= 1.e-5	!!Water depth limit used to determine land area in the continuous equation (m) *Originally 1.0e-5
!! Valid for MMDEL>=94 or higher
GX3 	= 1.e-5	!!Total water depth (m) to determine land area in the equation of motion *originally 1.0e-5
GY1 	= 1.e-7	!!Lower limit of flow rate *originally 1.0e-15
VX1	= 49.	!!Maximum flow velocity limit (m/s) (advection phase) *originally 49.
VX2	= 7.	!!Maximum velocity limit (m/s) (advection phase) *Originally 7
!!
!!-----------------------------------------------------------
!
!-----------------------------------------
!  Setting up calculation conditions Part 7 (Tsunami)
!  Calculation period, crustal deformation, etc.
!-----------------------------------------
KMAX		= 6000	!!Number of calculation steps (only for ML=1 tsunami calculation)
IDEF		= 2	!!Flag for setting initial crustal deformation amount (0: set by Patameter, calculated by Mansinha&Smylie formula, 1: read in deformation amount from external file, 2: read in deformation amount from external file (considering linkage))
IZ_DEF_S	= 0	!!0: Crustal deformation is taken into account in the bathymetry, 1: Crustal deformation is not taken into account in the bathymetry
IZ_DEF_L	= 0	!!0: Crustal deformation is taken into account only for subsidence in land elevation, 1: Crustal deformation is taken into account for both subsidence and uplift in land elevation, 2: Crustal deformation is not taken into account for land elevation
CRC		= 1.0	!!Variation factor for water level variation only: correction coefficient usually 1.00d0
MRC		= 1.0	!!Magnification ratio coefficient for land deformations that are taken into account in land subsidence and uplift: magnification ratio coefficient usually 1.00d0
!-----------------------------------------
!
!-----------------------------------------
!  Setting up calculation conditions Part 8 (storm surge calculation)
!@Setting up typhoon model conditions
!-----------------------------------------
THYRD_M	= 2		!!1: Typhoon input data in hourly units (must start at exactly 1:00, etc.) *dt must be less than or equal to 1 hour
!                       !!2: Typhoon input data in 1-minute increments (5909250925 to 5909260928, etc. are possible) *dt must be less than or equal to 1 minute.
modelty	= 1		!!1:Myers model 2:Fujita's model
mtdur	= 1		!!Calculation step interval for maximum wind speed minimum pressure
CR	= 1.4544E-4	!!Coriolis coefficient (=2ƒÖ sinƒÆ, ƒÆ: latitude (degrees), here ƒÆ90 degrees is included, ƒÖ: rotation speed of the earth (2ƒ®/24hour) default 1.4544E-4
FYLT	= 35.0		!!Latitude when calculating the Coriolis coefficient in the equation of motion
ER	= 6.37E+6	!!Radius of the earth (km) default 6.37e6
C1	= 0.66		!!Wind speed reduction factor for tilt wind default 0.66
C2	= 0.66		!!Field wind speed reduction rate Default 0.66
TE	= 30.0		!!Inclined wind blowing angle (degrees)
KEYP	= 2	!!Whether the barometric pressure term is taken into account over land (1: yes, 2: no)
KEYW	= 2	!!Whether the term of blow-in is taken into account over land (1: yes, 2: no)
!-----------------------------------------
/


&input_param3
!-----------------------------------------
!  Layer thickness setting
!-----------------------------------------
HLVT(1)	= 1.0E10		!!Put larger value for 1 layer calculation (e.g. 1.0E+10)
!! For 3 layers, for example, enter "HLVT(1)=5.0,20.0,1.0E10", where the upper layer is the first layer
/


&input_destroy
!-----------------------------------------
!  Configuration of breakwater condition settings
!-----------------------------------------
DESTROY	= 0	!!Levee break flag
!DESTROY=0:no breakwater
!DESTROY=1:Overflow breakage exists (all facilities)
!DESTROY=2:Breach condition is set for each facility No. (planned tide level only)}*Modified on Jan 23, 2016
!DESTROY=3:Breach conditions are set for each facility No. (planned tide level and launch height)}*Corrected on 01/23/2016
DOVF	= 0.01	!!Depth of overflow water at the start of breakwater [m]
DBSPD	= 999.0	!!Velocity of breakwater [m/s]
MHMN	= 0	!!Whether the HMN routine modifies the levee grid below ground level to normal grid (0:no, 1:yes)
!!Below, set when DESTROY = 2 or higher=============¦MMHMN should be 0
DSTDUR1	= 5		!!Output step interval of time series data for each facility
DSTDUR2	= 3600		!!Step interval for check matrix update of variables for breakthrough
FDST(1)	= 0,0,0,1	!!Setting of whether or not there is a breakout for each area (0: no breakout, 1: breakout, if yes, facility No. matrix data and facility information text data are required below)
DST_F1(1)	=  		!!Facility No. matrix data for each area
'NoData',
'NoData',
'../dat/irID_0270-01.txt',
'../dat/irID_0090-01.txt',
DST_F2(1)	=  		!!Text data of facility information for each area
'NoData',
'NoData',
'../dat/shisetsu3.txt',
'../dat/shisetsu4.txt',
/

&TYPHOONWIND_OUT
!-----------------------------------------
!  Setup typhoon wind file output for SWAN
!-----------------------------------------
TYW_OUT		= 1		! Output wind speed file for SWAN {1:Yes,0:No}
TYW_TOUT	= 600.0		! Output time interval of wind speed file for SWAN [s]
TYW_OFORM	='(10000F10.2)'	! Format of wind speed file for SWAN ! Name of wind speed file for SWAN (separated by "," for the number of areas) (input terminals 101 to 110)
TYW_FOUT(1)	=  	
'../out/SWAN-WIND-DATA01.txt',
'../out/SWAN-WIND-DATA02.txt',
'../out/SWAN-WIND-DATA03.txt',
'../out/SWAN-WIND-DATA04.txt',
'../out/SWAN-WIND-DATA05.txt',
'../out/SWAN-WIND-DATA06.txt',
/

&input_nestout
!-----------------------------------------
!  Setup water level and velocity file output for SWAN
!  ¦Effective when *DESTROY=3
!-----------------------------------------
NEST_OUT	= 0		! Output water level and velocity file for SWAN {1:Yes, 0:No}
NEST_TOUT	= 300.0		! Output time interval of water level and velocity file for SWAN [s]
NEST_OFORM1	='(10000F10.2)'	! Format of water level file for SWAN
NEST_OFORM2	='(10000F10.2)'	! Format of the water velocity file for SWAN
! Name of water level file for SWAN (separated by "," for the number of areas) (input terminals 131 to 140)
NEST_FOUT1(1)	=  		
'../out/SWAN-WLEVEL-DATA01.txt',
'../out/SWAN-WLEVEL-DATA02.txt',
'../out/SWAN-WLEVEL-DATA03.txt',
'../out/SWAN-WLEVEL-DATA04.txt',
'NoData',
'NoData'
! Name of the flow velocity file for SWAN (separated by "," for the number of areas) (input terminals 141 to 150)
NEST_FOUT2(1)	=  		
'../out/SWAN-CURRENT-DATA01.txt',
'../out/SWAN-CURRENT-DATA02.txt',
'../out/SWAN-CURRENT-DATA03.txt',
'../out/SWAN-CURRENT-DATA04.txt',
'NoData',
'NoData'
/

&INPUT_WAVE
!-----------------------------------------
!  Setup of inputs for SWAN (setup considerations)
!-----------------------------------------
WAVE_IN		= 0		! Input of Radiation Stress Input file for SWAN {1:Yes, 0:No}
WAVE_TIN	= 600.0		! Input time interval of the Radiation Stress Input File for SWAN [s]
WAVE_NA		= -999.0		! Nan for SWAN (a value that is non-numeric and not reflected in the calculation)
WAVE_IFORM	='(10000F10.2)'	! Radiation stress input format for SWAN (not used)
! Name of the radiation stress input file for SWAN (separated by "," for the number of areas)
WAVE_FIN(1)	=  	
'../02_swan/run/2430m/wave/rs',
'../02_swan/run/810m/wave/rs',
'../02_swan/run/270m/wave/rs',
'../02_swan/run/90m/wave/rs',
'../02_swan/run/30m/wave/rs',
'../02_swan/run/10m/wave/rs'
/
&INPUT_WAVE2
!-----------------------------------------
!  Setup of input for SWAN (consideration of wave height and period for calculation of whether launched)
!-----------------------------------------
WAVE2_IN	= 0		! Read wave height and period input file for SWAN {1:Yes, 0:No}
WAVE2_TIN	= 300.0		! Input time interval of the wave height period input file for SWAN [s]
WAVE2_NA	= -999.0		! Nan for SWAN (a value that is non-numeric and not reflected in the calculation)
WAVEHS_IFORM	='(10000F10.2)'	! Wave height input format for SWAN (not used)
WAVETS_IFORM	='(10000F10.2)'	! Wave height input format for SWAN (not used)
! Name of the wave height input file for SWAN (separated by "," for the number of areas)
WAVEHS_FIN(1)	=  	
'../../02_swan/run_a01_2430m/wave/max_hsign',
'../../02_swan/run_a02_0810m/wave/max_hsign',
'../../02_swan/run_a03_0270m/wave/max_hsign',
'../../02_swan/run_a04_0090m/wave/max_hsign',
'NoData',
'NoData'
! Name of the periodic input file for SWAN (separated by "," for the number of areas)
WAVETS_FIN(1)	=  	
'../../02_swan/run_a01_2430m/wave/max_period',
'../../02_swan/run_a02_0810m/wave/max_period',
'../../02_swan/run_a03_0270m/wave/max_period',
'../../02_swan/run_a04_0090m/wave/max_period',
'NoData',
'NoData'
/

&input_river1
!-----------------------------------------
!  Setting up river flow considerations
!-----------------------------------------
riv_kt		= -12000 !!86400	!!Number of steps to calculate run aids (- values do not calculate run aids)
river1		= 0	!!Switch to account for river flow (0: don't do, 1: do)
river2		= 0	!!Switch to input the initial water level data created by the run-up calculation (0: do not do, 1: do)
riv_srg 	= 0     !!Whether to consider typhoon external force in the run-up calculation when considering river flow in the storm surge calculation (0:No1:Yes)* Typhoon external force in the run-up calculation is followed by t=0
riv_dom 	= 4     !!Domain number where river flow is taken into account
riv_nsec	= 1	!!Number of river cross-sections to consider (up to 50 cross-sections)
riv_np(1)	= 7	!!Number of points constituting each river cross section (up to 100 points per cross section)
riv_ffluxin(1)	= 	!!Name of time series data file of river level or flow rate for each cross-section (fill in the number of riv_nsec)
'../dat/kisogawa.txt',
'../dat/nagaragawa.txt'
!!The following is set when riv2 = 1
riv_fzz(1)	= 	!!Initial water level file name created by preliminary run calculation
'../dat/InitialMap_ZZ01_0007200.txt',
'../dat/InitialMap_ZZ02_0007200.txt',
'../dat/InitialMap_ZZ03_0007200.txt',
'../dat/river/river04.txt'
riv_fqx(1)	= 	!!Name of initial flow file created by pre-calculating aids
'../dat/InitialMap_UU01_L01_0007200.txt',
'../dat/InitialMap_UU02_L01_0007200.txt',
'../dat/InitialMap_UU03_L01_0007200.txt',
'../dat/river/riverx04.txt'
riv_fqy(1)	= 	!!Name of initial flow file created by pre-calculating aids
'../dat/InitialMap_VV01_L01_0007200.txt',
'../dat/InitialMap_VV02_L01_0007200.txt',
'../dat/InitialMap_VV03_L01_0007200.txt',
'../dat/river/rivery04.txt'
riv_fqz(1)	= 	!!Name of initial flow file created by pre-calculating aids
'../dat/InitialMap_WW01_L01_0007200.txt',
'../dat/InitialMap_WW02_L01_0007200.txt',
'../dat/InitialMap_WW03_L01_0007200.txt',
'../dat/river/riverz04.txt'
/

&restart_set
!-----------------------------------------
!  Restart settings
!-----------------------------------------
restart		= 0	!!restart calculation
res_name(1)	= 	!!Restart file to use (comma-separated by number of areas)
'../dat/RESTART01_01LAY_00012000.rso',
'../dat/RESTART02_01LAY_00012000.rso',
'../dat/RESTART03_01LAY_00012000.rso',
'../dat/RESTART04_01LAY_00012000.rso'
!res_waveSkip	= 6000	!!Time (specified in seconds) to skip reading when reading radiation stress at restart *Time should be divisible by WAVE_TIN
!res_wave2Skip	= 6000	!!Time (specified in seconds) to skip reading the wave height cycle when reading the wave height cycle at the restart *Time to be divisible by WAVE2_TIN
res_STRS	= 0	!!Read line boundary (levee) data again (map and bdh)
res_FR1		= 0	!!Read roughness data again (specify new file in input_form)
res_shisetsu	= 0	!!Read facility information data again (specify new file in input_form)
rs_out(1)	= 2600,6000,7400,12000,14000,20000	!!Steps to output restart files (specify by comma separator such as 2,10) (max 50)
/

&input_form
!-----------------------------------------
!  Input file settings
!-----------------------------------------
DEPFILE	= '../dat/case02.dep'			!!Terrain data file (input terminal 01)
MAPFILE	= '../dat/case02.map'			!!Map data file (input terminal 02)
FMFILE	= '../dat/case02.fm'			!!Roughness data file (input terminal 33)
TYFILE	= '../dat/isewan.prn'			!!Typhoon data file (input terminal 03)
PNTFILE	= '../dat/hst-point.pnt'		!!Time-series output point data file (input terminal 05)
NLPFILE	= '../dat/nlpara.dat'			!!Connection information point data (input terminal 04) Note ! Do not change
MAGFILE	= '../dat/case02.mag'			!!Land area determination data file (input terminal 07)
BDHFILE	= '../dat/case02.bdh'			!!Structure height data (CM) file (input terminal 09)
DEFFILE	= '../dat/case02.sf'			!!initial water level data (input terminal 19)
SBTFILE	= '../dat/case02.sf2'			!!Failure of the faults and the calculation of the amount of change in the moment of the collapse and the water level (Input Terminal 19)
/

&output_form
!-----------------------------------------
!  
!-----------------------------------------
OUTFPNT	= '../out/level3_0416.O10'		!!represents the series output power (input power terminal 10) at the location
OUTFSPZ	= '../out/level3_0416.O11'		!!Distribution of water level planes (inlet force terminal 11)
OUTFSPD	= '../out/level3_0416.O25'		!!Planar distribution of the immersion depth (inlet force terminal 25)
OUTFSUV	= '../out/level3_0416.O12'		!!Planar distribution of flow velocity (entry force terminal 12)
OUTFSX	= '../out/level3_0416.O13U'		!!Plane distribution of the wind speed in the X direction (inlet force terminal 13)
OUTFSWY	= '../out/level3_0416.O13V'		!!Wind speed Y-direction planar distribution (input force terminal 28)
OUTFSPS	= '../out/level3_0416.O14'		!!Plane distribution of air pressure (input force terminal 14)
OUTFZM	= '../out/level3_0416.O15'		!!Maximum water level planar distribution (input force terminal 15)
OUTFDM	= '../out/level3_0416.O26'		!!Planar distribution of the maximum immersion depth (entry force terminal 26)
OUTFZS	= '../out/level3_0416.O24'		!!Planar distribution of the minimum water level (entry force terminal 15)
OUTFINZ	= '../out/level3_0416.O16'		!!Initial water level plane distribution (Input terminal 16) Tsubame calculation
OUTFJIB	= '../out/level3_0416.O17'		!!Plane Distribution of Ground Level (Input Terminal 17)
OUTFTA	= '../out/level3_0416.O21'		!!Wave 1 Arrival Time Plane Distribution (Input Terminal 21)
OUTFTM	= '../out/level3_0416.O22'		!!Maximum Wave Arrival Time Plane Distribution (Input Terminal 22)
OUTFTMI	= '../out/level3_0416.O29'		!!Minimum Water Level Generation Time Plane Distribution (Input Terminal 29)
OUTFVM	= '../out/level3_0416.O23'		!!Plane distribution of maximum flow velocity (X- and Y-direction) (Input terminal 23)
OUTFLP	= '../out/level3_0416.O36'		!!LPOUT(inlet force terminal 36)
OUTFMWX	= '../out/level3_0416.O71'		!!Planar distribution in the x-direction at maximum wind speed (input force terminal 71)
OUTFMWY	= '../out/level3_0416.O72'		!!Plane distribution in the 7-direction at maximum wind speed (input force terminal 72)
OUTFMPS	= '../out/level3_0416.O73'		!!Minimum air pressure planar distribution (input terminal 73)
!-----------------------------------------
/





''';
    await File(
            '$curDir${sndPath}input\\wind_estimation\\typ\\dat\\PARAM_in.txt')
        .writeAsString(paramFile);
    print('Created Param_in file for Wind Estimation');
  }
}

class DescriptionProvider extends ChangeNotifier {
  String? description;

  void updateDescription(String? newDescription) {
    description = newDescription;
    notifyListeners();
  }
}
