./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SC_mu.gp" -SimulationPath "/SC30/NotFourier/FreeDelta/diffMU" -LatexPath "SC30/NotFourier/MeanLine/FreeDelta/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SC_mu2.gp" -SimulationPath "/SC30/NotFourier/FixedDeltaNorm/diffMU" -LatexPath "SC30/NotFourier/MeanLine/FixedDeltaNorm/allMU/"

./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SC_mu.gp" -SimulationPath "/SC30/NotFourier/FixedNormPhaseDelta/PhaseSide-1.0472/diffMU" -LatexPath "SC30/NotFourier/MeanLine/FixedNormPhaseDelta/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_phase_long_SC_muFlatPhase.gp" -SimulationPath "/SC30/NotFourier/FixedNormPhaseDelta/PhaseSide-1.0472/diffMU" -LatexPath "SC30/NotFourier/MeanLine_Phase/FixedNormPhaseDelta/allMU/"

./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_phase_long_SC_mu.gp" -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU" -LatexPath "SC30/NotFourier/MeanLine_Phase/FixedLinearPhaseGradient/Phase117deg/allMU/starting_-1.0472/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_phase_long_SC_mu2.gp" -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU" -LatexPath "SC30/NotFourier/MeanLine_Phase/FixedLinearPhaseGradient/Phase117deg/allMU/starting_1.0472/"


./generateGraph.ps1 -GnuScript ”gpScripts/Currents/Currents_long_SC_VertBC.gp” -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_at/-1.0472" -LatexPath "/SC30/NotFourier/Currents/FixedLinearPhaseGradient/Phase117deg/mu-2.75/starting_-1.0472/";
./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_continuity_long_SC.gp" -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_at/-1.0472" -LatexPath "/SC30/NotFourier/Continuity/FixedLinearPhaseGradient/Phase117deg/mu-2.75/starting_-1.0472/";
./generateGraph.ps1 -GnuScript ”gpScripts/Currents/Currents_long_SC_VertBC.gp” -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_at/1.0472" -LatexPath "/SC30/NotFourier/Currents/FixedLinearPhaseGradient/Phase117deg/mu-2.75/starting_1.0472/";
./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_continuity_long_SC.gp" -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_at/1.0472" -LatexPath "/SC30/NotFourier/Continuity/FixedLinearPhaseGradient/Phase117deg/mu-2.75/starting_1.0472/";

./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_squared_SCAM.gp" -SimulationPath "/SC15AM15/NotFourier/FreeDelta/diffMU/-2.75" -LatexPath "/SC15AM15/NotFourier/MeanLine/FreeDelta/diffMU/-2.75/";

./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_phase_long_SCAM.gp" -SimulationPath "/SC15AM15/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU" -LatexPath "/SC15AM15/NotFourier/MeanLinePhase/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/";

./generateGraph.ps1 -GnuScript "gpScripts/Currents/Currents_long_SCAM_NoBC.gp" -SimulationPath "/SC15AM15/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_at/1.0472" -LatexPath "/SC15AM15/NotFourier/Currents/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_1.0472/";

./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_continuity_long_SCAM.gp" -SimulationPath "/SC15AM15/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_at/1.0472" -LatexPath "/SC15AM15/NotFourier/Continuity/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_1.0472/";



./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_3layers_SCAMSC.gp" -SimulationPath "/SC12AM6SC12/NotFourier/FreeDelta/diffMU/-2.75" -LatexPath "/SC12AM6SC12/NotFourier/FreeDelta/diffMU/-2.75";

./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_3layers_SCAMSC.gp" -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_at/1.0472/" -LatexPath "/SC12AM6SC12/NotFourier/Meanline/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_1.0472/";

./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_phase_3layers_SCAMSC.gp" -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/" -LatexPath "/SC12AM6SC12/NotFourier/Meanline_Phase/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_1.0472/";

./generateGraph.ps1 -GnuScript "gpScripts/Currents/Currents_3layers_SCAMSC_NoBC.gp" -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_at/1.0472" -LatexPath "/SC12AM6SC12/NotFourier/Currents/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_1.0472/";

./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_continuity_3layers_SCAMSC.gp" -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_at/1.0472" -LatexPath "/SC12AM6SC12/NotFourier/Continuity/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_1.0472/";
