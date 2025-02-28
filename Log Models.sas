/**Proc corr gives us a correlation matrix**/

libname Final '~/DSC 531 final project';
proc corr data=final.regmodel_median;
	var Cohort
GrantAvg
PellRate
LoanAvg
InStateT
OutStateT
roomamt
boardamt
AvgSalary
control
hloffer
locale
instcat
c21enprf
Housing
board
;
with over_median;
run;

/**HPGENSELECT defaults to selection based on significance level
I cannot remember how to change it to AIC**/

proc hpgenselect data=final.regmodel_median;
	class control--c21enprf;
	model over_median(event='1') = cohort grantrate--instatef control hloffer--c21enprf / dist=binomial;
run;


proc hpgenselect data=final.regmodel_median;
	class control--c21enprf;
	model over_median(event='1') = cohort grantrate--instatef control hloffer--c21enprf / dist=binomial;
	selection method=stepwise(choose=aic slentry=0.10 slstay=0.10 );
ods select selectionsummary parameterestimates;
run;
