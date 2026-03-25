## SDM_Acacia_mangium ##
This repository contains the code and the occurrence data used to model the spatial distribution of Acacia mangium under:
- current climate
- future climatic conditions as modelled by BCC-CSM2-MR for the SSP +5-8.5 W/m² scenario between 2061 and 2080
- future climatic conditions as modelled by BCC-CSM2-MR for the SSP +5-8.5 W/m² scenario between 2081-2100

To extend the implication of our analysis through space and time and considering the worst-case scenario in a conservative approach, we modelled the potential geographical distribution of A. mangium according to the current and future climatic scenarios in the R environment. Precisely, we used the ENMeval (v2.0.5; Muscarella et al., 2014) and MaxEnt (v0.1.4; Phillips et al., 2017) R packages to model the spatial distribution of _A. mangium_ through MaxEnt (Phillips et al., 2006). To collect information on the occurrence of the species, we downloaded data on its presence from the GBIF database (GBIF.org, 2025) in July 2025.  

Climate variables were downloaded from [WorldClim](https://www.worldclim.org/), WorldClim v2.1 database (Fick & Hijmans, 2017).
For the current modelling, we used bioclimatic variables at a 2.5 min spatial resolution, averaging the variable values from 1970 to 2000. 
Before running the model, we selected the bioclimatic variables not correlated with each other (Pearson correlation < ±0.3), resulting in a set of 5 parameters:  annual mean temperature (°C), mean diurnal range of temperature (°C), isothermality (%; deriving from the ratio between mean diurnal range and temperature annual range), annual precipitation (mm), and precipitation seasonality (as coefficient of variation).
To develop the model, we implemented a linear-quadratic feature class, a regularisation multiplier of 1, and a 4-fold spatial block method, as suggested for studies considering native and invaded areas and their modifications over time (Muscarella et al., 2014; Wenger & Olden, 2012). 

To model future projections, we retained data on precipitation and temperature at a 2.5-minute spatial resolution (∼4 km) from the WorldClim v 2.1 database (Fick & Hijmans, 2017). Specifically, we projected the suitable area for _A. mangium_ for the years 2041-2060 and 2081-2100 under the fifth Shared Socioeconomic Pathway (SSP5) scenario of radiative forcing equal to 8.5 W/m² (i.e., 3.3 to 5.7°C of increased warming, also referred to as SSP5-8.5W/m²), referred to as “high-emission and fossil fuel driven" pathway (Zhou et al., 2023). Data for the scenario were derived from the BCC-CSM2-MR model (Wu et al., 2019), which is part of the Coupled Model Intercomparison Project Phase 6 (Eyring et al., 2016; Wu et al., 2019), a world research program whose output was considered by the IPCC for future climatic projections in its sixth assessment report (IPCC, 2023).

# References
- Eyring, V., Bony, S., Meehl, G. A., Senior, C. A., Stevens, B., Stouffer, R. J., & Taylor, K. E. (2016). Overview of the Coupled Model Intercomparison Project Phase 6 (CMIP6) experimental design and organization. Geoscientific Model Development, 9(5), 1937–1958. https://doi.org/10.5194/gmd-9-1937-2016 
- Fick, S. E., & Hijmans, R. J. (2017). WorldClim 2: New 1-km spatial resolution climate surfaces for global land areas. International Journal of Climatology, 37(12), 4302–4315. https://doi.org/10.1002/joc.5086 
- GBIF.org. (2025). GBIF Occurrence Download [Dataset]. https://doi.org/10.15468/dl.gzx6mu 
- IPCC. (2023). Summary for Policymakers. In Climate Change 2023: Synthesis Report. Contribution of Working Groups I, II and III to the Sixth Assessment Report of the Intergovernmental Panel on Climate Change [Core Writing Team, H. Lee and J. Romero (eds.)] (pp. 1–34). IPCC, Geneva, Switzerland. https://doi.org/10.59327/IPCC/AR6-9789291691647.001 
- Muscarella, R., Galante, P. J., Soley-Guardia, M., Boria, R. A., Kass, J. M., Uriarte, M., & Anderson, R. P. (2014). ENMeval: An R package for conducting spatially independent evaluations and estimating optimal model complexity for Maxent ecological niche models. Methods in Ecology and Evolution, 5(11), 1198–1205. https://doi.org/10.1111/2041-210X.12261 
- Phillips, S. J., Anderson, R. P., Dudík, M., Schapire, R. E., & Blair, M. E. (2017). Opening the black box: An open-source release of Maxent. Ecography, 40(7), 887–893. https://doi.org/10.1111/ecog.03049 
- Phillips, S. J., Anderson, R. P., & Schapire, R. E. (2006). Maximum entropy modeling of species geographic distributions. Ecological Modelling, 190(3), 231–259. https://doi.org/10.1016/j.ecolmodel.2005.03.026 
- Phillips, S. J., & Dudík, M. (2008). Modeling of species distributions with Maxent: New extensions and a comprehensive evaluation. Ecography, 31(2), 161–175. https://doi.org/10.1111/j.0906-7590.2008.5203.x 
- Wenger, S. J., & Olden, J. D. (2012). Assessing transferability of ecological models: An underappreciated aspect of statistical validation. Methods in Ecology and Evolution, 3(2), 260–267. https://doi.org/10.1111/j.2041-210X.2011.00170.x 
- Wu, T., Lu, Y., Fang, Y., Xin, X., Li, L., Li, W., Jie, W., Zhang, J., Liu, Y., Zhang, L., Zhang, F., Zhang, Yanwu, Wu, F., Li, J., Chu, M., Wang, Z., Shi, X., Liu, Xiangwen, Wei, M., … Liu, X. (2019). The Beijing Climate Center Climate System Model (BCC-CSM): The main progress from CMIP5 to CMIP6. Geoscientific Model Development, 12(4), 1573–1600. https://doi.org/10.5194/gmd-12-1573-2019 
- Zhou, Z., Zhang, L., Chen, J., She, D., Wang, G., Zhang, Q., Xia, J., & Zhang, Y. (2023). Projecting Global Drought Risk Under Various SSP-RCP Scenarios. Earth’s Future, 11(5), e2022EF003420. https://doi.org/10.1029/2022EF003420 

 
