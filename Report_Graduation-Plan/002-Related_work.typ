= Related work

There are various studies and research papers focused on the topic of urban wind simulation and specifically on wake analysis. Repeating the methods presented in these studies is not the goal of this project. Instead, the aim is to evaluate existing methods, identify their limitations, and find elements that can be adapted for the project. This chapter will present the most relevant studies for the project.

== Computational Fluid Dynamics for urban physics

This paper is not focused directly on the topic of wake analysis, but it provides good guidelines for the general case of urban wind simulations @BLOCKEN2015219. 

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
- This paper is similar to the @BLOCKEN2015219 paper, but goes more into detail about some aspects.

- Firstly, it states that