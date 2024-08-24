/*TASK 1*/
/* Step 1: Import the Dataset */
PROC IMPORT DATAFILE='/home/u63920390/sasuser.v94/DBEREL01.20240814133622.csv'
    OUT=work.mydata
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

/* Step 2: Explore the Dataset Structure */
/* Display the structure of the dataset */
PROC CONTENTS DATA=work.mydata;
RUN;

/* Print the first 10 observations */
PROC PRINT DATA=work.mydata (OBS=10);
RUN;

/* Step 3: Descriptive Statistics for Numerical Variables */
DATA work.mydata;
    SET work.mydata;
    /* Example: Convert VALUE to numeric if it was imported as text */
    VALUE_num = INPUT(VALUE, 8.); 
RUN;

PROC MEANS DATA=work.mydata N MEAN MEDIAN STDDEV MIN MAX;
    VAR VALUE_num; /* Use the actual numeric variable name */
RUN;

/* Step 4: Frequency Tables for Categorical Variables */
PROC FREQ DATA=work.mydata;
    TABLES STATISTIC "Statistic Label"N "Type of Dwelling"N "Energy Rating"N; 
RUN;

/* Step 5: Histogram for a Numerical Variable */
PROC SGPLOT DATA=work.mydata;
    HISTOGRAM VALUE_num; /* Replace with the actual numeric variable name */
    TITLE "Distribution of VALUE_num";
RUN;
proc odstext;
options nodate nonumber; 
ods escapechar='^';
p "The histogram of "VALUE_num" suggests a roughly normal distribution, centered around 6000 with values ranging from 4000 to 8000. The distribution appears symmetrical, indicating that the mean, median, and mode are likely close. Most observations cluster near the center, with fewer data points in the tails. There are no obvious outliers, and the data is concentrated in the middle bins." /
style=[font_size= 11pt fontweight=bold  ];
/* Step 6: Bar Chart for a Categorical Variable */
PROC SGPLOT DATA=work.mydata;
    VBAR "Type of Dwelling"N; /* Replace with the actual categorical variable name */
    TITLE "Frequency of Type of Dwelling";
RUN;
proc odstext;
options nodate nonumber; 
ods escapechar='^';
p "The bar chart titled "Frequency of Type of Dwelling" shows that all dwelling types (Apartment, Detached house, End of terrace house, Mid-terrace house, Semi-detached house) have an identical frequency of 50. The equal height of the bars indicates an even distribution of these dwelling types within the area or population studied, with no single dwelling type being more common than others. This suggests a balanced representation of all dwelling types in the dataset." /
style=[font_size= 11pt fontweight=bold  ];
run;
/* Step 7: Scatter Plot Between Two Numerical Variables */
PROC SGPLOT DATA=work.mydata;
    SCATTER X=VALUE_num Y=Year; /* Use actual numeric variable names */
    TITLE "Scatter Plot of VALUE_num vs. Year";
RUN;
proc odstext;
options nodate nonumber; 
ods escapechar='^';
p "The scatter plot of "VALUE_num" versus "Year" (2015-2023) shows a range of values from 4000 to 8000 without a clear trend over time. The data points are scattered, indicating no strong linear relationship between VALUE_num and Year. While some years show clustering within certain VALUE_num ranges, this is not consistent. A few outliers are present, suggesting unusual observations. Overall, there appears to be no strong correlation between the variables, and further analysis may be needed to explore any underlying patterns." /
style=[font_size= 11pt fontweight=bold  ];
run;
/* Step 8: Cross-Tabulation Between Categorical Variables */
PROC FREQ DATA=work.mydata;
    TABLES "Type of Dwelling"N*"Energy Rating"N / CHISQ;
    TITLE "Cross-tabulation of Type of Dwelling by Energy Rating";
RUN;

/* Step 9: Summary Statistics Grouped by a Categorical Variable */
PROC MEANS DATA=work.mydata N MEAN STDDEV MIN MAX;
    CLASS "Type of Dwelling"N; /* Replace with the actual categorical variable name */
    VAR VALUE_num; /* Replace with the actual numeric variable name */
    TITLE "Summary Statistics of VALUE_num by Type of Dwelling";
RUN;

run;
/*TASK 2*/
/* Step 1: Import the Dataset */
PROC IMPORT DATAFILE='/home/u63920390/my_shared_file_links/u63819461/datasets/universities.csv'
    OUT=work.university
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

/* Step 2: Print the first 5 observations and the first 5 variables */
PROC PRINT DATA=work.university (OBS=5);
    VAR _ALL_;
RUN;

/* Step 3: Display variable names, formats, sorted in creation order */
PROC CONTENTS DATA=work.university ORDER=VARNUM;
RUN;

/* Step 4: Find the mean, standard deviation, minimum, and maximum of the variable student/staff ratio */
PROC MEANS DATA=work.university N MEAN STD MIN MAX;
    VAR student_staff_ratio;
    FORMAT student_staff_ratio 8.2;
RUN;

/* Step 5: Univariate analysis of the variable number of students */
PROC UNIVARIATE DATA=work.university;
    VAR num_students;
    HISTOGRAM num_students / NORMAL;
    INSET MEAN STDDEV MEDIAN MIN MAX / POSITION=NE;
RUN;
proc odstext;
options nodate nonumber; 
ods escapechar='^';
p "The histogram shows a bell-shaped distribution of num_students, centered around 25,000. The data spans from 0 to 120,000, with most observations clustered near the center. The overlaid normal curve suggests the data closely follows a normal distribution, with a mean (Mu) of 24,505 and a standard deviation (Sigma) of 14,091. The distribution is symmetrical, indicating that the data is evenly spread around the mean, with fewer observations as you move away from the center." /
style=[font_size= 11pt fontweight=bold  ];
run;
/* Step 6: Quantify correlations between score, awards, publications, and teaching */
PROC CORR DATA=work.university PLOTS(MAXPOINTS=10000)=MATRIX(HISTOGRAM);
    VAR score award pub teaching;
RUN;


/* Step 7: Hypothesis test between mean number of students in USA and UK universities */
PROC TTEST DATA=work.university ALPHA=0.01;
    CLASS country;
    VAR num_students;
    WHERE country IN ("USA", "United Kingdom");
RUN;
proc odstext;
options nodate nonumber; 
ods escapechar='^';
p "The Q-Q plots indicate that the distribution of num_students is not normal for both the USA and the UK. The USA shows a stronger right skew with more pronounced deviations from normality, while the UK’s deviations are less severe. Histograms, kernel density plots, and box plots reveal that both countries have right-skewed distributions, with the USA having a higher median and greater variation in student numbers. The USA also shows more outliers with exceptionally high student counts compared to the UK. Overall, both countries have a larger proportion of smaller institutions, but the USA has a wider spread and higher median student numbers." /
style=[font_size= 11pt fontweight=bold  ];
run;
/* Step 8: Create a subset of universities from UK, Germany, and Italy */
DATA work.uni1;
    SET work.university;
    WHERE country IN ("United Kingdom", "Germany", "Italy");
RUN;

/* Step 9: Print only the observations from 10 to 17 and the first 5 variables */
PROC PRINT DATA=work.uni1 (FIRSTOBS=10 OBS=17);
    VAR _ALL_;
RUN;

/* Step 10: Find the mean quality of education for the uni1 dataset and for a subset with quality > 100 */
PROC MEANS DATA=work.uni1 MEAN;
    VAR quality_of_education;
RUN;

DATA work.uni1_quality_gt_100;
    SET work.uni1;
    WHERE quality_of_education > 100;
RUN;

PROC MEANS DATA=work.uni1_quality_gt_100 MEAN;
    VAR quality_of_education;
RUN;

/* Step 11: Summary statistics for the patents variable, grouped by country */
PROC MEANS DATA=work.uni1 N MEAN STD MIN MAX;
    CLASS country;
    VAR patents;
RUN;

/* Step 12: Plot of publications by country with 3 histograms sharing the same x-axis */
PROC SGPANEL DATA=work.uni1;
    PANELBY country / LAYOUT=ROWLATTICE;
    HISTOGRAM pub;
RUN;
proc odstext;
options nodate nonumber; 
ods escapechar='^';
p "The histograms depict varying distributions of "pub" values by country. Germany shows a relatively uniform distribution, indicating consistent pub values. Italy's distribution is right-skewed, with a higher concentration of lower values. The United Kingdom has a bimodal distribution, suggesting two distinct clusters of pub values. The UK also exhibits the widest spread, while Germany has the narrowest. These differences highlight distinct patterns in pub values across the three countries." /
style=[font_size= 11pt fontweight=bold  ];
run;
/*TASK 3*/
/*
 *
 * Task code generated by SAS Studio 3.8 
 *
 * Generated on '8/14/24, 6:10 PM' 
 * Generated by 'u63920390' 
 * Generated on server 'ODAWS01-EUW1.ODA.SAS.COM' 
 * Generated on SAS platform 'Linux LIN X64 5.14.0-284.30.1.el9_2.x86_64' 
 * Generated on SAS version '9.04.01M7P08062020' 
 * Generated on browser 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36' 
 * Generated on web client 'https://odamid-euw1.oda.sas.com/SASStudio/main?locale=en_US&zone=GMT%252B01%253A00&ticket=ST-85676-exoPWHQnKo1u4cvCVYuI-cas' 
 *
 */

ods noproctitle;
ods graphics / imagemap=on;

proc timeseries data=WORK.UNIVERSITY plots=(series corr);
	var year / transform=none dif=0;
	crossvar score / transform=none dif=0;
	crossvar research / transform=none dif=0;
	crossvar award / transform=none dif=0;
	crossvar world_rank / transform=none dif=0;
	crossvar num_students / transform=none dif=0;
run;
proc odstext;
options nodate nonumber; 
ods escapechar='^';
p "The scatter plot shows Series Values distributed across the years 2012 to 2015, with no clear trend or strong linear relationship between the variables. Data points are scattered, with some clustering in specific year ranges but without consistency. A few outliers are present, indicating unusual observations. Overall, the plot suggests no strong correlation between Series Values and year, and further analysis might be needed to explore any underlying patterns.
The ACF and PACF plots reveal significant spikes at certain lags, indicating potential autocorrelation in the time series data, which suggests that past values may influence future values. The IACF plot, although less commonly used, also shows some structure, supporting the presence of autocorrelation. The White Noise Probability plot indicates that the series is unlikely to be white noise, as p-values are below the significance level, suggesting the data has an underlying structure rather than being purely random. This analysis hints at the need for a more sophisticated time series model, such as AR, MA, or ARIMA, to capture the patterns in the data." /
style=[font_size= 11pt fontweight=bold  ];
run;