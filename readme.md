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

    -- Litterature model 1
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_MeanLine30SC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel" -LatexPath "/SC30/Correlation_cdagg_c_/MeanLine/Phase117deg/LitteratureModel/";

    -- Litterature model 2
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_MeanLine30SC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel2" -LatexPath "/SC30/Correlation_cdagg_c_/MeanLine/Phase117deg/LitteratureModel2/";

    -- Own model
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_MeanLine30SC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/OwnModel" -LatexPath "/SC30/Correlation_cdagg_c_/MeanLine/Phase117deg/OwnModel/";

    # Heatmap
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapNoBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapVertBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/VertBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapVertHorizBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/VertHorizBC/";

    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_SCAMSC_phase190_NoBC.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase190deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/HeatMap/Phase190deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_SCAMSC_phase27_NoBC.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase27deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/HeatMap/Phase27deg/NoBC/";
   
    -- Litterature model 1
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_long_SC_NoBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel" -LatexPath "/SC30/Correlation_cdagg_c_/HeatMap/Phase117deg/LitteratureModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_long_SC_VertBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel" -LatexPath "/SC30/Correlation_cdagg_c_/HeatMap/Phase117deg/LitteratureModel/VertBC/";

    -- Litterature model 2
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_long_SC_NoBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel2" -LatexPath "/SC30/Correlation_cdagg_c_/HeatMap/Phase117deg/LitteratureModel2/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_long_SC_VertBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel2" -LatexPath "/SC30/Correlation_cdagg_c_/HeatMap/Phase117deg/LitteratureModel2/VertBC/";

    -- Own model
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_long_SC_NoBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/OwnModel" -LatexPath "/SC30/Correlation_cdagg_c_/HeatMap/Phase117deg/OwnModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_long_SC_VertBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/OwnModel" -LatexPath "/SC30/Correlation_cdagg_c_/HeatMap/Phase117deg/OwnModel/VertBC/";


    # Currents
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_NoBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_VertBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/VertBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_VertHorizBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/VertHorizBC/"

    # Benchmark currents
    ->SQUARED
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_AM.gp" -SimulationPath "/AM20/Correlation_cdagg_c_" -LatexPath "/AM20/Correlation_cdagg_c_/BenchmarkCurrent/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_SC.gp" -SimulationPath "/SC20/Correlation_cdagg_c_" -LatexPath "/SC20/Correlation_cdagg_c_/BenchmarkCurrent/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_M.gp" -SimulationPath "/M20/Correlation_cdagg_c_" -LatexPath "/M20/Correlation_cdagg_c_/BenchmarkCurrent/NoBC/";

    ->LONG
    -- Model litterture 1
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCNoBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCVertBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel/VertBC/";

    -- Model litterture 2
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCNoBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel2" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel2/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCVertBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel2" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/LitteratureModel2/VertBC/";

    -- Own Model
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCNoBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/OwnModel" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/OwnModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_long_SCVertBC.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/OwnModel" -LatexPath "/SC30/Correlation_cdagg_c_/BenchmarkCurrent/Phase117deg/OwnModel/VertBC/";


    #Currents for diffrent fixed phase
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_SCAMSC_Phase190deg.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase190deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/Current/Phase190deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_SCAMSC_Phase27deg.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase27deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/Current/Phase27deg/NoBC/";

    #PhaseMaps
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_SCAMSC_NoBC.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase27deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase/Phase27deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_SCAMSC_NoBC.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase190deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase/Phase90deg/NoBC/";

    ->LONG
    -- Model litterture 1
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_long_NoBC_Base.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel" -LatexPath "/SC30/Correlation_cdagg_c_/Phase/Phase117deg/LitteratureModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_long_VertBC_Base.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel" -LatexPath "/SC30/Correlation_cdagg_c_/Phase/Phase117deg/LitteratureModel/VertBC/";
    -- Model litterture 2
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_long_NoBC_Base.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel2" -LatexPath "/SC30/Correlation_cdagg_c_/Phase/Phase117deg/LitteratureModel2/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_long_VertBC_Base.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/LitteratureModel2" -LatexPath "/SC30/Correlation_cdagg_c_/Phase/Phase117deg/LitteratureModel2/VertBC/";

    -- OwnModel
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_long_NoBC_Base.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/OwnModel" -LatexPath "/SC30/Correlation_cdagg_c_/Phase/Phase117deg/OwnModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_HeatMap_long_VertBC_Base.gp" -SimulationPath "/SC30/Correlation_cdagg_c_/Phase117deg/OwnModel" -LatexPath "/SC30/Correlation_cdagg_c_/Phase/Phase117deg/OwnModel/VertBC/";
    



