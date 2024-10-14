# Proximity effects in altermagnetic systems
### Code and latex source for the thesis projet

## Generate the graphs:
Place the terminal in `cd .\Source\GapEquation\`

    >.\generateGraph.ps1 -GnuScript <gnuplot sript> -SimulationPath <matlab .dat results>

### Lists of the graphs

**GapEquation: Correlation function**

    # Mean line
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_MeanLine.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/MeanLine/"

    # Heatmap
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapNoBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapVertBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/VertBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_HeatmapVertHorizBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/VertHorizBC/"

    # Currents
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_NoBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_VertBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/VertBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents_VertHorizBC.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/Currents/VertHorizBC/"

