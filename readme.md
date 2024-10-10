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
    .\generateGraph.ps1 -GnuScript "./gpScripts/GapEq_Heatmap.gp" -SimulationPath "/SC10AM10/Correlation_cdagg_c_" -LatexPath "/SC10AM10/Correlation_cdagg_c_/HeatMap/"