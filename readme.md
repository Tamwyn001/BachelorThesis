# Proximity effects in altermagnetic systems
### Code and latex source for the thesis projet

## Generate the graphs:
Place the terminal in `cd .\Source\GapEquation\`

    >.\generateGraph.ps1 -GnuScript <gnuplot sript> -SimulationPath <matlab .dat results>

### Lists of the graphs

**GapEquation: Correlation function**

# Mean line

### SC10-AM10

    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_squared_SCAM.gp" -SimulationPath "/SC10AM10" -LatexPath "/SC10AM10/MeanLine/";

### SC30

    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_long_SC.gp" -SimulationPath "/SC30/Phase117deg" -LatexPath "/SC30/MeanLine/Phase117deg/";

### SC13-M5-SC13

    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_3layers_SCMSC.gp" -SimulationPath "/SC13M5SC13/Phase117deg" -LatexPath "/SC13M5SC13/MeanLine/Phase117deg/";

### SC13-AM5-SC13

    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_3layers_SCAMSC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg" -LatexPath "/SC13AM5SC13/MeanLine/Phase117deg/";

# abs(Delta)
### SC10-AM10

    .\generateGraph.ps1 -GnuScript "./gpScripts/abs_Delta_HeatMap/GapEq_HeatMap_squared_SCAM_NoBC.gp" -SimulationPath "/SC10AM10" -LatexPath "/SC10AM10/HeatMap/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/abs_Delta_HeatMap/GapEq_HeatMap_squared_SCAM_VertBC.gp" -SimulationPath "/SC10AM10" -LatexPath "/SC10AM10/HeatMap/VertBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/abs_Delta_HeatMap/GapEq_HeatMap_squared_SCAM_VertHorizBC.gp" -SimulationPath "/SC10AM10" -LatexPath "/SC10AM10/HeatMap/VertHorizBC/";

### SC13-AM5-SC13

    .\generateGraph.ps1 -GnuScript "./gpScripts/abs_Delta_HeatMap/GapEq_HeatMap_3layers_SCAMSC_NoBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg" -LatexPath "/SC13AM5SC13/HeatMap/Phase117deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/abs_Delta_HeatMap/GapEq_HeatMap_3layers_SCAMSC_VertBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg" -LatexPath "/SC13AM5SC13/HeatMap/Phase117deg/VertBC/";

`To be computed:`

    .\generateGraph.ps1 -GnuScript "./gpScripts/abs_Delta_HeatMap/GapEq_HeatMap_3layers_SCAMSC_phase27_NoBC.gp" -SimulationPath "/SC13AM5SC13/Phase27deg" -LatexPath "/SC13AM5SC13/HeatMap/Phase27deg/NoBC/";
   
### SC30

    .\generateGraph.ps1 -GnuScript "./gpScripts/abs_Delta_HeatMap/GapEq_HeatMap_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg" -LatexPath "/SC30/HeatMap/Phase117deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/abs_Delta_HeatMap/GapEq_HeatMap_long_SC_VertBC.gp" -SimulationPath "/SC30/Phase117deg" -LatexPath "/SC30/HeatMap/Phase117deg/VertBC/";

### SC13-M5-SC13

    .\generateGraph.ps1 -GnuScript "./gpScripts/abs_Delta_HeatMap/GapEq_HeatMap_3layers_SCMSC_NoBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg" -LatexPath "/SC13M5SC13/HeatMap/Phase117deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/abs_Delta_HeatMap/GapEq_HeatMap_3layers_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg" -LatexPath "/SC13M5SC13/HeatMap/Phase117deg/VertBC/";

# Currents
## SQUARED
### SC10-AM10

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_squared_SCAM_NoBC.gp" -SimulationPath "/SC10AM10" -LatexPath "/SC10AM10/Currents/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_squared_SCAM_VertBC.gp" -SimulationPath "/SC10AM10" -LatexPath "/SC10AM10/Currents/VertBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_squared_SCAM_VertHorizBC.gp" -SimulationPath "/SC10AM10" -LatexPath "/SC10AM10/Currents/VertHorizBC/"

### AM20 / SC20 / M20 NoBC

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_squared_AM.gp" -SimulationPath "/AM20" -LatexPath "/AM20/Currents/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_squared_SC.gp" -SimulationPath "/SC20" -LatexPath "/SC20/Currents/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_squared_M.gp"  -SimulationPath "/M20" -LatexPath "/M20/Currents/NoBC/";

## LONG
### SC30
-- Model litterture 1

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/LitteratureModel1" -LatexPath "/SC30/Currents/Phase117deg/LitteratureModel1/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_VertBC.gp" -SimulationPath "/SC30/Phase117deg/LitteratureModel1" -LatexPath "/SC30/Currents/Phase117deg/LitteratureModel1/VertBC/";

-- Model litterture 2

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/LitteratureModel2" -LatexPath "/SC30/Currents/Phase117deg/LitteratureModel2/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_VertBC.gp" -SimulationPath "/SC30/Phase117deg/LitteratureModel2" -LatexPath "/SC30/Currents/Phase117deg/LitteratureModel2/VertBC/";

-- Own Model

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/OwnModel" -LatexPath "/SC30/Currents/Phase117deg/OwnModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_VertBC.gp" -SimulationPath "/SC30/Phase117deg/OwnModel" -LatexPath "/SC30/Currents/Phase117deg/OwnModel/VertBC/";

### SC13-M5-SC13
-- Model litterture 1

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCMSC_NoBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg/LitteratureModel1" -LatexPath "/SC13M5SC13/Currents/Phase117deg/LitteratureModel1/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg/LitteratureModel1" -LatexPath "/SC13M5SC13/Currents/Phase117deg/LitteratureModel1/VertBC/";

-- Model litterture 2

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCMSC_NoBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg/LitteratureModel2" -LatexPath "/SC13M5SC13/Currents/Phase117deg/LitteratureModel2/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg/LitteratureModel2" -LatexPath "/SC13M5SC13/Currents/Phase117deg/LitteratureModel2/VertBC/";

-- Own Model

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCMSC_NoBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg/OwnModel" -LatexPath "/SC13M5SC13/Currents/Phase117deg/OwnModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg/OwnModel" -LatexPath "/SC13M5SC13/Currents/Phase117deg/OwnModel/VertBC/";

### SC13-AM5-SC13
-- Model litterture 1

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCAMSC_NoBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg/LitteratureModel1" -LatexPath "/SC13AM5SC13/Currents/Phase117deg/LitteratureModel1/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCAMSC_VertBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg/LitteratureModel1" -LatexPath "/SC13AM5SC13/Currents/Phase117deg/LitteratureModel1/VertBC/";

-- Model litterture 2

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCAMSC_NoBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg/LitteratureModel2" -LatexPath "/SC13AM5SC13/Currents/Phase117deg/LitteratureModel2/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCAMSC_VertBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg/LitteratureModel2" -LatexPath "/SC13AM5SC13/Currents/Phase117deg/LitteratureModel2/VertBC/";

-- Own Model

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCAMSC_NoBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg/OwnModel" -LatexPath "/SC13AM5SC13/Currents/Phase117deg/OwnModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCAMSC_VertBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg/OwnModel" -LatexPath "/SC13AM5SC13/Currents/Phase117deg/OwnModel/VertBC/";


# PhaseMaps
## SQUARED

## Long
### SC30

    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_Delta_HeatMap/Phase_HeatMap_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg" -LatexPath "/SC30/Phase/Phase117deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_Delta_HeatMap/Phase_HeatMap_long_SC_VertBC.gp" -SimulationPath "/SC30/Phase117deg" -LatexPath "/SC30/Phase/Phase117deg/VertBC/";

## 3layers    
### SC13-AM5-SC13

    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_Delta_HeatMap/Phase_HeatMap_3layers_SCAMSC_NoBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg" -LatexPath "/SC13AM5SC13/Phase/Phase117deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_Delta_HeatMap/Phase_HeatMap_3layers_SCAMSC_VertBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg" -LatexPath "/SC13AM5SC13/Phase/Phase117deg/VertBC/";

### SC13-M5-SC13

    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_Delta_HeatMap/Phase_HeatMap_3layers_SCMSC_NoBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg" -LatexPath "/SC13M5SC13/Phase/Phase117deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_Delta_HeatMap/Phase_HeatMap_3layers_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg" -LatexPath "/SC13M5SC13/Phase/Phase117deg/VertBC/";
    



