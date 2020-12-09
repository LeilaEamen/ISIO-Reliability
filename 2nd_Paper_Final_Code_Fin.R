#This is a code to test the temporal transferability (or predictive power) of Inter-Regional Supply-side Input-Output (ISIO) models
#for the Saskatchewan River Basin in Canada under changing climatic conditions, and to study the structural changes in 
#the economy of this river basin by analyzing the technical coefficients of the conventional (or Leontief) Input-Output (IO) models.
#*********************************************************************************************************************************
#The code is developed by Leila Eamen. Contact: leila.eamen@usask.ca
#*********************************************************************************************************************************
#For the methodology and theoretical information on developing ISIO models and conventiona IO models please see:
#Eamen, L., Brouwer, R., & Razavi, S. (2020). The Economic Impacts of Water Supply Restrictions due to Climate 
#and Policy Change: A Transboundary River Basin Supply-side Input-Output Analysis. Ecological Economics, (172), 106532.
#https://doi.org/10.1016/j.ecolecon.2019.106532
#*********************************************************************************************************************************

#For developing the ISIO and IO models the following data are required to be downloaded from the provided links:

#Download Supply "V" and Use "U" tables from the Statistics Canada website for Alberta (AB), 
#Saskatchewan (SK), and Manitoba (MB) for the year that you want to make the model for, in csv format from the link below:
#Statistics Canada. (2019). Catalogue 15-602-X. Supply and Use Tables, Summary Level. Ottawa, Canada.
#https://www150.statcan.gc.ca/n1/pub/15-602-x/15-602-x2017001-eng.htm.

#Download the labor force coefficients for the major regions in each province: 
#The major regions are: North Saskatchewan in Alberta (AB-NSRB), South Saskatchewan in Alberta (AB-SSRB), 
#North Saskatchewan in Saskatchewan (SK-NSRB), South Saskatchewan in Saskatchewan (SK-SSRB),
#Saskatchewan River in Saskatchewan (SK-SRB), and  Saskatchewan River in Manitoba (MB-SRB), in csv format:

#The labor force data is downloaded from the link below:
#Statistics Canada. (2017). Catalogue 98-316-X2016001. 2016 Census of Population. Ottawa, Canada.
#https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/prof/details/download-telecharger/comp/page_dl-tc.cfm?Lang=E.

#Download the Inter Sub-basin Trade Flow from the Statistics Canada website, in csv format from the link below:
#Statistics Canada. (2018a). Table 36-10-0455-01: Experimental domestic trade flow estimates within 
#and between greater economic regions. https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3610045501.

#call the required packages: 
#(Note: if the packages are already installed on your system, skip the first line below:
install.packages(c("Mass","Matrix","Metrics"))
library(MASS)
library(Matrix)
library(Metrics)

#Read Supply and Use tables of the entire Saskatchewan River Basin:
U<- read.csv("U.csv", header = F, sep = ",")
U<- data.matrix(U, rownames.force = NA)
V<- read.csv("V.csv", header = F, sep = ",")
V<- data.matrix(V, rownames.force = NA)

#Calculate the total industry output or the column sums of the supply table:
V_ColSum<- colSums(V)
V_ColSum<- data.matrix(V_ColSum, rownames.force = NA)

#Calculate the total commodity output or the row sums of the supply table:
V_RowSum<- rowSums(V)
V_RowSum<- data.matrix(V_RowSum, rownames.force = NA)

#*******************************************************************************************************************
#Economic Structural Changes Analysis:
#Developing the Inter-Regional Input-Output (IRIO) Model Calculations at the river basin scale:
#*******************************************************************************************************************
#Note: this is a conventional (or Leontief) IO model
#Calculate Leontief Technical coefficients for structural changes analysis:
#Read commodity product from the downloaded supply tables:
Q<- read.csv("Q1.csv", header = F, sep = ",")
#Q<- data.matrix(Q, rownames.force = NA)


D<- t(V) %*% ginv(diag(Q[,1]))
#D<- data.matrix(D, rownames.force = NA)
T<- U %*% ginv(diag(V_ColSum[,1]))
#T<- data.matrix(T, rownames.force = NA)
DT<- D %*% T

#Calculate the Leontief Inverse:
I_Mtx<- diag(1,nrow = 297, ncol = 297)
LeonInv<- solve(I_Mtx - DT)

#The elements of "DT" are technical coefficients that are compared to study the structural changes 
#in the economy between two years.

#*******************************************************************************************************************
#The Inter-Regional Supply-side Input-Output (ISIO) Model Calculations at the river basin scale:
#*******************************************************************************************************************
C<- V %*% ginv(diag(V_ColSum[,1]))
H<- ginv(diag(V_RowSum[,1])) %*% U

#Read the Value-added from the downloaded supply and use tables, in csv format:
VA<- read.csv("VA.csv", header = F, sep = ",")
VA<- data.matrix(VA, rownames.force = NA)

#Calculate the Ghosh Inverse:
HtC<- t(H) %*% C
I_Mtx<- diag(1,nrow = 297, ncol = 297)
GhoshInv<- solve(I_Mtx - HtC)

#Calculate the Output:
Output<- (GhoshInv) %*% VA[,1]

#*******************************************************************************************************************
#Including Water in the ISIO model:
#*******************************************************************************************************************
#Read the water use data in the model's base year (y1) downloaded from the Statistics Canada website, in csv format from the below link:
#Statistics Canada. (2018b). Table 38-10-0250-01: Physical flow account for water use. 
#https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3810025001.

Water_y1<- read.csv("Raw_Water_y1.csv", header = F, sep = ",")

#Calculate the water productivity in monetary unit:
Prod<- V_ColSum[,1]/Water_y1[,1]
Prod<- data.matrix(Prod, rownames.force = NA)
Prod[is.nan(Prod)]<-0
Productivity<- ifelse(Prod == Inf, 0, Prod)

#*******************************************************************************************************************
#Test the temporal transferability of the ISIO models under different climates:
#*******************************************************************************************************************
#Read the water use data in other years downloaded from the Statistics Canada website, in csv format from the below link:
#Statistics Canada. (2018b). Table 38-10-0250-01: Physical flow account for water use. 
#https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3810025001.
Water_Data<- read.csv("Water_Data.csv", sep = ",")
Water_Data<- data.matrix(Water_Data, rownames.force = NA)

#Calculate changes between the  water supply of the model's base year and other years: 
#for example: for the ISIO model of year1 (y1), the water use data for the year 2 (y2) can be applied to test 
#the temporal transferability of this model under the climatic conditions of the year 2)
#Note: There are 4 years considered here from which one year is the model's base year (y1):
Delta_Water<-  matrix(0, nrow = 297, ncol = 3)
Delta<- Matrix(0, nrow = 297, ncol = 3)
for (i in 1:3) 
  {Delta[,i]<- Water_y1[,1] - Water_Data[,i]
   Delta_Water[,i]<- Delta[,i]
  }

#Predict the output for the year other than the model's base year: 
Delta_Value_W<- matrix(0, nrow = 297, ncol = 3)
Output_Predict<- matrix(0, nrow = 297, ncol = 3)
for (i in 1:3) 
  {Delta_Value_W[,i]<- Productivity[,1] * Delta_Water[,i]
}

Delta_O<- matrix(0, nrow = 297, ncol = 3)
Output_Prd<- matrix(0, nrow = 297, ncol = 3)
Output_Predict<- matrix(0, nrow = 297, ncol = 3)

for (i in 1:3) 
  {Delta_O[,i]<- (GhoshInv) %*% Delta_Value_W[,i]
   Output_Prd[,i]<- Delta_O[,i] + Output[,1]
   Output_Predict[,i]<- Output_Prd[,i]
  }

#Calculate the prediction errors:
#Read the observed output for the years other than the model's base year:
#Note: the output for each year is resulted from developing the ISIO model for that year through the above lines of this code. 
Observed_Output<- read.csv("Observed_Output.csv", sep = ",")
Observed_Output<- data.matrix(Observed_Output, rownames.force = NA)

Predict_Error<- matrix(0, nrow = 297, ncol = 3)
for (i in 1:3) 
  {Predict_Error[,i]<- 100 * (Observed_Output[,i] - Output_Predict[,i])/Observed_Output[,i]
   }
write.table(Predict_Error, file = "Predict_Error.csv", sep = ",", row.names = F)
#*******************************************************************************************************************
### End of the code.
#*******************************************************************************************************************
