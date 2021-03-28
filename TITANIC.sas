/**/
/*Create a table to combine train data and test data*/

DATA TITANIC;
	SET TITANIC.TITANIC_TRAIN  /*Titanic training dataset - 891 observations*/
		TITANIC.TITANIC_TEST;	/*Titanic test dataset - 418 observations*/
RUN;

/*Print out the combined data set*/
PROC PRINT DATA = TITANIC;
RUN;

/*Convert Sex from male/female to a binary variable 1/0 */
DATA TITANIC;
	SET TITANIC;
	IF Sex = 'male' THEN Gender = 1;
	ELSE IF Sex = 'female' THEN Gender = 0;
	ELSE Gender = '.';
DROP Sex;
RUN;

/*Create child variable by defining the observations with age <=13 as a child */
DATA TITANIC;
	SET TITANIC;
	IF Age <= 13 THEN Child = 1;
	ELSE  Child = 0;
RUN;

/*Get number of missing values using NMISS*/
PROC MEANS DATA = TITANIC NMISS N MEAN MEDIAN MAX MIN;
	TITLE  "Titanic data";
RUN;

/*Show the number of survivors and percentage*/
PROC FREQ DATA = TITANIC;
	TABLES survived / PLOTS=freqplot;
RUN;

/*Distribution of age variable*/
PROC UNIVARIATE DATA = TITANIC PLOT NORMAL;
	VAR age;
RUN;

/*Show the number and percentage of child survivors compared to adults using a mosaicplot*/
PROC FREQ DATA = TITANIC;
	TABLES child*survived / PLOTS= mosaicplot;
RUN;

/*Show the number and percentage of survivors by gender and survivors by age*/
PROC FREQ DATA=TITANIC;
	TABLE survived*gender survived*age / PLOTS = freqplot(twoway = stacked);
RUN;

/*The plot for age was difficult to read as it is not binned.*/
/*To solve the problem, proc sgpanel is used to display a histogram with age bined into 12 bins*/
PROC SGPANEL DATA = TITANIC;
	PANELBY survived;
	HISTOGRAM age / GROUP = Gender Scales = count nbins=12;
RUN;





