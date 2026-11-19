#import "@preview/drafting:0.2.2"
= Related work

There are various studies and research papers focused on the topic of urban wind simulation and specifically on wake analysis. Repeating the methods presented in these studies is not the goal of this project. Instead, the aim is to evaluate existing methods, identify their limitations, and find elements that can be adapted for the project. This chapter will present the most relevant studies for the project.

== Computational Fluid Dynamics for urban physics

This paper is not focused directly on the topic of wake analysis, but it provides good guidelines for the general case of urban wind simulations @Blocken2015. 

- talks about scales, and how CFD is considered a microscale model. It states that the microscale applies to localized atmospheric flows, which describes the flow around buildings, streets and other urban features.

- (Consider if weather effects are relevant for the project at all)

- It states that the level of detail and omission of certain features can differ for various parts of the domain. For example, the level of detail can be higher in the area of interest, while it can be lower in other areas. This is relevant for the project, as it is not necessary to model the entire city with a high level of detail.

- CFD is prohibitively expensive for simulations over large periods of time, however this should not be a problem for the project. It suggests BES for long-term simulations. However, these have reduced resolution and is not suitable for the project.

- Suggests RANS and LES are most suitable for urban wind simulations. Additionally, it states a hybrid RANS-LES approach can be used. RANS is the time-averaged version of the Navier-Stokes equation, while LES is more detailed and resolves the larger turbulent structures.

- URANS does not model turbulence, but only approximates its statistics. LES is prefered over URANS.

- LES models larger eddies while filtering out smaller ones. Smaller eddies are modled instead of simulated.

- URANS-LES hybrid is described as a method that uses URANS at walls and LES for large turbulent structures. This could potentially be a good approach for the project, as it is not necessary to model the entire domain with LES. However, it is not clear how this method can be implemented in OpenFOAM.

- LES is less well established compared to RANS, as it is more computationally expensive. However, it is more accurate.

- It states that high quality grids are needed to achieve convergence. Poor convergence can often be traced back to poor quality grids. Papers often note that researchers revert to first order schemes to achieve convergence, instead of improving grid quality.

- Both grid resolution and the skewness of the cells can have an impact on the convergence. 

- It recommends 10 cells between buildings, it also requires a grid convergence study to see if it converges for three significantly different grids. It should also include a Richardson extrapolation to estimate the error. Cell stretching ratio should be less than 1.3.

- Convergence is achieved once the values have reduced to 10^-4.

- contains a table with recommended aerodynamic roughness values for various surfaces. Sand grain roughness also needs to be modeled correctly.

- Set appropriate boundary conditions for the domain. Includes formulas to determine conditions

- occilations in the residual can be good as they are caused by turbulence in the flow. This is because the residual is so converged that it starts reflecting the unsteadiness of the turbulent flow. However, can also be poor mesh quality, bad re

- Grid coverage index (GCI) is a method to quantify the uncertainty of the grid. It is based on the Richardson extrapolation and requires three grids with different resolutions. It can be used to determine if the grid is fine enough for the simulation.

- Perform a validation study to compare the results of the simulation with experimental data. This might be difficult for the project. However, the simulations can be compared with the measurements from the instruments on the roof.

- Documentation of the simulation is important, write down everything such that the experiments can be reproduced.

== Recommendations on the use of CFD in wind engineering
@Franke2004
- This paper is similar to the @Blocken2015 paper, but goes more into detail about some aspects.

- Firstly, it states that there are multiple closure problem solutions for the RANS equations. These are needed as the averaging introduces additional unknowns known as Reynolds stresses.

- The first approach is Eddy viscosity models. These are computationally cheap, but not very accurate. They use the Boussinesq approximation which makes it assume a singular scalar turbulent viscosity.

- The second approach is Reynolds stress models. These are more accurate as they solve additional differential equations for each unknown. However, this method is more computationally expensive. Unlike the Eddy viscosity models, flow is less isotropic, modelling realisty more closely.

- There exists a third method, which is a hybrid of the first two methods. It can account for the anisotropy of the flow, using non-linear functions of mean strain and vorticity tensors.

- It does not recommend the use of the standard k-epsilon model, as it is not suitable for wind simulation. It recommends realizable k-epsilon or k-omega SST or RNG k-epsilon. Ideally, use non-linear models.

#drafting.inline-note("Challenge this observation by saying:

Realizable k-epsilon can show unrealistic acceleration in some cases")

- It recommends to use probes to monitor key values in the region of interest and see if the residuals are converging.

== Flow-based stress-blended eddy simulation
- LES is very sensitive to the refinement of the grid, wrt the percentage of resolved eddies. Hybrid methods generally do not have this problem.

- Suggests an alternative to the RANS to LES approach. Instead, it uses a RANS-LES hybrid called DES (Detached Eddy Simulation). It uses RANS in the boundary layer and LES in the free stream. It is a more accurate method than RANS, but less expensive than LES. However, it approximates LES through modified turbulent dissipation instead of refined grid cells.

- It also suggests SBES which is a newer method which linearly blends turbulence to mimic LES and is somewhat better in that regard.

- @Liu2019 states that DDES took only 80.3% of the time to run compared to LES and has a linear correlation coefficient of 0.9.

- It states that even though it is less computationally heavy, it is still outside of the realm of possibilities for realistic approaches. However, the states source reports no such claims.

- Nevertheless, a gain of 20% is likely not worth it considering the amount of LES cases to be run. Furthermore, LES @SMAGORINSKY1963 appears to be a far more matured and proven method than the DES method @Spalart1997.

== Quantifying the impact of urban geometric detail for urban air mobility risk forecasting

- The paper compares the effects of LOD1.2 to LOD2.2 which represent the geometric complexity of the building geometry. It states the less complex LOD1.2 geometry has a roughly 20% difference in directionally averaged windspeed compared to the LOD2.2 case. Furthermore, the LOD 2.2 mesh becomes larger due the higher detail to be resolved. Nevertheless, the implementation of LOD 2.2 geometries is important for the receiver and transmitter of the scintillometer setup, as the wind cannot be accurately modelled around a building which itself does not represent reality.

- The paper simulates the flow around geometry at 1 degree intervals. Furthermore, a windrose is constructed which shows the probability of wind directions over a 20 year period. Furthermore, the velocities is plotted onto a histogram which is then used to determine a mean/average windspeed for all simulations. 

- While a 1 degree angle is chosen for this research paper. However, it makes mention of other papers such as @Haagbo2022, which evaluates varying wind direction ranges and compares the wind comfort to that of a 64 directional analysis. This equates to a roughly 5 degree angular resolution. For the application of wind comfort modelling a 10 degree resolution is deemed minimal by this paper.

#drafting.inline-note("For methodology mention that I choose a middleground between the 1 and 10 degree angular resolutions as a tradeoff between computational time and resolution of the analysis.")

== LES over RANS in building simulation for outdoor and indoor applications
- This article contains and exhaustive comparison between RANS and LES @Blocken2018.

- The general consensus is that LES is better at large solving turbulent structures, which does not mean all structures, as LES filters to only resolve large eddies. This makes it more suited for evaluating the turbulence, which is especially relevant for this project.

- RANS is much faster (e.g. less computationally demanding) and has sufficient accuracy for most general cases such as pedestrian comfort and polution dispertion. 

- LES is not automatically more reliable as it is more sensitive to design decisions compared to RANS. Furthermore, few concrete design recommendations exist for LES unlike RANS.

- It correctly notes that regardless of the choice, just having CFD analysis is no substitue for testing in real world or windtunnel conditions.

#drafting.inline-note("Use to support choice to do 'cheap' RANS for 360 degree look and using more accurate LES for evaluating in cases that require closer evaluation.")

== AIJ guidelines on the applications of large-eddy simulation to pedestrian wind environment

- While @Blocken2015 focusses on guidelines for RANS, this article does the same for LES @Okaze2026.

- The requirements set for the domain size match those found in @Blocken2015. This includes the distance in $-X$, $X$, $-Y$, $Y$, and $Z$ directions.

- Recommends a boundary of 2–3H around the area of interest which is likely between 1–2H in radius, resulting in a domain which is between 6 and 10H in diameter.

- The grid resolution around the target building should be approximately $1/20$ of the characteristic length of the target building to achieve sufficient grid resolution.

- The size of the computational grids near the inflow boundary should be at least an order of magnitude smaller than turbulence length of the inlet turbulence.

- It is imporant that the grid size does not vary significantly between cells to avoid occilations.

- It recommends the inclusion of trees using for example the cannopy height model

- It uses the following for modelling the drag of a given tree object:
$
bar(F)_i = -C_f a bar(u)_i sqrt((bar(u)_alpha)^2),
$ <eqn>
- where $C_f$ is the sectional drag coefficient, $a$ is the leaf surface area density (which is half of the total leaf area in the tree crown), and $sqrt((bar(u)_alpha)^2)$ is the magnitude of grid-scale wind velocity with repeated index $alpha$.

- It provides the required formulas and suggested constants for the inlet turbulence intensity and turbulence length scale.

- The outlet boundaries should follow a zero-gradient in the streamwise direction to allow for appropriate velocity fluctuations.

- The upper and side boundary conditions should free atmosphere or semetrical planes.

- It is recommended to use wall functions instead of having a very fine grid, as it allows for a coarser mesh by estimating the effects of the gradient in the first cell.

- It states that RANS is sometimes used as a solution for the inflow boundary condition, as this reduces the spin-up time of the LES solver where cells with no flow need to be populated.

- Various Subgrid-Scale (SGS) models can be used for LES. These model the effects that occur within grid cells.

- The most common model is @SMAGORINSKY1963, however it cannot correctly reproduce near wall behavior of wind fluctuations, it applies damping functions based on wall coordinates.

- It suggests the wall-adapting local eddy-viscosity (WALE) as an alternative. This model can model the near wall behavior and does not have a damping function and is therefore less computationally costly, as there is no damping function which needs to calculate the distance to the surface.

- For the computational algorithms it is recommended to avoid excessive numerical viscosity in the advection terms, to use second order schemes (like @Blocken2015 recommends for RANS as well)

- also recommends blending central differencing with a small amount of first-order upwind differencing to improve numerical stability 
#drafting.inline-note("figure out what this last bullet actually entails")

- time discretisation steps must be small enough so that the evolution of the turbulence is properly modeled. The Courant number should not significantly exceed 1 and second order or higher time-discretization schemes should be used to reduce numerical errors.

- Since LES fluctuates you cannot check convergence in the same way as RANS. Can be checked by seeing if the pressure equation is sufficiently solved at each time step, so:

  - Monitoring the pressure-equation residual
  - Checking velocity divergence to ensure continuity is maintained
  - Avoid unnecessarily strict converging criteria as it will never be perfect and will increase computational cost without physical gains.

- States the time can be split into a spin-up period which is when the flow develops and loses dependence on initial conditions, eg it has changed enough to no longer be affected by how the field was at the beginning. Secondly there is the averaging period where the simulation collects data for calculating mean velocities and turbulence statistics.

- Recommends that there have been at least 5 flow through times, which corresponds to the length of the domain divided by the mean inlet velocity at the domain height

$T_"ft" = L_d/U_delta$

- They also recommend averaging over 10 minute intervals

- They recommend established benchmark cases and comparing simulations against wind tunnel measurements. This project does not have this opertunity but can test against the results of the scintillometer.

- For the reporting  they recommend to make use of LES detailed results. They mention reporting:

  - Mean wind velocity
  - Velocity turbulent fluctuations
  - Turbulent kinetic energy
  - Higher-order turbulence statistics where relevant.

- Storing a complete time history of every velocity component is an enormous amount of storage. Instead store running sums of the powers of the instantaneous wind velocity components.

#drafting.inline-note("figure out what exactly this means")

- The paper provides benchmark cases which provide cases which comply with the guidelines in the article and have been verified with windtunnel data.

