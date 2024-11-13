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

    
-- Fixed Delta : ZeroPhase and linear gradient

    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_long_SC_mu.gp" -SimulationPath "/SC30/Phase117deg/diffMU/LinearGradient" -LatexPath "/SC30/MeanLine/Phase117deg/mu/LinearGradient/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_long_SC_mu.gp" -SimulationPath "/SC30/Phase117deg/diffMU/ZeroPhase" -LatexPath "/SC30/MeanLine/Phase117deg/mu/ZeroPhase/"
    
-- Fixed Phase : ZeroPhase and linear gradient

    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_long_SC_mu.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/LinearGradient" -LatexPath "/SC30/MeanLine/Phase117deg/mu/FixedPhase/LinearGradient/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_long_SC_mu.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/ZeroPhase" -LatexPath "/SC30/MeanLine/Phase117deg/mu/FixedPhase/ZeroPhase/";

-> Benchmark week 3
Fixed flat phase

    .\generateGraph.ps1 "./gpScripts/MeanLine/MeanLine_long_SC_mu_Flat.gp" -SimulationPath "/SC30diffMU/2.75/FixedFlatPhase" -LatexPath "SC30/MeanLine/PhaseFlat/mu/2.75/FixedFlatPhase/";
    .\generateGraph.ps1 "./gpScripts/MeanLine/MeanLine_long_SC_mu_Flat.gp" -SimulationPath "/SC30diffMU/0.75/FixedFlatPhase" -LatexPath "SC30/MeanLine/PhaseFlat/mu/0.75/FixedFlatPhase/";

LinearPhaseGradient

    .\generateGraph.ps1 "./gpScripts/MeanLine/MeanLine_long_SC_mu_Flat.gp" -SimulationPath "/SC30diffMU/2.75/LinearPhaseGradient" -LatexPath "SC30/MeanLine/Phase117deg/mu/2.75/LinearPhaseGradient/";
    .\generateGraph.ps1 "./gpScripts/MeanLine/MeanLine_long_SC_mu_Flat.gp" -SimulationPath "/SC30diffMU/0.75/LinearPhaseGradient" -LatexPath "SC30/MeanLine/Phase117deg/mu/0.75/LinearPhaseGradient/";


For the phase meanline

    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_phase_long_SC_mu.gp" -SimulationPath "/SC30/Phase117deg/diffMU/LinearGradient" -LatexPath "/SC30/MeanLine_Phase/Phase117deg/mu/LinearGradient/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_phase_long_SC_mu.gp" -SimulationPath "/SC30/Phase117deg/diffMU/ZeroPhase" -LatexPath "/SC30/MeanLine_Phase/Phase117deg/mu/ZeroPhase/";

-- FixedPhase, Linear Gradient and Zero Phase

    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_phase_long_SC_mu.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/LinearGradient" -LatexPath "/SC30/Phase_MeanLine/Phase117deg/mu/FixedPhase/LinearGradient/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_phase_long_SC_mu.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/ZeroPhase" -LatexPath "/SC30/Phase_MeanLine/Phase117deg/mu/FixedPhase/ZeroPhase/";

-> Benchmark week 3
Fixed flat phase

    .\generateGraph.ps1 "./gpScripts/MeanLine/MeanLine_phase_long_SC_mu.gp" -SimulationPath "/SC30diffMU/2.75/FixedFlatPhase" -LatexPath "SC30/MeanLine_Phase/PhaseFlat/mu/2.75/FixedFlatPhase/";
    .\generateGraph.ps1 "./gpScripts/MeanLine/MeanLine_phase_long_SC_mu.gp" -SimulationPath "/SC30diffMU/0.75/FixedFlatPhase" -LatexPath "SC30/MeanLine_Phase/PhaseFlat/mu/0.75/FixedFlatPhase/";

LinearPhaseGradient

    .\generateGraph.ps1 "./gpScripts/MeanLine/MeanLine_phase_long_SC_mu.gp" -SimulationPath "/SC30diffMU/2.75/LinearPhaseGradient" -LatexPath "SC30/MeanLine_Phase/Phase117deg/mu/2.75/LinearPhaseGradient/";
    .\generateGraph.ps1 "./gpScripts/MeanLine/MeanLine_phase_long_SC_mu.gp" -SimulationPath "/SC30diffMU/0.75/LinearPhaseGradient" -LatexPath "SC30/MeanLine_Phase/Phase117deg/mu/0.75/LinearPhaseGradient/";

Mutli line of -3.75

    .\generateGraph.ps1 -GnuScript "./gpScripts/MeanLine/MeanLine_phase_long_SC_mu_step.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/LinearGradient/" -LatexPath "/SC30/MeanLine_Phase/Phase117deg/mu/FixedPhase/LinearGradient/";

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

    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/OwnModel" -LatexPath "/SC30/Currents/Phase117deg/OwnModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_VertBC.gp" -SimulationPath "/SC30/Phase117deg/OwnModel" -LatexPath "/SC30/Currents/Phase117deg/OwnModel/VertBC/";

    -- Fixed Delta : ZeroPhase and linear gradient

        .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/LinearGradient/-0.75" -LatexPath "/SC30/Current/Phase117deg/mu/LinearGradient/long-0.75/";
        .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/LinearGradient/0.75" -LatexPath "/SC30/Current/Phase117deg/mu/LinearGradient/long0.75/";

        .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/ZeroPhase/-0.75" -LatexPath "/SC30/Current/Phase117deg/mu/ZeroPhase/long-0.75/";
        .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/ZeroPhase/0.75" -LatexPath "/SC30/Current/Phase117deg/mu/ZeroPhase/long0.75/";

    -- Fixed Phase : ZeroPhase and linear gradient

        .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/ZeroPhase/-0.75" -LatexPath "/SC30/Current/Phase117deg/mu/FixedPhase/ZeroPhase/long-0.75/";
        .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/ZeroPhase/0.75" -LatexPath "/SC30/Current/Phase117deg/mu/FixedPhase/ZeroPhase/long0.75/";

        .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/LinearGradient/-0.75" -LatexPath "/SC30/Current/Phase117deg/mu/FixedPhase/LinearGradient/long-0.75/";
        .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/LinearGradient/0.75" -LatexPath "/SC30/Current/Phase117deg/mu/FixedPhase/LinearGradient/long0.75/";

-- week 3 benchmark

LinearPhaseGradient

    .\generateGraph.ps1 "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30diffMU/2.75/LinearPhaseGradient/1.0472" -LatexPath "SC30/Current/mu/2.75/LinearPhaseGradient/1.0472/";
    .\generateGraph.ps1 "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30diffMU/0.75/LinearPhaseGradient/1.0472" -LatexPath "SC30/Current/mu/0.75/LinearPhaseGradient/1.0472/";

    .\generateGraph.ps1 "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30diffMU/2.75/LinearPhaseGradient/-1.0472" -LatexPath "SC30/Current/mu/2.75/LinearPhaseGradient/-1.0472/";
    .\generateGraph.ps1 "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30diffMU/0.75/LinearPhaseGradient/-1.0472" -LatexPath "SC30/Current/mu/0.75/LinearPhaseGradient/-1.0472/";

    
    .\generateGraph.ps1 "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30diffMU/2.75/LinearPhaseGradient/0.5236" -LatexPath "SC30/Current/mu/2.75/LinearPhaseGradient/0.5236/";
    .\generateGraph.ps1 "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30diffMU/0.75/LinearPhaseGradient/0.5236" -LatexPath "SC30/Current/mu/0.75/LinearPhaseGradient/0.5236/";

        .\generateGraph.ps1 "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30diffMU/2.75/LinearPhaseGradient/2.618" -LatexPath "SC30/Current/mu/2.75/LinearPhaseGradient/2.618/";
    .\generateGraph.ps1 "./gpScripts/Currents/Currents_long_SC_NoBC.gp" -SimulationPath "/SC30diffMU/0.75/LinearPhaseGradient/2.618" -LatexPath "SC30/Current/mu/0.75/LinearPhaseGradient/2.618/";
### SC13-M5-SC13


    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCMSC_NoBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg/OwnModel" -LatexPath "/SC13M5SC13/Currents/Phase117deg/OwnModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCMSC_VertBC.gp" -SimulationPath "/SC13M5SC13/Phase117deg/OwnModel" -LatexPath "/SC13M5SC13/Currents/Phase117deg/OwnModel/VertBC/";

### SC13-AM5-SC13


    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCAMSC_NoBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg/OwnModel" -LatexPath "/SC13AM5SC13/Currents/Phase117deg/OwnModel/NoBC/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Currents/Currents_3layers_SCAMSC_VertBC.gp" -SimulationPath "/SC13AM5SC13/Phase117deg/OwnModel" -LatexPath "/SC13AM5SC13/Currents/Phase117deg/OwnModel/VertBC/";

    
# Continuity
## LONG

### SC30

-- Fixed Delta : ZeroPhase and linear gradient

    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/LinearGradient/-0.75" -LatexPath "/SC30/Continuity/Phase117deg/mu/LinearGradient/long-0.75/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/LinearGradient/0.75" -LatexPath "/SC30/Continuity/Phase117deg/mu/LinearGradient/long0.75/";

    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/ZeroPhase/-0.75" -LatexPath "/SC30/Continuity/Phase117deg/mu/ZeroPhase/long-0.75/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/ZeroPhase/0.75" -LatexPath "/SC30/Continuity/Phase117deg/mu/ZeroPhase/long0.75/";

-- Fixed Phase : ZeroPhase and linear gradient

    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/ZeroPhase/-0.75" -LatexPath "/SC30/Continuity/Phase117deg/mu/FixedPhase/ZeroPhase/long-0.75/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/ZeroPhase/0.75" -LatexPath "/SC30/Continuity/Phase117deg/mu/FixedPhase/ZeroPhase/long0.75/";

    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/LinearGradient/-0.75" -LatexPath "/SC30/Continuity/Phase117deg/mu/FixedPhase/LinearGradient/long-0.75/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30/Phase117deg/diffMU/FixedPhase/LinearGradient/0.75" -LatexPath "/SC30/Continuity/Phase117deg/mu/FixedPhase/LinearGradient/long0.75/";

-- week 3 benchmark

    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30DiffMU/0.75/LinearPhaseGradient/-1.0472" -LatexPath "/SC30/Continuity/Phase117deg/mu/0.75/LinearPhaseGradient/-1.0472/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30DiffMU/0.75/LinearPhaseGradient/0.5236" -LatexPath "/SC30/Continuity/Phase117deg/mu/0.75/LinearPhaseGradient/0.5236/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30DiffMU/0.75/LinearPhaseGradient/1.0472" -LatexPath "/SC30/Continuity/Phase117deg/mu/0.75/LinearPhaseGradient/1.0472/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30DiffMU/0.75/LinearPhaseGradient/2.618" -LatexPath "/SC30/Continuity/Phase117deg/mu/0.75/LinearPhaseGradient/2.618/";

    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30DiffMU/2.75/LinearPhaseGradient/-1.0472" -LatexPath "/SC30/Continuity/Phase117deg/mu/2.75/LinearPhaseGradient/-1.0472/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30DiffMU/2.75/LinearPhaseGradient/0.5236" -LatexPath "/SC30/Continuity/Phase117deg/mu/2.75/LinearPhaseGradient/0.5236/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30DiffMU/2.75/LinearPhaseGradient/1.0472" -LatexPath "/SC30/Continuity/Phase117deg/mu/2.75/LinearPhaseGradient/1.0472/";
    .\generateGraph.ps1 -GnuScript "./gpScripts/Continuity/Continuity_long_SC.gp" -SimulationPath "/SC30DiffMU/2.75/LinearPhaseGradient/2.618" -LatexPath "/SC30/Continuity/Phase117deg/mu/2.75/LinearPhaseGradient/2.618/";