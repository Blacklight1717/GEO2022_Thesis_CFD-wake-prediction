#import "@preview/drafting:0.2.2"
= Related work

There are various studies and research papers focused on the topic of urban wind simulation and specifically on wake analysis. Repeating the methods presented in these studies is not the goal of this project. Instead, the aim is to evaluate existing methods, identify their limitations, and find elements that can be adapted for the project. This chapter will present the most relevant studies for the project.

== Method comparisons

As described in @Blocken2015, there exist two main methods to model the flow in urban environments. These are Reynolds-averaged Navier-Stokes (RANS) and Large eddy simulation (LES). 

RANS functions as a time averaged model of the flow within a specified grid. A method called unsteady RANS or URANS, does allow flow to develop over time. However, according to @Blocken2015, URANS can capture the turbulent behavior, but the turbulence remains modelled instead of directly solved. Therefore, this section will not evaluate the performance of URANS, as LES is determined to be better suited for this purpose @Blocken2015. The LES method directly resolves large eddies, these are rotating pockets of air (vortices), where the flow diverges from the steady flow direction. Unlike RANS, LES does not rely on time-averaging of the flow field, thus can represent the flow more accurately than RANS according to @Blocken2015. A third hybrid method called a Detached eddy simulation (DES). It is a hybrid between LES and RANS, which strikes a balance between the accuracy of LES and the computational efficiency of RANS by using RANS at the walls and an approximation of LES in turbulent regions.

This subchapter goes over several papers that discuss these three methods to help determine which method is most suitable to model the conditions measured at the Aerospace building.

=== Comparing LES to RANS
As stated in the introduction, the two main methods of modelling the urban flow are considered to be LES and RANS. Therefore, it is important to determine whether either or both of these methods are suitable for the use case. It is for this purpose that @Blocken2018 has written a paper that compares and contrasts the two methods. The main topic for this paper is to determine why LES, due to its generally more results, has not yet replaced RANS. 

The general consensus between papers is that LES is superior when it comes to solving turbulent structures, which notably does not imply all structures. LES does not simulate all eddies, but focuses on larger turbulent structures using a filtering method @Blocken2018. Since the objective of this project is to analyse the turbulent wake that develops around the Aerospace building and in particular the rooftop instruments, the accurate representation of large turbulent structures is particularly important. However, LES is not automatically more reliable compared to RANS. The method is more sensitive to the case design decisions such as inlet conditions and the mesh refinement. RANS on the other hand is far less computationally demanding @Liu2016. Furthermore, it is said to have sufficient accuracy for other use cases such as pedestrian comfort and pollution dispersion analysis. 

In conclusion, it is possible to run multiple simulations of varying geometries and conditions for the same computational cost as LES, while sacrificing the accuracy of reconstruction of large turbulent regions. 
These observations suggest that a method which combines the two methods (such as DES), or uses RANS for course and itterative simulations and LES for a more detailed evaluation, could be beneficial for this project.

#drafting.inline-note("Use to support choice to do 'cheap' RANS for 360 degree look and using more accurate LES for evaluating in cases that require closer evaluation.")

=== Comprehensive LES, DES, RANS comparison.
Within the main three categories of CFD solvers, there exist variants and improvements upon the standard versions. For this literature review, three papers were chosen which compare the methods against existing datasets or wind tunnel tests. In the case of this project, the simulations will be compared against measurements from a scintillometer, located on the roof of the TU Delft Aerospace building. It is therefore imperative that the chosen method accurately reconstructs the real-world flow conditions.

The first metric which is evaluated is the reattachment length @Liu2016. This represents the length between the point of separation and the location where it reattaches to the surface. The chosen ground truth of this paper is a wind tunnel test which recreates the effects around a bluff body representing a building. It evaluates both the wake created on top of the building and the one behind the building. The analysis found that the roof experienced a difference of roughly 20% for RANS compared to the wind tunnel test, while difference for LES and DES was comparatively smaller. The wake behind the building however showed that RANS overestimated the reattachment length by 130%, while DES and LES perform similarly at roughly 10% when both use the same cell count @Liu2016. The main stated improvement of DES over LES is that it can achieve comparable accuracy with fewer cells @Liu2016. The paper states that they saw a 20-30% reduction in CPU time, when the amount of cells was reduced by roughly 20% @Liu2016. While these findings are supported by @Shen2025, this paper does state that the reattachment length at the reduced cell count goes from a 10% difference with the wind tunnel case, to a 16% difference in the wake behind the building.

@Shen2025 found that the mean velocity has a similarity of 90% between the DES and LES cases it evaluates. When looking at DES derived methods, the standard DES method performs the worst, followed by DDES. The DDES method shows significant disagreement in the predicted Reynolds stresses, turbulent fluctuations, and resolved structures when compared to LES @Klapwijk2020

IDDES on the other hand performs better compared to DDES @Shen2025, as it more closely matches the Reynolds stresses and turbulent structures. However, it still exhibits underpredictions of several flow statistics compared to LES. Furthermore, it predicts weaker turbulent diffusion compared to LES and has a limited ability to capture high-frequency instabilities and fine-scale turbulence @Shen2025. Significant discrepancies in the lateral velocity correlations are also found in the far wake @Shen2025. 

Lastly, IDDES  exhibits incomplete and weakly defined horseshoe vortices and its side-edge vortices have a tendency to collapse into smaller, disorganized, and partially developed vortical structures. According to @Shen2025 this implies that LES provides a more accurate representation of the vortices when compared to IDDES and the wind tunnel data.

The third evaluated paper does not focus on the urban environment @Klapwijk2020. Instead, it is focused on a turbulent channel flow, which it compares to a DNS test dataset. However, this paper still provides additional context. Methods that perform poorly in this simplified test case may also be expected to have difficulties when applied to more complex urban geometries. The study found that the WALE (Wall-Adapting Local Eddy-viscosity) subgrid-scale model provided good agreement with the DNS reference data in terms of solved turbulent structures and Reynolds stresses. Within the simplified geometry it performs similarly to the @SMAGORINSKY1963 LES method. However, the paper identifies that given more complex geometries, WALE may perform better as it was designed for more complex geometries. The paper deems the LES ILES method to have the best agreement with the DNS data. Furthermore, in agreement with both @Shen2025 and @Liu2016, it finds that the ability of DES methods to represent the large turbulent structures, is generally inferior to those created by LES based models.

#drafting.inline-note("Add some visual examples of these vortex phenomena")

== Best practices

Based on the findings in the previous sections, it is likely that LES and RANS will form the bedrock of this research project. However, the results created by these two simulation methods are only as good as their setup. Therefore, this section will look at the best practices for designing a case for RANS and LES. 

=== Best practices for RANS

The first paper focusses on the best practices for RANS simulations @Blocken2015. The focus of this paper is not directly on the analysis of building wake. Instead it looks at the more general application of RANS on a build enviroment. The paper discusses how CFD is focussed on the microscale such as localized atmospheric flows, such as around buildings, streets and other urban features.

For the urban geometry, it states that varying levels of detail can be used throughout the domain. For example, a more detailed model such as LOD2.2 can be used in the immediate area of the area of interest, while LOD1.2 could be used further away. The less detailed geometries can result in less cells created by the SnappyHexMesh in OpenFOAM, resulting in better performance. This is potentially interesting for the project, as a relatively large area is modeled, while primarily the area of interest should have high detail to best approximate the turbulence.

For the temporal domain, the paper suggests BES for simulations over long periods of time. However, for this project LES should be sufficient, while RANS is averaged and steady, thus does not have a time component. It does state that long term simulations drive up the computational costs, but does not explicitly state how long this period would be or the rate at which the cost increases with time, though this is likely a linear correlation.

The paper goes on to mention that RANS and LES are most well suited for urban situations. This reinforces the other papers within this review which highlight RANS as a capable method for most general cases, whereas LES is computationally more expensive, but better suited for the simulation of turbulence. @Blocken2015 goes on to mention that it is possible to use an approach which uses both RANS and LES. URANS is not recommended, as it approximates the statistics of turbulence as with RANS, but is more computationally expensive than RANS as it is unsteady, thus shows the flow over time. Therefore, it recommends the use of LES over URANS. An URANS-LES hybrid is proposed as a possible solution. However, from the description this appears to be the earlier discussed DES method, which shows reduced capabilities for turbulence simulations. 

A second paper forms the basis for many of the statements in @Blocken2015, but goes into more detail regarding RANS solvers @Franke2004. The paper highlights that there exist various solvers for RANS, with varying levels of complexity and accuracy. The standard k-$epsilon$ model is known as an eddy viscosity model. These models are the most common and have the best performance. There exist linear and non-linear variations of this model. However, due to the Boussinesq approximation, there is a linear relation between the Reynolds stresses and the mean strain rate. In reality, this relation is not always linear. Therefore, methods which use quadratic or cubic relations are better at resolving the anisotropic flows and thus are more realistic @Franke2004. It does make mention of several models attempt to bridge the gap between k-$epsilon$ and LES. However, these models have increased computational loads and not the same level of performance as LES. Therefore, these models will not be considered for this project. Variants of the k-$epsilon$ model include realizable k-$epsilon$
#drafting.inline-note("make a mention of this in methodology and say that the anisotropic flow is less relevant as it is just as an input into LES and to view intial turbulence concentrations")

For the grid mesh, it recommends a high quality grid. According to @Blocken2015, this is required to achieve convergence, as poor convergence can often be traced back to poor quality grids. It states that this is the reason many papers revert to first order solver schemes, as this usually solves the convergence problem, without adressing the lacking quality of the grid. Furthermore, cells should have as little skew as possible, perfect cubes are prefered over elongated diamond shapes as this helps with convergence @Blocken2015. It recommends least 10 cells are recommended to span the distance between buildings. Furthermore, it recommends a grid convergence study, to determine for three grids of varying resolutions whether they converge for each case. This requirement for grid independence is supported by @Franke2004. 


The paper states that convergence is achieved when the residuals of each parameter have been reduced to an order of $10^(-4)$. Furthermore, occilations in the redisual plots are not always an indication of issues with the mesh or setup. They can also represent a converged mesh which shows the turbulent unstable effects found in the flow. However, the paper does not mention how to differentiate between the setup errors and this converged case.
/*


- contains a table with recommended aerodynamic roughness values for various surfaces. Sand grain roughness also needs to be modeled correctly.

- Set appropriate boundary conditions for the domain. Includes formulas to determine conditions

- occilations in the residual can be good as they are caused by turbulence in the flow. This is because the residual is so converged that it starts reflecting the unsteadiness of the turbulent flow. However, can also be poor mesh quality, bad re

- Grid coverage index (GCI) is a method to quantify the uncertainty of the grid. It is based on the Richardson extrapolation and requires three grids with different resolutions. It can be used to determine if the grid is fine enough for the simulation.

- Perform a validation study to compare the results of the simulation with experimental data. This might be difficult for the project. However, the simulations can be compared with the measurements from the instruments on the roof.

- Documentation of the simulation is important, write down everything such that the experiments can be reproduced.
*/
=== Extended RANS criteria
Recommendations on the use of CFD in wind engineering
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

=== Best practices for LES
AIJ guidelines on the applications of large-eddy simulation to pedestrian wind environment

- While @Blocken2015 focuses on guidelines for RANS, this article does the same for LES @Okaze2026.

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

- The paper provides benchmark cases which provide cases which comply with the guidelines in the article and have been verified with wind tunnel data.

== Existing research
=== Effect of LOD level on urban comfort.
*Quantifying the impact of urban geometric detail for urban air mobility risk forecasting*

- The paper compares the effects of LOD1.2 to LOD2.2 which represent the geometric complexity of the building geometry. It states the less complex LOD1.2 geometry has a roughly 20% difference in directionally averaged windspeed compared to the LOD2.2 case. Furthermore, the LOD 2.2 mesh becomes larger due the higher detail to be resolved. Nevertheless, the implementation of LOD 2.2 geometries is important for the receiver and transmitter of the scintillometer setup, as the wind cannot be accurately modelled around a building which itself does not represent reality.

- The paper simulates the flow around geometry at 1 degree intervals. Furthermore, a windrose is constructed which shows the probability of wind directions over a 20 year period. Furthermore, the velocities is plotted onto a histogram which is then used to determine a mean/average windspeed for all simulations. 

- While a 1 degree angle is chosen for this research paper. However, it makes mention of other papers such as @Haagbo2022, which evaluates varying wind direction ranges and compares the wind comfort to that of a 64 directional analysis. This equates to a roughly 5 degree angular resolution. For the application of wind comfort modelling a 10 degree resolution is deemed minimal by this paper.

#drafting.inline-note("For methodology mention that I choose a middleground between the 1 and 10 degree angular resolutions as a tradeoff between computational time and resolution of the analysis.")