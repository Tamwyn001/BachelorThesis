# Proximity effects in altermagnetic systems
### Code and latex source for the thesis projet

## Generate the graphs:
Place the terminal in `cd .\Source\GapEquation\`

    >.\generateGraph.ps1 -GnuScript <gnuplot sript> -SimulationPath <matlab .dat results>

### Lists of the graphs

**GapEquation: Correlation function**

# Mean line

    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_MeanLine.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/MeanLine/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_MeanLine30.gp" -SimulationPath "/SC30/Correlation_cdagg_c_" -LatexPath "/SC30/Correlation_cdagg_c_/MeanLine/";

### SC30
-- Litterature model 1

    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_MeanLine30SC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC30/Correlation_cdagg_c_/MeanLine/Phase117deg/LitteratureModel1/";

### SC13-M5-SC13

    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_MeanLineSCMSC.gp" -SimulationPath "/SC13M5SC13/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC13M5SC13/Correlation_cdagg_c_/MeanLine/Phase117deg/LitteratureModel1/";

# Heatmap
### SC10AM10
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapNoBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapVertBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/VertBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapVertHorizBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/VertHorizBC/";

### SC10AM4SC10
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_SCAMSC_phase190_NoBC.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase190deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/HeatMap/Phase190deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_SCAMSC_phase27_NoBC.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase27deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/HeatMap/Phase27deg/NoBC/";
   
### SC30
-- Litterature model 1

    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_long_SC_NoBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC30/Correlation_cdagg_c_/HeatMap/Phase117deg/LitteratureModel1/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_long_SC_VertBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC30/Correlation_cdagg_c_/HeatMap/Phase117deg/LitteratureModel1/VertBC/";

### SC13-M5-SC13
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_long_SCMSC_NoBC.gp" -SimulationPath "/SC13M5SC13/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC13M5SC13/Correlation_cdagg_c_/HeatMap/Phase117deg/LitteratureModel1/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_long_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC13M5SC13/Correlation_cdagg_c_/HeatMap/Phase117deg/LitteratureModel1/VertBC/";

# Currents
 ### SC10AM10
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_squared_SCAM_NoBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_VertBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/VertBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_VertHorizBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/VertHorizBC/"

# Benchmark currents
## ->SQUARED
### AM20 / SC20 / M20
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_AM.gp" -SimulationPath "/AM20/Correlation_cdagg_c_" -LatexPath "/AM20/Correlation_cdagg_c_/BenchmarkCurrent/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_SC.gp" -SimulationPath "/SC20/Correlation_cdagg_c_" -LatexPath "/SC20/Correlation_cdagg_c_/BenchmarkCurrent/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_M.gp" -SimulationPath "/M20/Correlation_cdagg_c_" -LatexPath "/M20/Correlation_cdagg_c_/BenchmarkCurrent/NoBC/";

## ->LONG
### SC30
-- Model litterture 1

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCNoBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel1/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCVertBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel1/VertBC/";

-- Model litterture 2

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCNoBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel2" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel2/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCVertBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/Litte6ratureModel2" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel2/VertBC/";

-- Own Model

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCNoBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/OwnModel" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/OwnModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCVertBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/OwnModel" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/OwnModel/VertBC/";

### SC13-M5-SC13
-- Model litterture 1

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCMSC_NoBC.gp" -SimulationPath "/SC13M5SC13/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC13M5SC13/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel1/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC13M5SC13/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel1/VertBC/";

-- Model litterture 2

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCMSC_NoBC.gp" -SimulationPath "/SC13M5SC13/Correlation_cdagg_c_/Phase117deg/LitteratureModel2" -LatexPath "/SC13M5SC13/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel2/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Correlation_cdagg_c_/Phase117deg/LitteratureModel2" -LatexPath "/SC13M5SC13/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel2/VertBC/";

-- Own Model

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCMSC_NoBC.gp" -SimulationPath "/SC13M5SC13/Correlation_cdagg_c_/Phase117deg/OwnModel" -LatexPath "/SC13M5SC13/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/OwnModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Correlation_cdagg_c_/Phase117deg/OwnModel" -LatexPath "/SC13M5SC13/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/OwnModel/VertBC/";


# Currents for diffrent fixed phase
### SC10AM4SC10

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_SCAMSC_Phase190deg.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase190deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/Current/Phase190deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_SCAMSC_Phase27deg.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase27deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/Current/Phase27deg/NoBC/";

# PhaseMaps
## ->SQUARED
### SC10AM4SC10

    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_SCAMSC_NoBC.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase27deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase/Phase27deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_SCAMSC_NoBC.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase190deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase/Phase90deg/NoBC/";

## ->LONG
### SC30
-- Model litterture 1

    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_long_SC_NoBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC30/Correlation_cdagg_c_/Phase/Phase117deg/LitteratureModel1/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_long_SC_VertBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC30/Correlation_cdagg_c_/Phase/Phase117deg/LitteratureModel1/VertBC/";

### SC13-M5-SC13
-- Model litterture 1

    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_long_SCMSC_NoBC.gp" -SimulationPath "/SC13M5SC13/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC13M5SC13/Correlation_cdagg_c_/Phase/Phase117deg/LitteratureModel1/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_long_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Correlation_cdagg_c_/Phase117deg/LitteratureModel1" -LatexPath "/SC13M5SC13/Correlation_cdagg_c_/Phase/Phase117deg/LitteratureModel1/VertBC/";
    



