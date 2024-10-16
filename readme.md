# Proximity effects in altermagnetic systems
### Code and latex source for the thesis projet

## Generate the graphs:
Place the terminal in `cd .\Source\GapEquation\`

    >.\generateGraph.ps1 -GnuScript <gnuplot sript> -SimulationPath <matlab .dat results>

### Lists of the graphs

**GapEquation: Correlation function**

    # Mean line
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_MeanLine.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/MeanLine/";

    # Heatmap
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapNoBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapVertBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/VertBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapVertHorizBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/VertHorizBC/";

    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_SCAMSC_phase190_NoBC.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase190deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/HeatMap/Phase190deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatMap_SCAMSC_phase27_NoBC.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase27deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/HeatMap/Phase27deg/NoBC/";
   

    # Currents
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_NoBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_VertBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/VertBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_VertHorizBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/VertHorizBC/"

    # Benchmark currents
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_SC.gp" -SimulationPath "/AM20/Correlation_cdagg_c_" -LatexPath "/AM20/Correlation_cdagg_c_/BenchmarkCurrent/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_AM.gp" -SimulationPath "/SC20/Correlation_cdagg_c_" -LatexPath "/SC20/Correlation_cdagg_c_/BenchmarkCurrent/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_Benchmark_M.gp" -SimulationPath "/M20/Correlation_cdagg_c_" -LatexPath "/M20/Correlation_cdagg_c_/BenchmarkCurrent/NoBC/";

    #Currents for diffrent fixed phase
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_SCAMSC_Phase190deg.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase190deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/Current/Phase190deg/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_SCAMSC_Phase27deg.gp" -SimulationPath "/SC10AM4SC10/Correlation_cdagg_c_/Phase27deg" -LatexPath "/SC10AM4SC10/Correlation_cdagg_c_/Current/Phase27deg/NoBC/";

