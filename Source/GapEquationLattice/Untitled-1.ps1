# Not fourier s wave

#SC 30
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SC_mu.gp" -SimulationPath "/SC30/NotFourier/FreeDelta/diffMU" -LatexPath "SC30/NotFourier/MeanLine/FreeDelta/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_phase_long_SC_muFlatPhase.gp" -SimulationPath "/SC30/NotFourier/FixedPhaseDelta/PhaseSide1.0472/diffMU" -LatexPath "SC30/NotFourier/MeanLine_Phase/FixedPhaseDelta/allMU//starting_1.0472/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_phase_long_SC_muFlatPhase.gp" -SimulationPath "/SC30/NotFourier/FixedPhaseDelta/PhaseSide-2.0944/diffMU" -LatexPath "SC30/NotFourier/MeanLine_Phase/FixedPhaseDelta/allMU//starting_-2.09446/"

./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_phase_long_SC_mu.gp" -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU" -LatexPath "SC30/NotFourier/MeanLine_Phase/FixedLinearPhaseGradient/Phase117deg/allMU/starting_-2.0944/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_phase_long_SC_mu2.gp" -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU" -LatexPath "SC30/NotFourier/MeanLine_Phase/FixedLinearPhaseGradient/Phase117deg/allMU/starting_1.0472/"

./generateGraph.ps1 -GnuScript ”gpScripts/Currents/Currents_long_SC_NoBC_mu-1.75.gp” -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-1.75/Starting_at/1.0472" -LatexPath "/SC30/NotFourier/Currents/FixedLinearPhaseGradient/Phase117deg/mu-1.75/";
./generateGraph.ps1 -GnuScript ”gpScripts/Currents/Currents_long_SC_NoBC_mu-2.75.gp” -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_at/1.0472" -LatexPath "/SC30/NotFourier/Currents/FixedLinearPhaseGradient/Phase117deg/mu-2.75/";
./generateGraph.ps1 -GnuScript ”gpScripts/Currents/Currents_long_SC_NoBC_mu-3.75.gp” -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-3.75/Starting_at/1.0472" -LatexPath "/SC30/NotFourier/Currents/FixedLinearPhaseGradient/Phase117deg/mu-3.75/";

./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_continuity_long_SC_mu-1.75.gp" -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-1.75/" -LatexPath "/SC30/NotFourier/Continuity/FixedLinearPhaseGradient/Phase117deg/mu-1.75/";
./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_continuity_long_SC_mu-2.75.gp" -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/" -LatexPath "/SC30/NotFourier/Continuity/FixedLinearPhaseGradient/Phase117deg/mu-2.75/";
./generateGraph.ps1 -GnuScript "gpScripts/MeanLine/MeanLine_continuity_long_SC_mu-3.75.gp" -SimulationPath "/SC30/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-3.75/" -LatexPath "/SC30/NotFourier/Continuity/FixedLinearPhaseGradient/Phase117deg/mu-3.75/";

#SC 15 AM 15
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu_m0 copy.gp" -SimulationPath "" -LatexPath "SC15AM15_m0.0/NotFourier/MeanLine/FreeDelta/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu_compareLength.gp" -SimulationPath "/SC15AM30_m0/NotFourier/FreeDelta/diffMU" -LatexPath "SCAM_CompareHeight/"

./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu-0.75_m.gp" -SimulationPath "" -LatexPath "SC15AM30/m-0.75/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu-1.75_m.gp" -SimulationPath "" -LatexPath "SC15AM30/m-1.75/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu-2.75_m.gp" -SimulationPath "" -LatexPath "SC15AM30/m-2.75/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu-3.75_m.gp" -SimulationPath "" -LatexPath "SC15AM30/m-3.75/"

./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu_m0.25.gp" -SimulationPath "/SC15AM15_m0.25/NotFourier/FreeDelta/diffMU" -LatexPath "SC15AM15_m0.25/NotFourier/MeanLine/FreeDelta/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu_m0.25.gp" -SimulationPath "/SC15AM15_m0.5/NotFourier/FreeDelta/diffMU" -LatexPath "SC15AM15_m0.5/NotFourier/MeanLine/FreeDelta/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu_m0.25.gp" -SimulationPath "/SC15AM15_m0.75/NotFourier/FreeDelta/diffMU" -LatexPath "SC15AM15_m0.75/NotFourier/MeanLine/FreeDelta/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu_m0.25.gp" -SimulationPath "/SC15AM15_m1/NotFourier/FreeDelta/diffMU" -LatexPath "SC15AM15_m1.0/NotFourier/MeanLine/FreeDelta/allMU/"

./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu_m.gp" -SimulationPath "/SC15AM15/NotFourier/FreeDelta/diffMU/-2.75/" -LatexPath "SC15AM15/NotFourier/MeanLine/FreeDelta/m/mu-2.75/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_mu_m.gp" -SimulationPath "/SC15AM15/NotFourier/FreeDelta/diffMU/2.75/" -LatexPath "SC15AM15/NotFourier/MeanLine/FreeDelta/m/mu2.75/"


./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM_muFlatPhase.gp" -SimulationPath "/SC15AM15/NotFourier/FixedPhaseDelta" -LatexPath "SC15AM15/NotFourier/MeanLine/FixedPhaseDelta/allMU/"

#  SC15 N 15
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCN_mu.gp" -SimulationPath "/SC15N15/NotFourier/FreeDelta/diffMU" -LatexPath "SC15N15/NotFourier/MeanLine/FreeDelta/allMU/"


#SC 12 AM 6 SC 12
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAMSC_mu.gp" -SimulationPath "/SC12AM6SC12/NotFourier/FreeDelta/diffMU" -LatexPath "SC12AM6SC12/NotFourier/MeanLine/FreeDelta/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_phase_long_SCAMSC_muFlatPhase.gp" -SimulationPath "/SC12AM6SC12/NotFourier/FixedPhaseDelta/PhaseSide1.0472/diffMU" -LatexPath "SC12AM6SC12/NotFourier/MeanLine_Phase/FixedPhaseDelta/allMU/"

./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_phase_long_SCAMSC_mu.gp” -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU" -LatexPath "/SC12AM6SC12/NotFourier/MeanLine_Phase/FixedLinearPhaseGradient/Phase117deg/DiffMU/starting_1.0472/";
./generateGraph.ps1 -GnuScript ”gpScripts/Currents/Currents_long_SCAMSC_VertBCmu-3.75.gp” -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-3.75/Starting_at/1.0472" -LatexPath "/SC12AM6SC12/NotFourier/Currents/FixedLinearPhaseGradient/Phase117deg/mu-3.75/starting_1.0472/";
./generateGraph.ps1 -GnuScript ”gpScripts/Currents/Currents_long_SCAMSC_VertBCmu-2.2.gp” -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.2/Starting_at/1.0472" -LatexPath "/SC12AM6SC12/NotFourier/Currents/FixedLinearPhaseGradient/Phase117deg/mu-2.2/starting_1.0472/";
./generateGraph.ps1 -GnuScript ”gpScripts/Currents/Currents_long_SCAMSC_VertBCmu-2.75.gp” -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75/Starting_at/1.0472" -LatexPath "/SC12AM6SC12/NotFourier/Currents/FixedLinearPhaseGradient/Phase117deg/mu-2.75/starting_1.0472/";
./generateGraph.ps1 -GnuScript ”gpScripts/Currents/Currents_long_SCAMSC_VertBCmu2.75.gp” -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/2.75/Starting_at/1.0472" -LatexPath "/SC12AM6SC12/NotFourier/Currents/FixedLinearPhaseGradient/Phase117deg/mu2.75/starting_1.0472/";

./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_continuity_long_SCAMSC-3.75.gp” -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-3.75" -LatexPath "/SC12AM6SC12/NotFourier/MeanLine_Continuity/FixedLinearPhaseGradient/Phase117deg/mu-3.75/starting_1.0472/";
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_continuity_long_SCAMSC-3.75.gp” -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.75" -LatexPath "/SC12AM6SC12/NotFourier/MeanLine_Continuity/FixedLinearPhaseGradient/Phase117deg/mu-2.75/starting_1.0472/";
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_continuity_long_SCAMSC-2.2.gp” -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/-2.2" -LatexPath "/SC12AM6SC12/NotFourier/MeanLine_Continuity/FixedLinearPhaseGradient/Phase117deg/mu-2.2/starting_1.0472/";
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_continuity_long_SCAMSC-3.75.gp” -SimulationPath "/SC12AM6SC12/NotFourier/FixedLinearPhaseGradient/Phase117deg/diffMU/2.75" -LatexPath "/SC12AM6SC12/NotFourier/MeanLine_Continuity/FixedLinearPhaseGradient/Phase117deg/mu2.75/starting_1.0472/";

./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAM12SC_mu.gp" -SimulationPath "/SC12AM12SC12/NotFourier/FreeDelta/diffMU" -LatexPath "SC12AM12SC12/NotFourier/MeanLine/FreeDelta/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCAMSC_muFlatPhase.gp" -SimulationPath "/SC12AM6SC12/NotFourier/FixedPhaseDelta" -LatexPath "SC12AM6SC12/NotFourier/MeanLine/FixedPhaseDelta/allMU/"


# Fourier D wave SC 30
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SC_muFourier.gp" -SimulationPath "/SC30/Fourier/FreeDelta/diffMU" -LatexPath "SC30/Fourier/MeanLine/FreeDelta/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_Phase_long_SC_muFourier.gp" -SimulationPath "/SC30/Fourier/FreeDelta/diffMU" -LatexPath "SC30/Fourier/MeanLine_Phase/FreeDelta/allMU/"

# SC15N15
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SCN_muFourier.gp" -SimulationPath "/SC15N15/Fourier/FreeDelta/diffMU" -LatexPath "SC15N15/Fourier/MeanLine/FreeDelta/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_Phase_long_SCN_muFourier.gp" -SimulationPath "/SC15N15/Fourier/FreeDelta/diffMU" -LatexPath "SC15N15/Fourier/MeanLine_Phase/FreeDelta/allMU/"


# Fourier D wave SC 30 FLAT PHASE
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SC_muFourier.gp" -SimulationPath "/SC30/Fourier/FixedPhaseDelta/PhaseSide1.0472/diffMU" -LatexPath "SC30/Fourier/MeanLine/FixedPhaseDelta/PhaseSide1.0472/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_Phase_long_SC_muFourier.gp" -SimulationPath "/SC30/Fourier/FixedPhaseDelta/PhaseSide1.0472/diffMU" -LatexPath "SC30/Fourier/MeanLine_Phase/FixedPhaseDelta/PhaseSide1.0472/allMU/"

# Fourier D wave SC 30 Linear gradient
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_long_SC_muFourierGrad.gp" -SimulationPath "/SC30/Fourier/FixedLinearPhaseGradient/Phase117deg/diffMU" -LatexPath "SC30/Fourier/MeanLine/FixedLinearPhaseGradient/Phase117deg/allMU/"
./generateGraph.ps1 -GnuScript ”gpScripts/MeanLine/MeanLine_Phase_long_SC_muFourierGrad.gp" -SimulationPath "/SC30/Fourier/FixedLinearPhaseGradient/Phase117deg/diffMU" -LatexPath "SC30/Fourier/MeanLine_Phase/FixedLinearPhaseGradient/Phase117deg/allMU/"
