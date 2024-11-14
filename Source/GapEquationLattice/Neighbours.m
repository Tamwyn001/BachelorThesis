function [areNeighbours, axe] = Neighbours(PointA,PointB, system)
%NEIGHBOURS Returs if the lattice site i and j are neighbours L represents the lattice size
%   Detailed explanation goes here

%are the particle on the side
areNeighbours = false;
axe = 'null';
%upper line linked with lower line in periodic boundary conditions
if ((strcmp(PointA.type, 'cornerUL') && strcmp(PointB.type, 'cornerDL')) ...
    || (strcmp(PointA.type, 'cornerDL') && strcmp(PointB.type, 'cornerUL'))) ...
    && SystemBase.verticalPeriodicBoundary
    areNeighbours = true;
    axe = 'y';
    return
elseif ((strcmp(PointA.type, 'cornerUL') && strcmp(PointB.type, 'cornerUR')) ...
    || (strcmp(PointA.type, 'cornerUR') && strcmp(PointB.type, 'cornerUL')))...
    && SystemBase.horizontalPeriodicBoundary
    areNeighbours = true;
    axe = 'x';
    return
end

if ((strcmp(PointA.type, 'cornerDR') && strcmp(PointB.type, 'cornerUR')) ...
    || (strcmp(PointA.type, 'cornerUR') && strcmp(PointB.type, 'cornerDR'))) ...
    && SystemBase.verticalPeriodicBoundary
    areNeighbours = true;
    axe = 'y';
    return
elseif ((strcmp(PointA.type, 'cornerDR') && strcmp(PointB.type, 'cornerDL')) ...
    || (strcmp(PointA.type, 'cornerDL') && strcmp(PointB.type, 'cornerDR')))...
    && SystemBase.horizontalPeriodicBoundary
    areNeighbours = true;
    axe = 'x';
    return
end
if ((strcmp(PointA.type, 'sideU') && strcmp(PointB.type, 'sideD'))...
    || (strcmp(PointA.type, 'sideD') && strcmp(PointB.type, 'sideU')))...
    && SystemBase.verticalPeriodicBoundary
    areNeighbours = (PointA.x == PointB.x);
    axe = 'y';
    return
end
%left line linked with right line in periodic boundary conditions
if ((strcmp(PointA.type, 'sideL') && strcmp(PointB.type, 'sideR'))...
    || (strcmp(PointA.type, 'sideR') && strcmp(PointB.type, 'sideL')))...
    && SystemBase.horizontalPeriodicBoundary
    areNeighbours = (PointA.y == PointB.y);
    axe = 'x';
    return
end

%neighbours in the interior
if ( (PointB.i == (PointA.i - system.Nx)) || (PointB.i == (PointA.i + system.Nx)))
    areNeighbours = true;
    axe = 'y';
    return
elseif (((PointB.i == PointA.i - 1 ) || (PointB.i == PointA.i + 1)) && (PointA.y == PointB.y))% avoid the case where i-1 is on the other side
    areNeighbours = true;
    axe = 'x';
    return
end
%no neighbours ;-;
areNeighbours = false;
end
