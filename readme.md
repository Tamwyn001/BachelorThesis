# Proximity effects in altermagnetic systems
### Code and latex source for the thesis projet

## Generate the graphs:
Place the terminal in `cd .\Source\GapEquation\`

    >.\generateGraph.ps1 -GnuScript <gnuplot sript> -SimulationPath <matlab .dat results>

### Lists of the graphs

**GapEquation: Correlation function**

# Mean line

    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_squared_SCAM.gp" -SimulationPath "/SC10AM10" -LatexPath "/SC10AM10/MeanLine/";


# abs(Delta)

    .\generateGraph.ps1 -GnuScript "./gpScripts/abs_Delta_HeatMap/GapEq_HeatMap_squared_SCAM_NoBC.gp" -SimulationPath "/SC10AM10" -LatexPath "/SC10AM10/HeatMap/NoBC/";
   
# PhaseMaps

    .\generateGraph.ps1 -GnuScript "./gpScripts/Phase_Delta_HeatMap/Phase_HeatMap_3layers_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg" -LatexPath "/SC13M5SC13/Phase/Phase117deg/VertBC/";

# Currents

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_squared_SCAM_NoBC.gp" -SimulationPath "/SC10AM10" -LatexPath "/SC10AM10/Currents/NoBC/";
   
# Continuity

    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30DiffMU/2.75/LinearPhaseGradient/2.618" -LatexPath "/SC30/Continuity/Phase117deg/mu/2.75/LinearPhaseGradient/2.618/";