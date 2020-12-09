# ISIO-Reliability
Testing the Reliability of ISIO Models by Leila Eamen (leila.eamen@usask.ca)

Introduction:
--------------
This is a code to test the temporal transferability (or reliability) of Inter-Regional Supply-side Input-Output (ISIO) models
developed for the Saskatchewan River Basin in Canada under changing climatic conditions, and to study the structural changes in 
the economy of this river basin by analyzing the technical coefficients of the conventional (or Leontief) Input-Output (IO) models.

The code is written in R version 4.0.3.
Required R packages: 
"Mass","Matrix","Metrics"

*********************************************************************************************************************************
*********************************************************************************************************************************
Methodology:
--------------
For the methodology and theoretical information on developing ISIO models and conventiona IO models please see:
Eamen, L., Brouwer, R., & Razavi, S. (2020). The Economic Impacts of Water Supply Restrictions due to Climate  
and Policy Change: A Transboundary River Basin Supply-side Input-Output Analysis. Ecological Economics, (172), 106532.
doi:10.1016/j.ecolecon.2019.106532

*********************************************************************************************************************************
Data:
--------------
For developing the ISIO and IO models the following data are required to be downloaded from the provided links:

1- Download Supply "V" and Use "U" tables from the Statistics Canada website for Alberta (AB), 
Saskatchewan (SK), and Manitoba (MB) for the year that you want to make the model for, in csv format from the link below:
Statistics Canada. (2019). Catalogue 15-602-X. Supply and Use Tables, Summary Level. Ottawa, Canada.
https://www150.statcan.gc.ca/n1/pub/15-602-x/15-602-x2017001-eng.htm.

2- Download the labor force coefficients for the major regions in each province: 
The major regions are: North Saskatchewan in Alberta (AB-NSRB), South Saskatchewan in Alberta (AB-SSRB), 
North Saskatchewan in Saskatchewan (SK-NSRB), South Saskatchewan in Saskatchewan (SK-SSRB),
Saskatchewan River in Saskatchewan (SK-SRB), and  Saskatchewan River in Manitoba (MB-SRB), in csv format:

3- The labor force data is downloaded from the link below:
Statistics Canada. (2017). Catalogue 98-316-X2016001. 2016 Census of Population. Ottawa, Canada.
https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/prof/details/download-telecharger/comp/page_dl-tc.cfm?Lang=E.

4- Download the Inter Sub-basin Trade Flow from the Statistics Canada website, in csv format from the link below:
Statistics Canada. (2018a). Table 36-10-0455-01: Experimental domestic trade flow estimates within 
and between greater economic regions. https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3610045501.

5- Download the water use data from the Statistics Canada website, in csv format from the below link:
Statistics Canada. (2018b). Table 38-10-0250-01: Physical flow account for water use. 
https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3810025001.

*********************************************************************************************************************************
