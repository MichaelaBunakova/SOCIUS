*Socius concordance data visualization preparation do file 

*latest update: July 14, 2025

*log using "/Users/michaelabunakova/Desktop/prep_log.smcl", replace
use "/Users/michaelabunakova/Desktop/ESS_data.dta"
*this is the full dataset
*to replace the dataset back to original, add ,clear to the above command

cd "/Users/michaelabunakova/Library/CloudStorage/OneDrive-McGillUniversity/PhD Thesis/Manuscript 2 (ESS)"

*putexcel set output_tables, replace 

*The results will be weighted by the variable:pspwght - Post-stratification weight including design weight
*Notes on using survey weights (dweight, pweight, pspwght) if making generalizable claims to produce representative estimates.

*dweight- 	Design weight (Always use in descriptive stats and regression)
*pweight-	Post-stratification weight	(Combine with dweight for within-country analyses)
*pspwght-	Population size weight	(Use for cross-country comparisons)

*generate a new weight that combines design weight and population weight
gen norm_weight= dweight * pspwght
svyset [pw=norm_weight]  
*_______________________________________________________________________*
*YEAR OF SURVEY

generate year=0
replace year=2002 if essround==1
replace year=2004 if essround==2
replace year=2006 if essround==3
replace year=2008 if essround==4
replace year=2010 if essround==5
replace year=2012 if essround==6
replace year=2014 if essround==7
replace year=2016 if essround==8
replace year=2018 if essround==9
replace year=2020 if essround==10
replace year=2023 if essround==11

label variable year "Year of Survey"
tab year essround

*tab2xl year using output_tables, col(1) row(1)

		*Year of |
		*     Survey |      Freq.     Percent        Cum.
		*------------+-----------------------------------
		*       2002 |     42,359        7.98        7.98
		*       2004 |     47,537        8.96       16.94
		*       2006 |     43,000        8.10       25.04
		*       2008 |     56,752       10.69       35.73
		*       2010 |     52,458        9.88       45.62
		*       2012 |     54,673       10.30       55.92
		*       2014 |     40,185        7.57       63.49
		*       2016 |     44,387        8.36       71.86
		*       2018 |     49,519        9.33       81.19
		*       2020 |     59,685       11.25       92.43
		*       2023 |     40,156        7.57      100.00
		*------------+-----------------------------------
		*      Total |    530,711      100.00

*_______________________________________________________________________*
*Country exploration

tab cntry year, m 

*tab2xl cntry year using output_tables, col(1) row (1)

/*
          |                                                      Year of Survey
   Country |      2002       2004       2006       2008       2010       2012       2014       2016       2018       2020       2023 |     Total
-----------+-------------------------------------------------------------------------------------------------------------------------+----------
        AL |         0          0          0          0          0      1,201          0          0          0          0          0 |     1,201 
        AT |     2,257      2,256      2,405          0          0          0      1,795      2,010      2,499      2,003      2,354 |    17,579 
        BE |     1,899      1,778      1,798      1,760      1,704      1,869      1,769      1,766      1,767      1,341      1,594 |    19,045 
        BG |         0          0      1,400      2,230      2,434      2,260          0          0      2,198      2,718          0 |    13,240 
        CH |     2,040      2,141      1,804      1,819      1,506      1,493      1,532      1,525      1,542      1,523      1,384 |    18,309 
        CY |         0          0        995      1,215      1,083      1,116          0          0        781        875        685 |     6,750 
        CZ |     1,360      3,026          0      2,018      2,386      2,009      2,148      2,269      2,398      2,476          0 |    20,090 
        DE |     2,919      2,870      2,916      2,751      3,031      2,958      3,045      2,852      2,358      8,725      2,420 |    36,845 
        DK |     1,506      1,487      1,505      1,610      1,576      1,650      1,502          0      1,572          0          0 |    12,408 
        EE |         0      1,989      1,517      1,661      1,793      2,380      2,051      2,019      1,904      1,542          0 |    16,856 
        ES |     1,729      1,663      1,876      2,576      1,885      1,889      1,925      1,958      1,668      2,283      1,844 |    21,296 
        FI |     2,000      2,022      1,896      2,195      1,878      2,197      2,087      1,925      1,755      1,577      1,563 |    21,095 
        FR |     1,503      1,806      1,986      2,073      1,728      1,968      1,917      2,070      2,010      1,977      1,771 |    20,809 
        GB |     2,052      1,897      2,394      2,352      2,422      2,286      2,264      1,959      2,204      1,149      1,684 |    22,663 
        GR |     2,566      2,406          0      2,072      2,715          0          0          0          0      2,799      2,757 |    15,315 
        HR |         0          0          0      1,484      1,649          0          0          0      1,810      1,592      1,563 |     8,098 
        HU |     1,685      1,498      1,518      1,544      1,561      2,014      1,698      1,614      1,661      1,849      2,118 |    18,760 
        IE |     2,046      2,286      1,800      1,764      2,576      2,628      2,390      2,757      2,216      1,770      2,017 |    24,250 
        IL |     2,499          0          0      2,490      2,294      2,508      2,562      2,557          0      1,308          0 |    16,218 
        IS |         0        579          0          0          0        752          0        880        861        903        842 |     4,817 
        IT |     1,207          0          0          0          0        960          0      2,626      2,745      2,640      2,865 |    13,043 
        LT |         0          0          0          0      1,677      2,109      2,250      2,122      1,835      1,659      1,365 |    13,017 
        LU |     1,552      1,635          0          0          0          0          0          0          0          0          0 |     3,187 
        LV |         0          0          0      1,980          0          0          0          0        918      1,023          0 |     3,921 
        ME |         0          0          0          0          0          0          0          0      1,200      1,278          0 |     2,478 
        MK |         0          0          0          0          0          0          0          0          0      1,429          0 |     1,429 
        NL |     2,364      1,881      1,889      1,778      1,829      1,845      1,919      1,681      1,673      1,470      1,695 |    20,024 
        NO |     2,036      1,760      1,750      1,549      1,548      1,624      1,436      1,545      1,406      1,411      1,337 |    17,402 
        PL |     2,110      1,716      1,721      1,619      1,751      1,898      1,615      1,694      1,500      2,065      1,442 |    19,131 
        PT |     1,511      2,052      2,222      2,367      2,150      2,151      1,265      1,270      1,055      1,838      1,373 |    19,254 
        RO |         0          0          0      2,146          0          0          0          0          0          0          0 |     2,146 
        RS |         0          0          0          0          0          0          0          0      2,043      1,505      1,563 |     5,111 
        RU |         0          0      2,437      2,512      2,595      2,484          0      2,430          0          0          0 |    12,458 
        SE |     1,999      1,948      1,927      1,830      1,497      1,847      1,791      1,551      1,539      2,287      1,230 |    19,446 
        SI |     1,519      1,442      1,476      1,286      1,403      1,257      1,224      1,307      1,318      1,252      1,248 |    14,732 
        SK |         0      1,512      1,766      1,810      1,856      1,847          0          0      1,083      1,418      1,442 |    12,734 
        TR |         0      1,856          0      2,416          0          0          0          0          0          0          0 |     4,272 
        UA |         0      2,031      2,002      1,845      1,931      2,178          0          0          0          0          0 |     9,987 
        XK |         0          0          0          0          0      1,295          0          0          0          0          0 |     1,295 
-----------+-------------------------------------------------------------------------------------------------------------------------+----------
     Total |    42,359     47,537     43,000     56,752     52,458     54,673     40,185     44,387     49,519     59,685     40,156 |   530,711 

*/

*_______________________________________________________________________*
*GENDER RECODING

*biological sex - other gender information not available 
tab gndr, m 
*tab2xl gndr using output_tables, col(20) row(1)

	*     Gender |      Freq.     Percent        Cum.
	*------------+-----------------------------------
	*       Male |    245,314       46.22       46.22
	*     Female |    284,430       53.59       99.82
	*  No answer |        967        0.18      100.00
	*------------+-----------------------------------
	*      Total |    530,711      100.00

	
*survey-weighted tabulation: 

svy: tab gndr

/*
----------------------
   Gender | proportion
----------+-----------
     Male |      .4824
   Female |      .5176
    Total |          1
----------------------
	*/
	
generate gender=0
replace gender=1 if gndr==2
*this way, male are 0 and women are 1- dummy

*_______________________________________________________________________*

*PARTNERSHIP STATUS VARIABLE ACROSS ROUNDS 


*Option 1 (most simple binary marital status specification - includes married and in registered civil union vs. not married/ divorced, separated )

* Generate a new marital status variable with an initial value of 0
gen new_marital_status = 0

* If 'marital' equals 1, or 'martlfr' equals 1, or 'maritala' equals 1 or 2,
* or 'maritalb' equals 1 or 2, or 'marstfi' equals 1 or 2, or 'marstgb' equals 1 or 2,
* or 'marstie' equals 1 or 2, or 'marsts' equals 1 or 2 
*this way, we avoid missing values in main marital status variables due to country specific marital status variables in some rounds of the survey

replace new_marital_status = 1 if marital == 1 | martlfr == 1 | ///
                             maritala == 1 | maritala == 2 | ///
                             maritalb == 1 | maritalb == 2 | ///
                             marstfi == 1 | marstfi == 2 | ///
                             marstgb == 1 | marstgb == 2 | ///
                             marstie == 1 | marstie == 2 | ///
                             marsts == 1 | marsts == 2 
							 
* Check the result
tab new_marital_status, m

* Label the new variable
label variable new_marital_status "Marital Status: 1 = Married/Civil Partnership/Living with partner, 0 = Not Married/Civil Partnership"

* Define and apply labels for the variable
label define marital_status_label 0 "Not Married/Civil Partnership/living with partner" 1 "Married/Civil Partnership/living with partner"
label values new_marital_status marital_status_label
tab new_marital_status

*tab2xl new_marital_status using output_tables, row(1) col(30)

*          Marital Status: 1 = |
* Married/Civil Partnership, 0 |
*          = Not Married/Civil |
*                  Partnership |      Freq.     Percent        Cum.
*------------------------------+-----------------------------------
*Not Married/Civil Partnership |    270,903       51.05       51.05
*    Married/Civil Partnership |    259,808       48.95      100.00
*------------------------------+-----------------------------------
*                        Total |    530,711      100.00

svy: tab new_marital_status

/*
*survey weighted tabulation:


Partnership        | proportion
----------+-----------
 Not Marr 			|      .4996
 Married/		    |      .5004 
    Total			|          1
----------------------


*/

*checking if marital status proportions differ significantly across rounds
/*

  Marital Status: 1 = |
        Married/Civil |
 Partnership, 0 = Not |
        Married/Civil |                                                      Year of Survey
          Partnership |      2002       2004       2006       2008       2010       2012       2014       2016       2018       2020       2023 |     Total
----------------------+-------------------------------------------------------------------------------------------------------------------------+----------
Not Married/Civil Par |    15,777     17,924     17,034     22,085     22,275     21,163     16,278     18,119     20,400     31,601     15,910 |   218,566 
Married/Civil Partner |    21,130     22,973     21,658     26,693     24,100     24,787     18,657     20,278     22,119     15,630     18,202 |   236,227 
----------------------+-------------------------------------------------------------------------------------------------------------------------+----------
                Total |    36,907     40,897     38,692     48,778     46,375     45,950     34,935     38,397     42,519     47,231     34,112 |   454,793 


				*all rounds seem similar except for 2020, in which the proportion of married to not married respondents was different - I wonder what went on with the pandemic sampling
*/				



*need to recode some missing values in marital status that can be filled with other marital status variables 
replace new_marital_status=1 if lvghwa==1
replace new_marital_status=1 if lvgoptn==1
replace new_marital_status=1 if lvgptn==1
replace new_marital_status=1 if lvgptna==1
replace new_marital_status=1 if partner==1
replace new_marital_status=1 if rshpsgb<=3
replace new_marital_status=1 if rshpsfi<=3



				
*OPTION 2 testing another way of defining current partnership

*variables cohabitation: icpart1, icpart2, icpart3, iccohbt

generate co_living=0
replace co_living=1 if icpart1==1
replace co_living=1 if icpart2==1
replace co_living=1 if icpart3==1
replace co_living=1 if icptn==1
replace co_living=1 if iccohbt==1

tab co_living
*  co_living |      Freq.     Percent        Cum.
*------------+-----------------------------------
*          0 |    391,064       73.69       73.69
*          1 |    139,647       26.31      100.00
*------------+-----------------------------------
*      Total |    530,711      100.00

*much lower percentage of those in the sample in the co-living variable, compared to the married variable, which is surprising, since the married var does not include those cohabiting and not in a registered union, while the co-living variable should have captured it (asking whether respondent lives with spouse/partner)
*with the new wave, we have around 100k more baseline survey participants

svy: tab co_living
/*

co_living | proportion
----------+-----------
        0 |      .7296
        1 |      .2704
    Total |          1

*/

*we can also add those co-living to our marital status variable 
replace new_marital_status=1 if co_living==1


*_______________________________________________________________________*

*occupational class of main respondent
generate occupational_class=.

*tab iscoco, m 
*tab isco08, m 
*the ISCO work clasification:

	*1	Managers (e.g., Chief executives, Operations managers)
	*2	Professionals (e.g., Scientists, Engineers, Health professionals, Teachers)
	*3	Technicians and Associate Professionals (e.g., Medical technicians, Legal assistants)
	*4	Clerical Support Workers (e.g., Secretaries, Customer service clerks)
	*5	Service and Sales Workers (e.g., Retail workers, Personal service workers)
	*6	Skilled Agricultural, Forestry, and Fishery Workers (e.g., Farmers, Fishermen)
	*7	Craft and Related Trades Workers (e.g., Electricians, Carpenters, Machinists)
	*8	Plant and Machine Operators and Assemblers (e.g., Truck drivers, Factory workers)
	*9	Elementary Occupations (e.g., Cleaners, Laborers, Street vendors)
	*10	Armed Forces Occupations (e.g., Military personnel)

*armed forces
replace occupational_class=10 if isco08<=999
replace occupational_class=10 if iscoco<=999
	
*managers
replace occupational_class=1 if isco08 >=1000 & isco08 <=1999
replace occupational_class=1 if iscoco >=1000 & iscoco <=1999

*professionals
replace occupational_class=2 if isco08 >=2000 & isco08 <=2999
replace occupational_class=2 if iscoco >=2000 & iscoco <=2999

*technicians and associate profesionals
replace occupational_class=3 if isco08 >=3000 & isco08 <=3999
replace occupational_class=3 if iscoco >=3000 & iscoco <=3999

*clerical support workers
replace occupational_class=4 if isco08 >=4000 & isco08 <=4999
replace occupational_class=4 if iscoco >=4000 & iscoco <=4999

*service and sales workers
replace occupational_class=5 if isco08 >=5000 & isco08 <=5999
replace occupational_class=5 if iscoco >=5000 & iscoco <=5999

*agricultural workers
replace occupational_class=6 if isco08 >=6000 & isco08 <=6999
replace occupational_class=6 if iscoco >=6000 & iscoco <=6999

*craft and trades workers
replace occupational_class=7 if isco08 >=7000 & isco08 <=7999
replace occupational_class=7 if iscoco >=7000 & iscoco <=7999

*machine operators
replace occupational_class=8 if isco08 >=8000 & isco08 <=8340
replace occupational_class=8 if iscoco >=8000 & iscoco <=8340

*elementary occupations
replace occupational_class=9 if isco08 >=9000 & isco08 <=9330
replace occupational_class=9 if iscoco >=9000 & iscoco <=9330

* Assign labels to the variable
label define occ_label 10 "Armed Forces" 1 "Managers" 2 "Professionals" 3 "Technicians and Associate Professionals" 4 "Clerical Support Workers" 5 "Service and Sales Workers" 6 "Agricultural Workers" 7 "Craft and Trades Workers" 8 "Machine Operators" 9 "Elementary Occupations"
label values occupational_class occ_label  // Apply the label to the variable
tab occupational_class



/*
                     occupational_class |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                                      0 |     75,918       14.30       14.30
                               Managers |     37,178        7.01       21.31
                          Professionals |     78,578       14.81       36.12
Technicians and Associate Professionals |     67,602       12.74       48.85
               Clerical Support Workers |     44,615        8.41       57.26
              Service and Sales Workers |     77,596       14.62       71.88
                   Agricultural Workers |     14,396        2.71       74.59
               Craft and Trades Workers |     57,076       10.75       85.35
                      Machine Operators |     34,901        6.58       91.93
                 Elementary Occupations |     42,041        7.92       99.85
                           Armed Forces |        810        0.15      100.00
----------------------------------------+-----------------------------------
                                  Total |    530,711      100.00
								  
*/

*tab2xl occupational_class using output_tables, col(1) row(1)


svy: tab occupational_class, percent


/*
								  
occupational_class | percentage
----------+-----------
        0 |      16.01
 Managers |      6.689
 Professi |      13.42
 Technici |      12.21
 Clerical |      8.131
  Service |       14.9
 Agricult |      2.679
 Craft an |      10.97
  Machine |      6.721
 Elementa |      8.118
 Armed Fo |      .1522
          | 
    Total |        100

								  
*/




*Initially, I removed observations for which we have no value of isco08 or iscoco because those people do not have a registered job with an occupational class, but upon further thought, this may not be a great idea, as we may want to have people who are 'spouses of working professionals' who may not work themselves, i.e. be homemakers (question of whether or not they don't work due to healthproblems notwithstanding - to be addressed using sensitivity analyses later). we may have people who do not have isco themselves, but whose partners do

		*gen missing_bothISCO = missing(iscoco) & missing(isco08)  // Create a flag for simultaneous missing values
		*list if missing_bothISCO == 1  // Display observations where both are missing

					*remove respondents with no value for either iscoco or isco08 (since iscoco was used in earlier waves as a country specific isco code and isco08 in later, the two variables in merged datasets are complementary)
					*drop if missing(iscoco) & missing(isco08)
					*(64,629 observations deleted)
					*drop respondents with missing values for occupational class 
					*drop if occupational_class == 0
					*(11,289 observations deleted)

*_______________________________________________________________________*

*occupational class of partner
generate occupational_classp=.

*armed forces
replace occupational_classp=10 if isco08p <=999
replace occupational_classp=10 if iscocop <=999

*managers
replace occupational_classp=1 if isco08p >=1000 & isco08p <=1999
replace occupational_classp=1 if iscocop >=1000 & iscocop <=1999

*professionals
replace occupational_classp=2 if isco08p >=2000 & isco08p <=2999
replace occupational_classp=2 if iscocop >=2000 & iscocop <=2999

*technicians and associate profesionals
replace occupational_classp=3 if isco08p >=3000 & isco08p <=3999
replace occupational_classp=3 if iscocop >=3000 & iscocop <=3999

*clerical support workers
replace occupational_classp=4 if isco08p >=4000 & isco08p <=4999
replace occupational_classp=4 if iscocop >=4000 & iscocop <=4999

*service and sales workers
replace occupational_classp=5 if isco08p >=5000 & isco08p <=5999
replace occupational_classp=5 if iscocop >=5000 & iscocop <=5999

*agricultural workers
replace occupational_classp=6 if isco08p >=6000 & isco08p <=6999
replace occupational_classp=6 if iscocop >=6000 & iscocop <=6999

*craft and trades workers
replace occupational_classp=7 if isco08p >=7000 & isco08p <=7999
replace occupational_classp=7 if iscocop >=7000 & iscocop <=7999

*machine operators
replace occupational_classp=8 if isco08p >=8000 & isco08p <=8340
replace occupational_classp=8 if iscocop >=8000 & iscocop <=8340

*elementary occupations
replace occupational_classp=9 if isco08p >=9000 & isco08p <=9330
replace occupational_classp=9 if iscocop >=9000 & iscocop <=9330

label values occupational_classp occ_label  // Apply the label to the variable

* Check the distribution
tab occupational_classp

*tab2xl occupational_classp using output_tables, col(20) row(1)

svy: tab occupational_classp, percent

* will not drop all non-professional occupations of partners, instead, we will aim to see if having a medical professional partner matters more for partners of lower occup class/ lower education (maybe we don't care about occupational class of partners beyond removing medical professionals themselves and instead look at educational attainment? ) 
*some medical professional partners may not work / stay at home partners and we still want to know how having a med professional at home affects health

/*

                    occupational_classp |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                                      0 |    351,596       66.25       66.25
                               Managers |     15,542        2.93       69.18
                          Professionals |     37,141        7.00       76.18
Technicians and Associate Professionals |     28,641        5.40       81.57
               Clerical Support Workers |     15,898        3.00       84.57
              Service and Sales Workers |     25,967        4.89       89.46
                   Agricultural Workers |      5,010        0.94       90.41
               Craft and Trades Workers |     25,161        4.74       95.15
                      Machine Operators |     14,571        2.75       97.89
                 Elementary Occupations |     10,349        1.95       99.84
                           Armed Forces |        835        0.16      100.00
----------------------------------------+-----------------------------------
                                  Total |    530,711      100.00
								  
								  occupatio |
survey weighted      | percentage
----------+-----------
        0 |       64.9
 Managers |      2.991
 Professi |      7.009
 Technici |      5.517
 Clerical |      3.154
  Service |      5.276
 Agricult |      .9833
 Craft an |       4.98
  Machine |      2.893
 Elementa |      2.144
 Armed Fo |      .1566

								  *as expected, there are a lot of individuals (66% of the sample), who do not have a value for partner occupational status, since either they do not have a partner or the partner does not work. This is not worrying, but we may want to do some sensitivity analysis to see whether those with and without working partners differ in significant ways
								  
*/


/* recode of occupational class: 

| New Group Code | Label                              | Original ISCO Codes Combined     |
| -------------- | ---------------------------------- | -------------------------------- |
| 1              | Managers & Professionals           | 1 (Managers) + 2 (Professionals) |
| 2              | Technicians & Clerical             | 3 (Technicians) + 4 (Clerical)   |
| 3              | Service & Sales                    | 5                                |
| 4              | Agricultural, Crafts & Machine Ops | 6 + 7 + 8                        |
| *DROP*         | Armed Forces & Elementary          | 10 + 9                           |

*/

* Step 1: Start from original classification
gen occclass_collapsed = .
gen occclass_collapsed_partner = .

* Group 1: Managers + Professionals
replace occclass_collapsed = 1 if inlist(occupational_class, 1, 2)
replace occclass_collapsed_partner = 1 if inlist(occupational_classp, 1, 2)

* Group 2: Technicians + Clerical
replace occclass_collapsed = 2 if inlist(occupational_class, 3, 4)
replace occclass_collapsed_partner = 2 if inlist(occupational_classp, 3, 4)

* Group 3: Service & Sales
replace occclass_collapsed = 3 if occupational_class == 5
replace occclass_collapsed_partner = 3 if occupational_classp == 5

* Group 4: Agriculture, Crafts, Machine Ops
replace occclass_collapsed = 4 if inlist(occupational_class, 6, 7, 8)
replace occclass_collapsed_partner = 4 if inlist(occupational_classp, 6, 7, 8)

* Group 5: Elementary Occupations 
replace occclass_collapsed = 5 if inlist(occupational_class, 9)
replace occclass_collapsed_partner = 5 if inlist(occupational_classp, 9)

*Group 6: Occupational class not reported + Armed Forced
replace occclass_collapsed = 6 if inlist(occupational_class, .)
replace occclass_collapsed_partner = 6 if inlist(occupational_classp, .)
replace occclass_collapsed = 6 if inlist(occupational_class, 10)
replace occclass_collapsed_partner = 6 if inlist(occupational_classp, 10)


label define occclass_lbl 1 "Managers/Professionals" ///
                         2 "Technicians/Clerical" ///
                         3 "Service/Sales" ///
                         4 "Agricultural/Crafts/Operators" ///
						 5 "Elementary Occupations" ///
						 6 "Occupational class not reported + Armed Forces"

label values occclass_collapsed_partner occclass_lbl
label values occclass_collapsed occclass_lbl

*_______________________________________________________________________*
*	MEDICAL PROFESSIONAL VARIABLES

label list isco08
label list iscoco

*What do we consider a medical professional (doctor): 

	*three options: 		*1. more stringent (only doctors) + 
	
						*2200	Health professionals
						*2210 	Medical doctors
						*2211	General medical practictioners
						*2212	Specialist medical practictioners
						
								*!food for thought: possibly adding 2261 (Dentists) if we want to make the categories to correspond with educational attainment/prestige, as opposed to just medical education, but I am intuitively against this, because we don't want to create a proxy for prestige/educational attainment, but rather to see how specialized knowledge may spill over to partnerships - unless dentists go through similar training that would give them similar insights and we could hypothesize similar network ties in the healthcare sector that could help with family illness 


							*2. more inclusive (including nurses and other medical professionals, such as dentists, physiotherapist)
	
						*2200	Health professionals
						*2210 	Medical doctors
						*2211	General medical doctors
						*2212	Specialist medical doctors
						*	+
						*2220 	Nursing and midwifery professionals
						*2221	Nursing professionals
						*2222	Midwifery professionals
						*2240 	Paramedical practitioners						
						*2262	Pharmacists
						
						*2230 	Traditional and complementary medicine professionals
						*2260 	Other health professionals
						*2261	Dentists
						*2264	Physiotherapists
						*2265	Dieticians and nutritionists
						*2266	Audiologists and speech therapists
						*2267	Optometrists and ophthalmic opticians
						*2269	Health professionals not elsewhere classified
						
							*!food for thought: possibly splitting the variable so that only doctors and nurses + pharmacists are included, as opposed to the other professionals, because the network ties of the other professionals may not be operating through the same mechanisms
						
							*3. most inclusive (including all healthcare workers)
							
						*2200	Health professionals
						*2210 	Medical doctors
						*2211	General medical doctors
						*2212	Specialist medical doctors
						*2220 	Nursing and midwifery professionals
						*2221	Nursing professionals
						*2222	Midwifery professionals
						*2230 	Traditional and complementary medicine professionals
						*2240	Paramedical practitioners
						*2260	Other health professionals
						*2261	Dentists
						*2262	Pharmacists
						*2264	Physiotherapists
						*2265	Dieticians and nutritionists
						*2266	Audiologists and speech therapists
						*2267	Optometrists and ophthalmic opticians
						*2269	Health professionals not elsewhere classified
						*	+
						*3250 Other health associate professionals
						*3251	Dental assistants and therapists
						*3252	Medical records and health information technicians
						*3253	 Community health workers
						*3254	 Dispensing opticians
						*3255	 Physiotherapy technicians and assistants
						*3256	Medical assistants
						*3257	Environmental and occupational health inspectors
						*3258	Ambulance workers (e.g., paramedics)
						*3259	 Health associate professionals not elsewhere classified
						*5320	 Personal care workers in health services
						*5321	Healthcare assistants (e.g., nursing aides, hospital attendants)
						*5322	 Home-based personal care workers
						*5329	 Personal care workers in health services not elsewhere classified

	
	*BONUS OPTION: this would not be a dichotomous variable, but rather a categorical variable with different degrees (i.e. 0. not a healthcare professional 1. doctors, 2. other medical professionals 3. other healthcare workers)
	
*Option 1

gen med_prof = 0  // Create a new variable, default is 0 (Not a medical professional)

replace med_prof = 1 if inlist(isco08, 2200, 2210, 2211, 2212)  // ISCO-08 codes for medical professionals
replace med_prof = 1 if inlist(iscoco, 2200, 2210, 2211, 2212)  // Check ISCOCO as well

label define med_prof_label 0 "Not Medical Practitioner" 1 "Medical Practitioner"
label values med_prof med_prof_label  // Label the new variable

tab med_prof  // Check the distribution

/*

*here's a smaller sample where we removed all individuals for whom we do not have isco 

                med_prof |      Freq.     Percent        Cum.
-------------------------+-----------------------------------
Not Medical Practioner   |    452,805       99.56       99.56
    Medical Practitioner |      1,988        0.44      100.00
-------------------------+-----------------------------------
                   Total |    454,793      100.00


*here's a slightly larger sample where we kept all of the individuals who do not have isco as not medical practitioners - there is no difference in the number of medical practitioners
                med_prof |      Freq.     Percent        Cum.
-------------------------+-----------------------------------
Not Medical Practitioner |    528,723       99.63       99.63
    Medical Practitioner |      1,988        0.37      100.00
-------------------------+-----------------------------------
                   Total |    530,711      100.00

				   This is a pretty small sample of medical practitioners compared to the other two more expansive variables
*/		

*Option 2 
	
gen med_prof2 = 0  // Create a new variable, default is 0 (Not a medical professional)

replace med_prof2 = 1 if inlist(isco08, 2200, 2210, 2211, 2212, 2221, 2222, 2230, 2240, 2260, 2261, 2262, 2264, 2265, 2266, 2267, 2269)  // ISCO-08 codes for medical professionals
replace med_prof2 = 1 if inlist(iscoco, 2200, 2210, 2211, 2212, 2221, 2222, 2230, 2240, 2260, 2261, 2262, 2264, 2265, 2266, 2267, 2269)  // Check ISCOCO as well

label define med_prof2_label 0 "Not Medical Professional" 1 "Medical Professional"
label values med_prof2 med_prof_2label  // Label the new variable

tab med_prof2  // Check the distribution

/*
               med_prof2 |      Freq.     Percent        Cum.
-------------------------+-----------------------------------
Not Medical Professional |    445,202       97.89       97.89
    Medical Professional |      9,591        2.11      100.00
-------------------------+-----------------------------------
                   Total |    454,793      100.00
				   
*/	

*Option 3

gen healthcare_worker = 0  // Default is 0 (Not a healthcare worker)

replace healthcare_worker = 1 if inlist(isco08, ///
    2200, 2210, 2211, 2212, 2221, 2222, 2230, 2240, 2260, 2261, 2262, 2264, 2266, 2267, 2269, /// Medical professionals
    2265, 3250, 3251, 3252, 3253, 3254, 3255, 3256, 3257, 3258, 3259, 5320, 5321, 5329)  // Additional healthcare roles

replace healthcare_worker = 1 if inlist(iscoco, ///
    2200, 2210, 2211, 2212, 2221, 2222, 2230, 2240, 2260, 2261, 2262, 2264, 2266, 2267, 2269, /// Medical professionals
    2265, 3250, 3251, 3252, 3253, 3254, 3255, 3256, 3257, 3258, 3259, 5320, 5321, 5329)  // Additional healthcare roles

label define healthcare_worker_label 0 "Not Healthcare Worker" 1 "Healthcare Worker"
label values healthcare_worker healthcare_worker_label  // Label the new variable



tab healthcare_worker  // Check the distribution

/*
    healthcare_worker |      Freq.     Percent        Cum.
----------------------+-----------------------------------
Not Healthcare Worker |    439,609       96.66       96.66
    Healthcare Worker |     15,184        3.34      100.00
----------------------+-----------------------------------
                Total |    454,793      100.00

*/
		
	*BONUS option 4
	
* Create a new variable for medical professional
gen medical_professional_4cat = 0  // Default value is 0 (Not a medical health professional)

* Assign value 1 for 'medical health practitioner' (isco08 between 2200 and 2212)
replace medical_professional_4cat = 1 if inrange(isco08, 2200, 2212)
replace medical_professional_4cat = 1 if inrange(iscoco, 2200, 2212)

* Assign value 2 for 'nursing/midwifery and other health professional' (isco08 between 2220 and 2269)
replace medical_professional_4cat = 2 if inrange(isco08, 2220, 2269)
replace medical_professional_4cat = 2 if inrange(iscoco, 2220, 2269)

* Assign value 3 for 'other healthcare worker' (isco08 between 3250 and 3259, or between 5320 and 5329)
replace medical_professional_4cat = 3 if inrange(isco08, 3250, 3259) | inrange(isco08, 5320, 5329)
replace medical_professional_4cat = 3 if inrange(iscoco, 3250, 3259) | inrange(iscoco, 5320, 5329)

* Label the new variable
label variable medical_professional_4cat "Medical Professional: 0 = Not a Medical Health Professional, 1 = Medical Health Practitioner, 2 = Nursing/Midwifery and Other Health Professional, 3 = Other Healthcare Worker"

* Define the value labels for the variable
label define medical_prof_label_4cat 0 "Not a Medical Health Professional" 1 "Medical Health Practitioner" ///
                              2 "Nursing/Midwifery and Other Health Professional" 3 "Other Healthcare Worker"

* Apply the value labels to the new variable
label values medical_professional_4cat medical_prof_label_4cat

* Check the results
tab medical_professional_4cat	
	

/*
								  
								  Medical Professional: 0 = Not a Medical |
Health Professional, 1 = Medical Health |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
      Not a Medical Health Professional |    436,555       95.99       95.99
            Medical Health Practitioner |      1,988        0.44       96.43
Nursing/Midwifery and Other Health Prof |      8,577        1.89       98.31
                Other Healthcare Worker |      7,673        1.69      100.00
----------------------------------------+-----------------------------------
                                  Total |    454,793      100.00


*/
	
	
	*BONUS option 5 (more stringent) 
	
	
* Create a new variable for medical professional
gen medical_professional_2cat = 0  // Default value is 0 (Not a medical health professional)

* Assign value 1 for 'medical health practitioner' (isco08 between 2200 and 2212)
replace medical_professional_2cat = 1 if inrange(isco08, 2200, 2212)
replace medical_professional_2cat = 1 if inrange(iscoco, 2200, 2212)

* Assign value 2 for 'nursing/midwifery and other health professional' (isco08 between 2220 and 2269)
replace medical_professional_2cat = 2 if inrange(isco08, 2220, 2269)
replace medical_professional_2cat = 2 if inrange(iscoco, 2220, 2269)

* Label the new variable
label variable medical_professional_2cat "Medical Professional: 0 = Not a Medical Health Professional, 1 = Medical Health Practitioner, 2 = Nursing/Midwifery and Other Health Professional"

* Define the value labels for the variable
label define medical_prof_label_2cat 0 "Not a Medical Health Professional" 1 "Medical Health Practitioner" ///
                              2 "Nursing/Midwifery and Other Health Professional"

* Apply the value labels to the new variable
label values medical_professional_2cat medical_prof_label_2cat

* Check the results
tab medical_professional_2cat	
	
	
*_______________________________________________________________________*

*MEDICAL PROFESSIONAL SPOUSE	
*create variable to identify medical professional partners

*Option 1

gen med_prof_spouse = 0  // Create a new variable, default is 0 (Not a medical professional)

replace med_prof_spouse = 1 if inlist(isco08p, 2200, 2210, 2211, 2212)  // ISCO-08 codes for medical professionals
replace med_prof_spouse = 1 if inlist(iscocop, 2200, 2210, 2211, 2212)  // Check ISCOCO as well

label define med_prof_label_spouse 0 "Not Medical Practitioner spouse" 1 "Medical Practitioner spouse"
label values med_prof_spouse med_prof_label_spouse  // Label the new variable

tab med_prof_spouse  // Check the distribution
/*

****** sample where we removed respondents without isco score

                med_prof_spouse |      Freq.     Percent        Cum.
--------------------------------+-----------------------------------
Not Medical Practitioner spouse |    453,641       99.75       99.75
    Medical Practitioner spouse |      1,152        0.25      100.00
--------------------------------+-----------------------------------
                          Total |    454,793      100.00

****** sample where we keep respondents without isco score has 44 more medical practitioner spouses 

                med_prof_spouse |      Freq.     Percent        Cum.
--------------------------------+-----------------------------------
Not Medical Practitioner spouse |    529,515       99.77       99.77
    Medical Practitioner spouse |      1,196        0.23      100.00
--------------------------------+-----------------------------------
                          Total |    530,711      100.00

*/

*Option 2 
	
gen med_prof_spouse2 = 0  // Create a new variable, default is 0 (Not a medical professional)

replace med_prof_spouse2 = 1 if inlist(isco08p, 2200, 2210, 2211, 2212, 2221, 2222, 2230, 2240, 2260, 2261, 2262, 2264, 2265, 2266, 2267, 2269)  // ISCO-08 codes for medical professionals
replace med_prof_spouse2 = 1 if inlist(iscocop, 2200, 2210, 2211, 2212, 2221, 2222, 2230, 2240, 2260, 2261, 2262, 2264, 2265, 2266, 2267, 2269)  // Check ISCOCO as well

label define med_prof_label2_spouse 0 "Not Medical Professional spouse" 1 "Medical Professional spouse"
label values med_prof_spouse2 med_prof_label2_spouse  // Label the new variable

tab med_prof_spouse2  // Check the distribution

/*

****** sample where we removed respondents without isco score

               med_prof_spouse2 |      Freq.     Percent        Cum.
--------------------------------+-----------------------------------
Not Medical Professional spouse |    450,111       98.97       98.97
    Medical Professional spouse |      4,682        1.03      100.00
--------------------------------+-----------------------------------
                          Total |    454,793      100.00
				   
****** sample where we keep respondents without isco score has ~200 more medical practitioner spouses 

               med_prof_spouse2 |      Freq.     Percent        Cum.
--------------------------------+-----------------------------------
Not Medical Professional spouse |    525,837       99.08       99.08
    Medical Professional spouse |      4,874        0.92      100.00
--------------------------------+-----------------------------------
                          Total |    530,711      100.00

				   This is a nicer sample size already, but will see how it differs in terms of other important variables of interest 
*/	

*Option 3

gen healthcare_worker_spouse = 0  // Default is 0 (Not a healthcare worker)

replace healthcare_worker_spouse = 1 if inlist(isco08p, ///
    2200, 2210, 2211, 2212, 2221, 2222, 2230, 2240, 2260, 2261, 2262, 2264, 2266, 2267, 2269, /// Medical professionals
    2265, 3250, 3251, 3252, 3253, 3254, 3255, 3256, 3257, 3258, 3259, 5320, 5321, 5329)  // Additional healthcare roles

replace healthcare_worker_spouse = 1 if inlist(iscocop, ///
    2200, 2210, 2211, 2212, 2221, 2222, 2230, 2240, 2260, 2261, 2262, 2264, 2266, 2267, 2269, /// Medical professionals
    2265, 3250, 3251, 3252, 3253, 3254, 3255, 3256, 3257, 3258, 3259, 5320, 5321, 5329)  // Additional healthcare roles

label define healthcare_worker_label_spouse 0 "Not Healthcare Worker spouse" 1 "Healthcare Worker spouse"
label values healthcare_worker_spouse healthcare_worker_label_spouse  // Label the new variable



tab healthcare_worker_spouse  // Check the distribution

/*

****** sample where we removed respondents without isco score

    healthcare_worker_spouse |      Freq.     Percent        Cum.
-----------------------------+-----------------------------------
Not Healthcare Worker spouse |    448,028       98.51       98.51
    Healthcare Worker spouse |      6,765        1.49      100.00
-----------------------------+-----------------------------------
                       Total |    454,793      100.00

****** sample where we keep respondents without isco score has 347 more healthcare worker spouses 

    healthcare_worker_spouse |      Freq.     Percent        Cum.
-----------------------------+-----------------------------------
Not Healthcare Worker spouse |    523,599       98.66       98.66
    Healthcare Worker spouse |      7,112        1.34      100.00
-----------------------------+-----------------------------------
                       Total |    530,711      100.00

					  
*/
		
	*BONUS option 4
	
* Create a new variable for medical professional
gen medical_professional_4cat_spouse = 0  // Default value is 0 (Not a medical health professional)

* Assign value 1 for 'medical health practitioner' (isco08 between 2200 and 2212)
replace medical_professional_4cat_spouse = 1 if inrange(isco08p, 2200, 2212)
replace medical_professional_4cat_spouse = 1 if inrange(iscocop, 2200, 2212)

* Assign value 2 for 'nursing/midwifery and other health professional' (isco08 between 2220 and 2269)
replace medical_professional_4cat_spouse = 2 if inrange(isco08p, 2220, 2269)
replace medical_professional_4cat_spouse = 2 if inrange(iscocop, 2220, 2269)

* Assign value 3 for 'other healthcare worker' (isco08 between 3250 and 3259, or between 5320 and 5329)
replace medical_professional_4cat_spouse = 3 if inrange(isco08p, 3250, 3259) | inrange(isco08p, 5320, 5329)
replace medical_professional_4cat_spouse = 3 if inrange(iscocop, 3250, 3259) | inrange(iscocop, 5320, 5329)

* Label the new variable
label variable medical_professional_4cat_spouse "Medical Professional Spouse: 0 = Not a Medical Health Professional spouse, 1 = Medical Health Practitioner spouse, 2 = Nursing/Midwifery and Other Health Professional spouse, 3 = Other Healthcare Worker spouse"

* Define the value labels for the variable
label define medical_prof_label_4cat_spouse 0 "Not a Medical Health Professional spouse" 1 "Medical Health Practitioner spouse" ///
                              2 "Nursing/Midwifery and Other Health Professional spouse" 3 "Other Healthcare Worker spouse"

* Apply the value labels to the new variable
label values medical_professional_4cat_spouse medical_prof_label_4cat_spouse

* Check the results
tab medical_professional_4cat_spouse

svy: tab medical_professional_4cat_spouse, percent

	*BONUS option 5 (more stringent) 
	
	
* Create a new variable for medical professional
gen medical_professional_2cat_spouse = 0  // Default value is 0 (Not a medical health professional)

* Assign value 1 for 'medical health practitioner' (isco08 between 2200 and 2212)
replace medical_professional_2cat_spouse = 1 if inrange(isco08p, 2200, 2212)
replace medical_professional_2cat_spouse = 1 if inrange(iscocop, 2200, 2212)

* Assign value 2 for 'nursing/midwifery and other health professional' (isco08 between 2220 and 2269)
replace medical_professional_2cat_spouse = 2 if inrange(isco08p, 2220, 2269)
replace medical_professional_2cat_spouse = 2 if inrange(iscocop, 2220, 2269)

* Label the new variable
label variable medical_professional_2cat_spouse "Medical Professional: 0 = Not a Medical Health Professional spouse, 1 = Medical Health Practitioner spouse, 2 = Nursing/Midwifery and Other Health Professional spouse"

* Define the value labels for the variable
label define medical_prof_label_2cat_spouse 0 "Not a Medical Health Professional spouse" 1 "Medical Health Practitioner spouse" ///
                              2 "Nursing/Midwifery and Other Health Professional spouse"

* Apply the value labels to the new variable
label values medical_professional_2cat_spouse medical_prof_label_2cat_spouse

* Check the results
tab medical_professional_2cat_spouse
	
	
*_______________________________________________________________________*
*CROSS TABS FOR MED PROFESSIONALS AND MED PREOFESSIONAL SPOUSES	+ MARITAL STATUS

*mwe run cross tabs with both samples (smaller and larger that include respondents with/without isco scole themselves) - shouldn't change much in terms of how many overlapping doctor/doctor spouse combos there are, just the 'not practitioner'/practitioner spouse group

*OPTION 1
tab med_prof med_prof_spouse

/*

                      |    med_prof_spouse
             med_prof | Not Medic  Medical P |     Total
----------------------+----------------------+----------
Not Medical Practitio |   451,909        896 |   452,805 
 Medical Practitioner |     1,732        256 |     1,988 
----------------------+----------------------+----------
                Total |   453,641      1,152 |   454,793 

				*there are 256 doctor respondents who also married doctors 
	
	
	*larger sample
				                      |    med_prof_spouse
             med_prof | Not Medic  Medical P |     Total
----------------------+----------------------+----------
Not Medical Practitio |   527,783        940 |   528,723 
 Medical Practitioner |     1,732        256 |     1,988 
----------------------+----------------------+----------
                Total |   529,515      1,196 |   530,711 
				
				*the larger sample increased our number of non practitioners with medical professional spouses

*/

*OPTION 2
tab med_prof2 med_prof_spouse2

/*
           |   med_prof_spouse2
 med_prof2 | Not Medic  Medical P |     Total
-----------+----------------------+----------
         0 |   441,413      3,789 |   445,202 
         1 |     8,698        893 |     9,591 
-----------+----------------------+----------
     Total |   450,111      4,682 |   454,793 

			*there are 893 medical professionals who also married medical professionals
			
			
			*larger sample with full isco
			           |   med_prof_spouse2
 med_prof2 | Not Medic  Medical P |     Total
-----------+----------------------+----------
         0 |   517,139      3,981 |   521,120 
         1 |     8,698        893 |     9,591 
-----------+----------------------+----------
     Total |   525,837      4,874 |   530,711 
	 
	 *the larger sample increased our number of non practitioners with medical professional spouses

*/

*Option 3
tab healthcare_worker healthcare_worker_spouse
svy: tab healthcare_worker healthcare_worker_spouse

/*
                      | healthcare_worker_spouse
    healthcare_worker | Not Healt  Healthcar |     Total
----------------------+----------------------+----------
Not Healthcare Worker |   433,970      5,639 |   439,609 
    Healthcare Worker |    14,058      1,126 |    15,184 
----------------------+----------------------+----------
                Total |   448,028      6,765 |   454,793 

			*there are 1126 healthcare workers who also married healthcare workers
			
			
			                      | healthcare_worker_spouse
    healthcare_worker | Not Healt  Healthcar |     Total
----------------------+----------------------+----------
Not Healthcare Worker |   509,541      5,986 |   515,527 
    Healthcare Worker |    14,058      1,126 |    15,184 
----------------------+----------------------+----------
                Total |   523,599      7,112 |   530,711 
			
			
			*the larger sample increased our number of non practitioners with medical professional spouses
				
*/



tab med_prof_spouse new_marital_status
tab med_prof_spouse2 new_marital_status
tab healthcare_worker_spouse new_marital_status

*tab2xl med_prof_spouse new_marital_status using output_tables, col(8) row(15)
*tab2xl med_prof_spouse2 new_marital_status using output_tables, col(8) row(25)
*tab2xl healthcare_worker_spouse new_marital_status using output_tables, col(8) row(35)

/*


      med_prof_spouse | Not Marri  Married/C |     Total
----------------------+----------------------+----------
Not Medical Practitio |   270,592    258,923 |   529,515 
Medical Practitioner  |       311        885 |     1,196 
----------------------+----------------------+----------
                Total |   270,903    259,808 |   530,711 
				

     med_prof_spouse2 | Not Marri  Married/C |     Total
----------------------+----------------------+----------
Not Medical Professio |   269,769    256,068 |   525,837 
Medical Professional  |     1,134      3,740 |     4,874 
----------------------+----------------------+----------
                Total |   270,903    259,808 |   530,711 

				
healthcare_worker_spo |      Partnership
                  use | Not Marri  Married/C |     Total
----------------------+----------------------+----------
Not Healthcare Worker |   269,080    254,519 |   523,599 
Healthcare Worker spo |     1,823      5,289 |     7,112 
----------------------+----------------------+----------
                Total |   270,903    259,808 |   530,711 


				there seems to be an issue with the marital status variable, since we have individuals with partnership occupational information despite the fact that they are not married/ in a legal partnership
				I am thinking that there may be a small difference if, for example, the divorce/separation/death of partner was recent and the respondents still reported occupational category of their partner occupation - it would be a shame to remove 
				*TO DISCUSS - we could avoid using the married/non married variable and simply use the sample that reported a partner's ISCO code - assume that this means that they have a reported partner/spouse (makes sample larger )
				
				
*/
									
*we can drop medical professional respondents or just exclude them out of the sample for now, to check how they differ in important variables


*_______________________________________________________________________*
*TOTAL NUMBER OF WORK PER WEEK IN MAIN JOB - OVERTIME INCLUDED for respondents and their partners 

gen wkhtot_cat = .

replace wkhtot_cat = 1 if wkhtot < 15
replace wkhtot_cat = 2 if inrange(wkhtot, 15, 29)
replace wkhtot_cat = 3 if inrange(wkhtot, 30, 35)
replace wkhtot_cat = 4 if inrange(wkhtot, 36, 45)
replace wkhtot_cat = 5 if inrange(wkhtot, 46, 55)
replace wkhtot_cat = 6 if wkhtot > 55
replace wkhtot_cat = 7 if missing(wkhtot)
replace wkhtot_cat = 7 if wkhtot_cat==.

label define wkhtot_cat_label ///
    1 "<15 hrs" ///
    2 "15–29 hrs" ///
    3 "30–35 hrs" ///
    4 "36–45 hrs" ///
    5 "46–55 hrs" ///
    6 ">55 hrs" ///
	7 "Missing/Not reported"
	

	
	label values wkhtot_cat wkhtot_cat_label
	
tab wkhtot_cat, m

/* 

 wkhtot_cat |      Freq.     Percent        Cum.
------------+-----------------------------------
    <15 hrs |     25,324        4.77        4.77
  15–29 hrs |     38,898        7.33       12.10
  30–35 hrs |     36,797        6.93       19.03
  36–45 hrs |    232,698       43.85       62.88
  46–55 hrs |     66,888       12.60       75.48
    >55 hrs |     38,944        7.34       82.82
          . |     91,162       17.18      100.00
------------+-----------------------------------
      Total |    530,711      100.00


	  
*/

gen wkhtot_cat_partner = .

replace wkhtot_cat_partner = 1 if wkhtotp < 15
replace wkhtot_cat_partner = 2 if inrange(wkhtotp, 15, 29)
replace wkhtot_cat_partner = 3 if inrange(wkhtotp, 30, 35)
replace wkhtot_cat_partner = 4 if inrange(wkhtotp, 36, 45)
replace wkhtot_cat_partner = 5 if inrange(wkhtotp, 46, 55)
replace wkhtot_cat_partner = 6 if wkhtotp > 55
replace wkhtot_cat_partner = 7 if missing(wkhtotp)
replace wkhtot_cat_partner = 7 if wkhtot_cat_partner==.

	
label values wkhtot_cat_partner wkhtot_cat_label
	
tab wkhtot_cat_partner, m


/* 

wkhtot_cat_ |
    partner |      Freq.     Percent        Cum.
------------+-----------------------------------
    <15 hrs |      6,068        1.14        1.14
  15–29 hrs |     15,113        2.85        3.99
  30–35 hrs |     16,507        3.11        7.10
  36–45 hrs |    102,162       19.25       26.35
  46–55 hrs |     21,113        3.98       30.33
    >55 hrs |     13,400        2.52       32.85
          . |    356,348       67.15      100.00
------------+-----------------------------------
      Total |    530,711      100.00

	  
*/

tab wkhtot_cat med_prof_spouse
tab wkhtot_cat_partner med_prof_spouse, col

*_______________________________________________________________________*
*whether or not children live at home

 tab chldhm, m
 
 replace chldhm = . if chldhm==.a
 replace chldhm = 3 if chldhm==.

 
 label define children_label ///
    1 "Respondent lives with children" ///
    2 "Respondent does not live with children" ///
    3 "Missing" 
	
gen children_home = chldhm
replace children_home = 1 if cld12hh==1
	
	label values children_home children_label
 
 /*
          Children living at home or not |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
Respondent lives with children at house |    144,862       27.30       27.30
                               Does not |    235,480       44.37       71.67
                                      . |    150,369       28.33      100.00
----------------------------------------+-----------------------------------
                                  Total |    530,711      100.00

								  
   Children living at |    med_prof_spouse
          home or not | Not Medic  Medical P |     Total
----------------------+----------------------+----------
Respondent lives with |   144,477        385 |   144,862 
                      |     38.05      65.03 |     38.09 
----------------------+----------------------+----------
             Does not |   235,273        207 |   235,480 
                      |     61.95      34.97 |     61.91 
----------------------+----------------------+----------
                Total |   379,750        592 |   380,342 
                      |    100.00     100.00 |    100.00 


 */
 
 tab children_home med_prof_spouse, col

*_______________________________________________________________________*
*EDUCATION VARIABLE 

*we can use either highest educational attainment or a continuous variable for the number of years of full time education 

tab eduyrs

/*

(I don't feel too excited about this option, since it may not be harmonized well across countries and there seem to be quite a lot of outliers, such as individuals who spent more than 40-70 years in full time education): 


   Years of |
  full-time |
  education |
  completed |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      1,834        0.40        0.40
          1 |        629        0.14        0.54
          2 |      1,040        0.23        0.77
          3 |      2,443        0.54        1.31
          4 |      7,814        1.72        3.03
          5 |      4,160        0.91        3.94
          6 |      8,440        1.86        5.80
          7 |      8,877        1.95        7.75
          8 |     23,654        5.20       12.95
          9 |     24,039        5.29       18.23
         10 |     27,134        5.97       24.20
         11 |     44,885        9.87       34.07
         12 |          4        0.00       34.07
         12 |     74,758       16.44       50.51
         13 |     43,510        9.57       60.08
         14 |     32,754        7.20       67.28
         15 |          1        0.00       67.28
         15 |     33,511        7.37       74.65
         16 |     32,979        7.25       81.90
         17 |     25,244        5.55       87.45
         18 |     20,732        4.56       92.01
         19 |          1        0.00       92.01
         19 |     10,318        2.27       94.28
         20 |      9,975        2.19       96.47
         21 |      3,415        0.75       97.22
         22 |      2,805        0.62       97.84
         23 |      1,637        0.36       98.20
         24 |      1,124        0.25       98.44
         25 |      1,095        0.24       98.68
         26 |        333        0.07       98.76
         27 |        208        0.05       98.80
         28 |        153        0.03       98.84
         29 |         82        0.02       98.86
         30 |        282        0.06       98.92
         31 |         33        0.01       98.92
         32 |         33        0.01       98.93
         33 |         26        0.01       98.94
         34 |         12        0.00       98.94
         35 |         34        0.01       98.95
         36 |         19        0.00       98.95
         37 |         10        0.00       98.95
         38 |         12        0.00       98.96
         39 |          8        0.00       98.96
         40 |         88        0.02       98.98
         41 |          2        0.00       98.98
         42 |          6        0.00       98.98
         43 |          3        0.00       98.98
         44 |          5        0.00       98.98
         45 |         14        0.00       98.98
         47 |          3        0.00       98.99
         48 |          6        0.00       98.99
         50 |         16        0.00       98.99
         51 |          3        0.00       98.99
         54 |          2        0.00       98.99
         55 |          1        0.00       98.99
         56 |          2        0.00       98.99
         60 |          3        0.00       98.99
         65 |          1        0.00       98.99
         69 |          1        0.00       98.99
         76 |          1        0.00       98.99
    Refusal |        491        0.11       99.10
 Don't know |      2,990        0.66       99.76
  No answer |      1,098        0.24      100.00
------------+-----------------------------------
      Total |    454,793      100.00

*/

*as for the other option of using highest educational attainment, we may need to do some adjustment across countries + waves, as there are multiple obervations as part of the Education level based on ISCED (International Standard Classification of Education) variable that could not be harmonized automatically (63,000), but we can do our best manually

tab eisced, m
tab eiscedp, m
tab eiscedm, m

*cleaning out edu for weighting and analysis: 

label define eisced_lbl ///
    0 "Not harmonizable in EISCED" ///   *TO BE DISCUSSED: what to do with? 
	1 "Less than lower secondary" ///
    2 "Lower secondary" ///
    3 "Lower tier upper secondary" ///
    4 "Upper tier upper secondary" ///
    5 "Post-secondary non-tertiary" ///
    6 "Tertiary BA level" ///
    7 "Tertiary MA/PhD level"

gen eisced_clean = eisced
recode eisced_clean (77/99 = .)
label values eisced_clean eisced_lbl

gen eiscedp_clean = eiscedp
recode eiscedp_clean (77/99 = .)
label values eiscedp_clean eisced_lbl

gen eiscedm_clean = eiscedm
recode eiscedm_clean (77/99 = .)
label values eiscedm_clean eisced_lbl

tab eisced_clean, m
tab eiscedp_clean, m
tab eiscedm_clean, m 

*note that eiscedp and eiscedm variables were not available for rounds 2002 to 2006, so later, I will need to add the observations from another partner and mother education variables - edulvlpa and edulvlma

 tab eisced_clean eduyrs, m 
 *I will now recode individuals who report less than 5 years of full time education as 'less than lower secondary'

replace eisced_clean = 1 if missing(eisced_clean) & eduyrs <= 5





/*


 Highest level of education, ES - ISCED |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
Not possible to harmonise into ES-ISCED |     63,520       13.97       13.97
 ES-ISCED I , less than lower secondary |     30,720        6.75       20.72
           ES-ISCED II, lower secondary |     57,231       12.58       33.31
ES-ISCED IIIb, lower tier upper seconda |     73,797       16.23       49.53
ES-ISCED IIIa, upper tier upper seconda |     80,795       17.77       67.30
ES-ISCED IV, advanced vocational, sub-d |     49,781       10.95       78.24
ES-ISCED V1, lower tertiary education,  |     44,729        9.84       88.08
ES-ISCED V2, higher tertiary education, |     52,366       11.51       99.59
                                  Other |        925        0.20       99.80
                                Refusal |        235        0.05       99.85
                             Don't know |        331        0.07       99.92
                              No answer |        363        0.08      100.00
----------------------------------------+-----------------------------------
                                  Total |    454,793      100.00

Partner's highest level of education,   |
                             ES - ISCED |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
Not possible to harmonise into ES-ISCED |     17,117        3.76        3.76
 ES-ISCED I , less than lower secondary |     14,857        3.27        7.03
           ES-ISCED II, lower secondary |     25,780        5.67       12.70
ES-ISCED IIIb, lower tier upper seconda |     36,670        8.06       20.76
ES-ISCED IIIa, upper tier upper seconda |     39,034        8.58       29.34
ES-ISCED IV, advanced vocational, sub-d |     25,505        5.61       34.95
ES-ISCED V1, lower tertiary education,  |     22,138        4.87       39.82
ES-ISCED V2, higher tertiary education, |     28,238        6.21       46.03
                                  Other |      1,456        0.32       46.35
                                      . |    119,920       26.37       72.72
                         Not applicable |    120,221       26.43       99.15
                                Refusal |        674        0.15       99.30
                             Don't know |      1,374        0.30       99.60
                              No answer |      1,809        0.40      100.00
----------------------------------------+-----------------------------------
                                  Total |    454,793      100.00

*normal that there is quite some missingness as many people don't have partners at all 		

*we also ran mother's highest education, which may be a useful co-variate in the analysis (predictor of life-course health)

              eiscedm_clean |      Freq.     Percent        Cum.
----------------------------+-----------------------------------
 Not harmonizable in EISCED |     20,225        3.81        3.81
  Less than lower secondary |    109,978       20.72       24.53
            Lower secondary |     76,631       14.44       38.97
 Lower tier upper secondary |     44,014        8.29       47.27
 Upper tier upper secondary |     44,083        8.31       55.57
Post-secondary non-tertiary |     22,653        4.27       59.84
          Tertiary BA level |     15,553        2.93       62.77
      Tertiary MA/PhD level |     16,500        3.11       65.88
                         55 |        758        0.14       66.02
                          . |    159,467       30.05       96.07
                         .a |      2,070        0.39       96.46
                         .b |     17,992        3.39       99.85
                         .c |        787        0.15      100.00
----------------------------+-----------------------------------
                      Total |    530,711      100.00

*/


tab eiscedp_clean med_prof_spouse, m



/*

*TO DISCUSS: I may need to impute partner's educational attainment for a few individuals (and sort out a few dubious mismatch cases whereby a partner is listed as a medical practitioner/doctor and yet their educational level is less than university degree). Note: this med prof spouse sample is doctors only, not nurses/other healthcare professionals. Either there is a problem with the partners not being doctors or an incorrect educational attainment

    Partner's highest |
  level of education, |    med_prof_spouse
           ES - ISCED | Not Medic  Medical P |     Total
----------------------+----------------------+----------
Not possible to harmo |    20,212         13 |    20,225 
ES-ISCED I , less tha |    17,905          2 |    17,907 
ES-ISCED II, lower se |    29,877          3 |    29,880 
ES-ISCED IIIb, lower  |    39,790          6 |    39,796 
ES-ISCED IIIa, upper  |    43,108          5 |    43,113 
ES-ISCED IV, advanced |    27,292         11 |    27,303 
ES-ISCED V1, lower te |    23,441         75 |    23,516 
ES-ISCED V2, higher t |    28,678      1,001 |    29,679 
                Other |     1,567         11 |     1,578 
                    . |   137,348         64 |   137,412 
       Not applicable |   154,748          0 |   154,748 
              Refusal |       931          1 |       932 
           Don't know |     1,671          0 |     1,671 
            No answer |     2,947          4 |     2,951 
----------------------+----------------------+----------
                Total |   529,515      1,196 |   530,711 

*/

*only keep respondents whose spouses are university educated 
*keep if inlist(eiscedp_clean, 6, 7)

*impute values for med prof spouses such that all med prof spouses are listed as having Tertiary education (correction of error)
replace eiscedp_clean = 7 if med_prof_spouse == 1


*streamline the group variable 

// Respondent education: eisced_clean
gen eisced_grouped = .
replace eisced_grouped = 1 if inlist(eisced_clean, 1, 2)
replace eisced_grouped = 2 if inlist(eisced_clean, 3, 4)
replace eisced_grouped = 3 if inlist(eisced_clean, 5, 6)
replace eisced_grouped = 4 if eisced_clean == 7
label variable eisced_grouped "Grouped educational attainment (respondent)"

// Mother's education: eiscedm_clean
gen eiscedm_grouped = .
replace eiscedm_grouped = 1 if inlist(eiscedm_clean, 1, 2)
replace eiscedm_grouped = 2 if inlist(eiscedm_clean, 3, 4)
replace eiscedm_grouped = 3 if inlist(eiscedm_clean, 5, 6)
replace eiscedm_grouped = 4 if eiscedm_clean == 7
label variable eiscedm_grouped "Grouped educational attainment (mother)"

// Partner's education: eiscedp_clean
gen eiscedp_grouped = .
replace eiscedp_grouped = 1 if inlist(eiscedp_clean, 1, 2)
replace eiscedp_grouped = 2 if inlist(eiscedp_clean, 3, 4)
replace eiscedp_grouped = 3 if inlist(eiscedp_clean, 5, 6)
replace eiscedp_grouped = 4 if eiscedp_clean == 7
label variable eiscedp_grouped "Grouped educational attainment (partner)"

// Shared value labels for all three variables
label define edu_lbl ///
    1 "Lower secondary or less" ///
    2 "Upper secondary" ///
    3 "Post-secondary or BA" ///
    4 "MA or PhD"

label values eisced_grouped edu_lbl
label values eiscedm_grouped edu_lbl
label values eiscedp_grouped edu_lbl

// Respondent education
replace eisced_grouped = 0 if missing(eisced_clean) | eisced_clean == 0

// Mother's education
replace eiscedm_grouped = 0 if missing(eiscedm_clean) | eiscedm_clean == 0

// Partner's education
replace eiscedp_grouped = 0 if missing(eiscedp_clean) | eiscedp_clean == 0

// Update label to include "Missing/Not harmonizable"
label define edu_lbl ///
    0 "Missing/Not harmonizable" ///
    1 "Lower secondary or less" ///
    2 "Upper secondary" ///
    3 "Post-secondary or BA" ///
    4 "MA or PhD", replace

// Re-apply labels
label values eisced_grouped edu_lbl
label values eiscedm_grouped edu_lbl
label values eiscedp_grouped edu_lbl


*problematic harmonization of educational attainment in early rounds of ESS 

* I just identified the issue that was looming for a while - something in the way I code edu_spouse_cat and edu_mother_cat is not correct for years 2002 to 2006
* this issue is not a problem for education of respondent - I now need to investigate if the first three waves of ESS did not collect information on partner's and mother's edu 
*the problem is with the eiscedp and eiscedm variables on which eisced_clean was based, since these were not collected for rounds 1 to 3 (2002 to 2006) - need to use 

// Mother's education 2002-2006
replace eiscedm_grouped = 0 if edulvlma==0
replace eiscedm_grouped = 1 if inlist(edulvlma, 1, 2)
replace eiscedm_grouped = 2 if inlist(edulvlma, 3, 4)
replace eiscedm_grouped = 3 if edulvlma==5
replace eiscedm_grouped = 0 if eiscedm_grouped==.

// Partner's education 2002-2006
replace eiscedp_grouped = 0 if edulvlpa==0
replace eiscedp_grouped = 1 if inlist(edulvlpa, 1, 2)
replace eiscedp_grouped = 2 if inlist(edulvlpa, 3, 4)
replace eiscedp_grouped = 3 if edulvlpa==5
replace eiscedp_grouped = 0 if eiscedp_grouped==.

*this has worked perfectly to make up for the missing data for education of mothers and partners within 2002 -2006, but the only problem is that the previous iteration of educational variable has not distinguished between ba and higher tertiary degrees, so it looks like there are no Master/PhD/MD educated partners and mothers within 2002 and 2006 - there were unfortunately not distinguised. This is not an issue if we use the collapsed version of educational attainment below. 




*_______________________________________________________________________*

*recode education variable into binary + missing values 
  
label define edu_cat 1 "Less than post-secondary" ///
                    2 "Post-secondary or more" ///
                    3 "Missing"
					
// Respondent education
gen edu_respondent_cat = .
replace edu_respondent_cat = 1 if eisced_grouped >= 1 & eisced_grouped <= 2
replace edu_respondent_cat = 2 if eisced_grouped >= 3 & eisced_grouped <= 4
replace edu_respondent_cat = 3 if eisced_grouped == 0
replace edu_respondent_cat = 3 if eisced_grouped == .

label values edu_respondent_cat edu_cat
tab edu_respondent_cat

// Spouse education
gen edu_spouse_cat = .
replace edu_spouse_cat = 1 if eiscedp_grouped >= 1 & eiscedp_grouped <= 2
replace edu_spouse_cat = 2 if eiscedp_grouped >= 3 & eiscedp_grouped <= 4
replace edu_spouse_cat = 3 if eiscedp_grouped == 0
replace edu_spouse_cat = 3 if eiscedp_grouped == .

label values edu_spouse_cat edu_cat

// Mother's education
gen edu_mother_cat = .
replace edu_mother_cat = 1 if eiscedm_grouped >= 1 & eiscedm_grouped <= 2
replace edu_mother_cat = 2 if eiscedm_grouped >= 3 & eiscedm_grouped <= 4
replace edu_mother_cat = 3 if eiscedm_grouped == .
replace edu_mother_cat = 3 if eiscedm_grouped == 0

label values edu_mother_cat edu_cat

*_______________________________________________________________________*

*other education level variable recode to harmonize

*edulvla & edulvlb
	replace edu_respondent_cat=1 if edulvla<=3
	replace edu_respondent_cat=2 if edulvla > 3 & edulvla <= 5
	replace edu_respondent_cat=1 if edulvlb >=0 & edulvlb<=423
	replace edu_respondent_cat=2 if inlist(edulvlb, 510, 520, 610, 620, 710, 720, 800)
	replace edu_respondent_cat=1 if eisced_grouped==2
	replace edu_respondent_cat=2 if eisced_grouped==3	

*country-specific mother's education
	replace edu_mother_cat=1 if edulvlma >=1 & edulvlma<=3
	replace edu_mother_cat=2 if edulvlma >3 & edulvlma<=55	
	replace edu_mother_cat=1 if edumade1 <=3
	replace edu_mother_cat=2 if edumade1 >=4 & edumade1 <=5
	replace edu_mother_cat=1 if edumbde1 <=4
	replace edu_mother_cat=2 if edumbde1 >=5 & edumbde1 <=6
	replace edu_mother_cat=1 if edumcde1 <=5
	replace edu_mother_cat=2 if edumde2 <=9
	replace edu_mother_cat=1 if edumade2 <=4
	replace edu_mother_cat=2 if edumade2 >=5 & edumbde1 <=9
	replace edu_mother_cat=1 if edumbde2 <=13
	replace edu_mother_cat=2 if edumbde2 >=14 & edumbde2 <=18
	replace edu_mother_cat=1 if edumgb1 <=5
	replace edu_mother_cat=1 if edumagb1 <=5	
	replace edu_mother_cat=1 if edumbgb1 <=5	
	replace edu_mother_cat=1 if edumcgb1 <=5
	replace edu_mother_cat=2 if edumgb2 <=6
	replace edu_mother_cat=2 if edumagb2 <=6
	replace edu_mother_cat=2 if edumbgb2 <=6	
	replace edu_mother_cat=1 if eiscedm_grouped>=1 & eiscedm_grouped<=2
	replace edu_mother_cat=2 if eiscedm_grouped==3
	
*country_specific respondent education
	replace edu_respondent_cat=2 if edupl2==0 & edu_respondent_cat==3
	replace edu_respondent_cat=1 if edugb1!=. & edu_respondent_cat==3
	replace edu_respondent_cat=1 if eduagb1!=. & edu_respondent_cat==3
	replace edu_respondent_cat=1 if edubgb1!=. & edu_respondent_cat==3
	replace edu_respondent_cat=1 if educgb1!=. & edu_respondent_cat==3
	replace edu_respondent_cat=1 if edude2==0 & edu_respondent_cat==3
	replace edu_respondent_cat=1 if eduade2==0 & edu_respondent_cat==3

*country_specific partner education
	replace edu_spouse_cat=1 if edupade1<=3 & edu_spouse_cat==3
	replace edu_spouse_cat=2 if edupade1==4 & edu_spouse_cat==3
	replace edu_spouse_cat=2 if edupade1==5 & edu_spouse_cat==3
	replace edu_spouse_cat=1 if edupbde1<=4 & edu_spouse_cat==3
	replace edu_spouse_cat=1 if edupdde1<=3 & edu_spouse_cat==3
	replace edu_spouse_cat=2 if edupdde1==4 
	replace edu_spouse_cat=2 if edupdde1==5 
	replace edu_spouse_cat=2 if edupde2==0
	replace edu_spouse_cat=1 if edupgb1<=6
	replace edu_spouse_cat=1 if edupcgb1<=6
	replace edu_spouse_cat=1 if eiscedp_grouped>=1 & eiscedp_grouped<=2
	replace edu_spouse_cat=2 if eiscedp_grouped>=3 & eiscedp_grouped<=4


tab edu_mother_cat, m
tab edu_spouse_cat, m
tab edu_respondent_cat, m	


*recode missing values in edu_respondent for which we have eduyrs values that correspond to the categorie
tab edu_respondent_cat eduyrs, m
replace edu_respondent_cat = 1 ///
	if edu_respondent_cat == 3 & eduyrs <= 14

replace edu_respondent_cat = 2 ///
    if edu_respondent_cat == 3 & eduyrs >= 16 & eduyrs <= 80

 * I now need to correct discordance with education - respondents who are themselves doctors should have MA/PhD education, there are a few observations for whom this is not the case: Some responded that their education is post-secondary, but should be MA/PhD 
 
 
tab med_prof edu_respondent_cat, m
tab med_prof_spouse edu_spouse_cat, m
 
/*  
                      |        edu_respondent_cat
             med_prof | Less than  Post-seco    Missing |     Total
----------------------+---------------------------------+----------
Not Medical Practitio |   351,829    173,446      3,448 |   528,723 
 Medical Practitioner |        57      1,919         12 |     1,988 
----------------------+---------------------------------+----------
                Total |   351,886    175,365      3,460 |   530,711 

. tab med_prof_spouse edu_spouse_cat, m

                      |          edu_spouse_cat
      med_prof_spouse | Less than  Post-seco    Missing |     Total
----------------------+---------------------------------+----------
Not Medical Practitio |   196,849    101,606    231,060 |   529,515 
Medical Practitioner  |         6      1,187          3 |     1,196 
----------------------+---------------------------------+----------
                Total |   196,855    102,793    231,063 |   530,711 


				*/
				
replace edu_respondent_cat = 2 if med_prof == 1		
*59 changes		 
replace edu_spouse_cat = 2 if med_prof_spouse == 1 
*9 changes
	
*_______________________________________________________________________*


*Modelling concordance: eductional concordance, occupational concordance and medical professional concordance variables: 

*1. educational concordance
* Step 1: Create helper variables to flag post-secondary status
gen own_postsec = .
replace own_postsec = 0 if edu_respondent_cat==1
replace own_postsec = 1 if edu_respondent_cat==2

gen partner_postsec = .
replace partner_postsec = 0 if edu_spouse_cat==1
replace partner_postsec = 1 if edu_spouse_cat==2

* Step 2: Create the educational concordance variable
gen edu_concordance = .

* Category 1: respondent < post-sec, partner ≥ post-sec
replace edu_concordance = 1 if own_postsec == 0 & partner_postsec == 1

* Category 2: respondent ≥ post-sec, partner < post-sec
replace edu_concordance = 2 if own_postsec == 1 & partner_postsec == 0

* Category 3: both < post-sec
replace edu_concordance = 3 if own_postsec == 0 & partner_postsec == 0

* Category 4: both ≥ post-sec
replace edu_concordance = 4 if own_postsec == 1 & partner_postsec == 1

* Step 3: Label the variable and its values
label define edu_concord 1 "Resp < PSec, Part ≥ PSec" ///
                         2 "Resp ≥ PSec, Part < PSec" ///
                         3 "Both < PSec" ///
                         4 "Both ≥ PSec"

label values edu_concordance edu_concord
label variable edu_concordance "Educational Concordance (Respondent vs Partner)"

tab edu_concordance, m

*2. occupational class concordance 

* Step 1: Create binary flags for high occupational class (Managers/Professionals only)
gen resp_occ_high = .
replace resp_occ_high = 1 if occclass_collapsed == 1
replace resp_occ_high = 0 if inrange(occclass_collapsed, 2, 6)

gen part_occ_high = .
replace part_occ_high = 1 if occclass_collapsed_partner == 1
replace part_occ_high = 0 if inrange(occclass_collapsed_partner, 2, 6)

* Step 2: Generate the concordance variable
gen occ_concordance = .

* Category 1: both high
replace occ_concordance = 1 if resp_occ_high == 1 & part_occ_high == 1

* Category 2: respondent high, partner low
replace occ_concordance = 2 if resp_occ_high == 1 & part_occ_high == 0

* Category 3: respondent low, partner high
replace occ_concordance = 3 if resp_occ_high == 0 & part_occ_high == 1

* Category 4: both low
replace occ_concordance = 4 if resp_occ_high == 0 & part_occ_high == 0

* Step 3: Label values and variable
label define occcon 1 "Both Managers/Professionals" ///
                    2 "Resp M/P, Partner Lower" ///
                    3 "Partner M/P, Resp Lower" ///
                    4 "Both Lower ISCO"

label values occ_concordance occcon
label variable occ_concordance "Occupational Class Concordance (Resp vs Partner)"

tab occ_concordance occclass_collapsed_partner, m
*Unfortunately, the variable absorbed the missing spousal categories into the low occupancy class - will need to think of a way to redo it so that there is an own category there 	
	

*3. medical practitioner concordance

* Strict concordance variable for medical practitioners only
gen med_concordance_strict = .

* 1. Both are medical practitioners
replace med_concordance_strict = 1 if med_prof == 1 & med_prof_spouse == 1

* 2. Respondent only
replace med_concordance_strict = 2 if med_prof == 1 & med_prof_spouse == 0

* 3. Partner only
replace med_concordance_strict = 3 if med_prof == 0 & med_prof_spouse == 1

* 4. Neither
replace med_concordance_strict = 4 if med_prof == 0 & med_prof_spouse == 0

* Label the values
label define medcon 1 "Both are medical practitioners" ///
                    2 "Only respondent is medical practitioner" ///
                    3 "Only partner is medical practitioner" ///
                    4 "Neither are medical practitioners"
label values med_concordance_strict medcon
label variable med_concordance_strict "Medical Practitioner Concordance (Strict)"

*4. medical professional concordance

* Lenient concordance variable for medical professionals (incl. nurses etc.)
gen med_concordance_lenient = .

* 1. Both are medical professionals
replace med_concordance_lenient = 1 if med_prof2 == 1 & med_prof_spouse2 == 1

* 2. Respondent only
replace med_concordance_lenient = 2 if med_prof2 == 1 & med_prof_spouse2 == 0

* 3. Partner only
replace med_concordance_lenient = 3 if med_prof2 == 0 & med_prof_spouse2 == 1

* 4. Neither
replace med_concordance_lenient = 4 if med_prof2 == 0 & med_prof_spouse2 == 0

* Label the values

label define medcon2 1 "Both are medical professionals" ///
                    2 "Only respondent is medical professional" ///
                    3 "Only partner is medical professional" ///
                    4 "Neither are medical professionals"
					
label values med_concordance_lenient medcon2
label variable med_concordance_lenient "Medical Professional Concordance (Lenient)"

*_______________________________________________________________________*

*testing occupational class 
tab occupational_class, m
tab occupational_classp, m
tab occclass_collapsed, m
tab occclass_collapsed_partner, m

	*works well with med_prof and med_prof_spouse variables, quite a large missingness with respect to partner's occupation (33%)
/*

. tab occupational_classp, m

                    occupational_classp |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                               Managers |     15,542        2.93        2.93
                          Professionals |     37,141        7.00        9.93
Technicians and Associate Professionals |     28,641        5.40       15.32
               Clerical Support Workers |     15,898        3.00       18.32
              Service and Sales Workers |     25,967        4.89       23.21
                   Agricultural Workers |      5,010        0.94       24.16
               Craft and Trades Workers |     25,161        4.74       28.90
                      Machine Operators |     14,571        2.75       31.64
                 Elementary Occupations |     10,349        1.95       33.59
                           Armed Forces |        835        0.16       33.75
                                      . |    351,596       66.25      100.00
----------------------------------------+-----------------------------------
                                  Total |    530,711      100.00

. tab occclass_collapsed, m

                     occclass_collapsed |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                 Managers/Professionals |    115,756       21.81       21.81
                   Technicians/Clerical |    112,217       21.14       42.96
                          Service/Sales |     77,596       14.62       57.58
          Agricultural/Crafts/Operators |    106,373       20.04       77.62
                 Elementary Occupations |     42,041        7.92       85.54
Occupational class not reported + Armed |     76,728       14.46      100.00
----------------------------------------+-----------------------------------
                                  Total |    530,711      100.00

. tab occclass_collapsed_partner, m

             occclass_collapsed_partner |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                 Managers/Professionals |     52,683        9.93        9.93
                   Technicians/Clerical |     44,539        8.39       18.32
                          Service/Sales |     25,967        4.89       23.21
          Agricultural/Crafts/Operators |     44,742        8.43       31.64
                 Elementary Occupations |     10,349        1.95       33.59
Occupational class not reported + Armed |    352,431       66.41      100.00
----------------------------------------+-----------------------------------
                                  Total |    530,711      100.00


*/
	

*_______________________________________________________________________*
* SUBJECTIVE HEALTH - recode from worst= 1 to best= 5 for easier interpretation

* Reverse the scale: 5 becomes 1, 4 becomes 2, etc.
clonevar subjective_health = health

* Reverse the scale: 1<->5, 2<->4, 3 stays the same
recode subjective_health (1=5) (2=4) (3=3) (4=2) (5=1) (7/9=.)

* Label the values
label define subjective_health_lbl ///
    1 "Very bad" ///
    2 "Bad" ///
    3 "Fair" ///
    4 "Good" ///
    5 "Very good"
label values subjective_health subjective_health_lbl

* Check your new variable
tab subjective_health, m
/*
subjective_ |      Freq.     Percent        Cum.
------------+-----------------------------------
   Very bad |      7,883        1.49        1.49
        Bad |     37,792        7.12        8.61
       Fair |    141,501       26.66       35.27
       Good |    220,208       41.49       76.76
  Very good |    122,375       23.06       99.82
          . |        952        0.18      100.00
------------+-----------------------------------
      Total |    530,711      100.00

 
	  
*/

*missingness is not substantial (0.18%), need to drop those without the value
*drop if subjective_health==.a
*drop if subjective_health==.b
*drop if subjective_health==.c

*will do this later


tab subjective_health med_prof_spouse, col

*Generate a new collapsed subjective health variable
gen health_binary = .
replace health_binary = 0 if inlist(subjective_health, 1, 2, 3)
replace health_binary = 1 if inlist(subjective_health, 4, 5)

label define health_binary_lbl 0 "Fair/Bad/Very Bad" 1 "Good/Very Good"
label values health_binary health_binary_lbl
label variable health_binary "Dichotomized self-rated health"




*_______________________________________________________________________*
* OTHER HEALTH OUTCOME VARIABLES

*Hampered in daily activities by illness/disability/infirmity/mental problem

tab hlthhmp, m 

/*
 Hampered in daily |
     activities by |
illness/disability |
 /infirmity/mental |
           problem |      Freq.     Percent        Cum.
-------------------+-----------------------------------
         Yes a lot |     32,673        6.16        6.16
Yes to some extent |    105,201       19.82       25.98
                No |    390,186       73.52       99.50
           Refusal |        381        0.07       99.57
        Don't know |      1,343        0.25       99.83
         No answer |        927        0.17      100.00
-------------------+-----------------------------------
             Total |    530,711      100.00

*/

*How happy are you 

tab happy, m 

/*
How happy are you |      Freq.     Percent        Cum.
------------------+-----------------------------------
Extremely unhappy |      4,087        0.77        0.77
                1 |      3,673        0.69        1.46
                2 |      7,708        1.45        2.91
                3 |     14,525        2.74        5.65
                4 |     18,045        3.40        9.05
                5 |     55,148       10.39       19.44
                6 |     47,265        8.91       28.35
                7 |     95,562       18.01       46.36
                8 |    142,727       26.89       73.25
                9 |     83,249       15.69       88.94
  Extremely happy |     55,356       10.43       99.37
          Refusal |        384        0.07       99.44
       Don't know |      2,229        0.42       99.86
        No answer |        753        0.14      100.00
------------------+-----------------------------------
            Total |    530,711      100.00

*/


*Small heatmap visualization of happiness vs subjective health

* First install heatplot if needed
*ssc install heatplot, replace

* Then plot
*heatplot happy subjective_health [pw=pspwght], ///
    xlabel(1 "Very bad" 2 "Bad" 3 "Fair" 4 "Good" 5 "Very good") ///
    ylabel(1 "Extremely unhappy" 10 "Extremely happy") ///
    title("Happiness vs Health (ESS)") ///
    color(Blues)
	
*_______________________________________________________________________*

*Problematic, but super interesting variables (only available in one round, so very low sample of respondents to these questions)

	* How likely not receive healthcare needed if become ill next 12 months (lknhlcn)
	* Provision of healthcare, how efficient (hlthcef)
	* People rely too much on doctors rather than themselves to keep healthy (pprlydc)


	/*
   How likely not |
   receive health |
   care needed if |
  become ill next |
        12 months |      Freq.     Percent        Cum.
------------------+-----------------------------------
Not at all likely |     16,096        3.03        3.03
  Not very likely |     23,041        4.34        7.37
           Likely |     10,502        1.98        9.35
      Very likely |      3,821        0.72       10.07
                . |    473,959       89.31       99.38
          Refusal |         27        0.01       99.38
       Don't know |      3,160        0.60       99.98
        No answer |        105        0.02      100.00
------------------+-----------------------------------
            Total |    530,711      100.00
			
			
  Provision of health |
  care, how efficient |      Freq.     Percent        Cum.
----------------------+-----------------------------------
Extremely inefficient |      2,222        0.42        0.42
                   01 |      1,947        0.37        0.79
                   02 |      3,748        0.71        1.49
                   03 |      5,833        1.10        2.59
                   04 |      5,797        1.09        3.68
                   05 |      9,411        1.77        5.46
                   06 |      6,799        1.28        6.74
                   07 |      8,652        1.63        8.37
                   08 |      7,463        1.41        9.77
                   09 |      2,357        0.44       10.22
  Extremely efficient |      1,160        0.22       10.44
                    . |    473,959       89.31       99.74
              Refusal |         23        0.00       99.75
           Don't know |      1,278        0.24       99.99
            No answer |         62        0.01      100.00
----------------------+-----------------------------------
                Total |    530,711      100.00

   People rely too much on |
       doctors rather than |
themselves to keep healthy |      Freq.     Percent        Cum.
---------------------------+-----------------------------------
            Agree strongly |      7,464        1.41        1.41
                     Agree |     23,188        4.37        5.78
Neither agree nor disagree |      9,609        1.81        7.59
                  Disagree |      5,628        1.06        8.65
         Disagree strongly |        646        0.12        8.77
                         . |    483,174       91.04       99.81
                   Refusal |          4        0.00       99.81
                Don't know |        951        0.18       99.99
                 No answer |         47        0.01      100.00
---------------------------+-----------------------------------
                     Total |    530,711      100.00
				
				
*/

*_______________________________________________________________________*
*INCOME

*check overlap between hinctnta and hinctnt

* Check how many cases have missing hinctnta but non-missing hinctnt
tabulate hinctnt if missing(hinctnta) & !missing(hinctnt)

* Create missingness flags
gen miss_hinctnta = missing(hinctnta)
gen miss_hinctnt  = missing(hinctnt)

* Cross-tab missingness patterns
tab miss_hinctnta miss_hinctnt

/*
miss_hinct |     miss_hinctnt
       nta |         0          1 |     Total
-----------+----------------------+----------
         0 |         0    311,468 |   311,468 
         1 |    92,177    127,066 |   219,243 
-----------+----------------------+----------
     Total |    92,177    438,534 |   530,711 

	 a large proportion of those missing in hinctnta variable overlap with an earlier version of the income variable hinctnt, so I will recode those who are missing in hinctnta but have a value in hinctnt into a new variable 
	 
*/

gen income_best = .

* Step 2: Use hinctnta where available
replace income_best = hinctnta if !missing(hinctnta)

* Step 3: Use hinctnt where hinctnta is missing but hinctnt is valid
replace income_best = hinctnt if missing(hinctnta) & !missing(hinctnt)

* Recode values 11 and 12 to 10 in income_best
recode income_best (11 12 = 10)

* Step 4: Check result
tab income_best


*generate a new quintile variable

recode income_best (1/2 = 1) (3/4 = 2) (5/6 = 3) (7/8 = 4) (9/10 = 5), gen(income_5_cat)

* Handle non-substantive responses if needed
replace income_5_cat = . if inlist(income_best, 77, 88, 99)
* Recode missing values (. or .a etc.)
replace income_5_cat = 6 if missing(income_5_cat)

* Add labels for clarity
label define income_5cat_lbl ///
    1 "Lowest income" ///
    2 "Low-middle income" ///
    3 "Middle income" ///
    4 "Upper-middle income" ///
    5 "Highest income" ///
    6 "Missing income value"

label values income_5_cat income_5cat_lbl

* Quick tab to check
tab income_5_cat, m

/*
           RECODE of |
         income_best |      Freq.     Percent        Cum.
---------------------+-----------------------------------
       Lowest income |     71,865       13.54       13.54
   Low-middle income |     89,848       16.93       30.47
       Middle income |     89,007       16.77       47.24
 Upper-middle income |     80,035       15.08       62.32
      Highest income |     72,890       13.73       76.06
Missing income value |    127,066       23.94      100.00
---------------------+-----------------------------------
               Total |    530,711      100.00

*/





*_______________________________________________________________________*
*AGE categorical 

gen miss_agea = missing(agea)
gen miss_age  = missing(age)

* Cross-tab missingness patterns
tab miss_age miss_agea
*the missing variables in agea do not correspond to non-missing values in age, so there is no reason to compute a new merged variable 
replace agea = age if missing(agea) & !missing(age)




recode agea (18/29=1) (30/39=2) (40/49=3) (50/59=4) (60/69=5) (70/79=6) (80/105=7), generate(age_category)

label define agecat_lbl3 1 "18-29" 2 "30-39" 3 "40-49" 4 "50-59" 5 "60-69" 6 "70-79" 7 "80+" 
label values age_category agecat_lbl3

*drop missing values
drop if age_category==.a
*drop those who are not adults
drop if agea < 18
*drop one observation that is not feasible 
drop if agea==123

tab age_category, m
*_______________________________________________________________________*
*household size categorical recode

* Recode hhmmb into categorical variable for household size
gen hh_size_cat = .
replace hh_size_cat = 1 if hhmmb == 1
replace hh_size_cat = 2 if hhmmb == 2
replace hh_size_cat = 3 if hhmmb == 3
replace hh_size_cat = 4 if hhmmb == 4
replace hh_size_cat = 5 if inrange(hhmmb, 5, 7)
replace hh_size_cat = 6 if inrange(hhmmb, 8, 24) & hhmmb != .

  label define hh_size_lbl 1 "1 member" 2 "2 members" 3 "3 members" 4 "4 members" 5 "5-7 members" 6 "8+ members"
  label values hh_size_cat hh_size_lbl
  
  tab hh_size_cat, m
  
  
 *checking crosstab between household size and whether or not a person has a medical professional spouse
  tab hh_size_cat med_prof_spouse, m
  
  /*
            |    med_prof_spouse
hh_size_cat | Not Medic  Medical P |     Total
------------+----------------------+----------
   1 member |   107,370          0 |   107,370 
  2 members |   175,045        442 |   175,487 
  3 members |    98,490        268 |    98,758 
  4 members |    91,262        319 |    91,581 
5-7 members |    52,799        165 |    52,964 
 8+ members |     2,931          2 |     2,933 
          . |     1,618          0 |     1,618 
------------+----------------------+----------
      Total |   529,515      1,196 |   530,711 


	  *this is good - there are no inconsistencies whereby a person who reported having a doctor spouse would live in a 1 member household
  */
 
 *will not be dropping people with household size = 1 yet 
*drop if hh_size_cat==1 
*drop if hh_size_cat==.

// Recode categories 5 and 6 to a single category: 5 = "5+ members"
replace hh_size_cat = 5 if hh_size_cat == 6

// Update the label definition to reflect the new categories
label define hh_size_lbl ///
    1 "1 member" ///
    2 "2 members" ///
    3 "3 members" ///
    4 "4 members" ///
    5 "5+ members", replace

// Reapply the updated labels
label values hh_size_cat hh_size_lbl

// Optional: relabel the variable
label variable hh_size_cat "Household size (1–4, 5+)"

gen household_size = hh_size_cat
replace household_size = . if hh_size_cat==1 
replace household_size = . if hh_size_cat==.

// Recode remaining categories downward
recode household_size (2=1) (3=2) (4=3) (5=4)

// Update value labels accordingly
label define hh_size_lbl ///
    1 "2 members" ///
    2 "3 members" ///
    3 "4 members" ///
    4 "5+ members", replace

label values household_size hh_size_lbl
label variable household_size "Household size (2+ only, recoded)"

  
  
  
 *_______________________________________________________________________*
*WELFARE REGIME NEW VARIABLE CODING

*Now I will make a variable for welfare regime types

// Create the new variable with a default missing value
gen welfare_regime = .

// Assign welfare regime categories based on country codes

// Social Democratic (Nordic) Regime
replace welfare_regime = 1 if inlist(cntry, "DK", "FI", "IS", "NO", "SE")

// Conservative (Continental) Regime
replace welfare_regime = 2 if inlist(cntry, "AT", "BE", "FR", "DE", "LU", "NL", "CH")

// Liberal (Anglo-Saxon) Regime
replace welfare_regime = 3 if inlist(cntry, "IE", "GB")

// Mediterranean (Southern European) Regime
replace welfare_regime = 4 if inlist(cntry, "CY", "GR", "IT", "PT", "ES")

// Post-Communist (Eastern European) Regime
replace welfare_regime = 5 if inlist(cntry, "BG", "CZ", "EE", "HR", "HU")
replace welfare_regime = 5 if inlist(cntry, "LV", "LT", "PL", "RO", "SI", "SK")

// Hybrid or Mixed Regime
replace welfare_regime = 6 if inlist(cntry, "IL", "MT", "TR", "GE", "RU", "XK", "RS", "UA")

*this category includes countries : Israel, Malta, Turkey, Georgia, Russian Federation, Kosovo, Serbia, Ukraine - we may want to exclude this category - because the countries were either only part of a single round inclusion (i.e. Georgia) or cannot be classified into EU-28 countries 

// Label the welfare regime categories for clarity
label define welfare_lbl 1 "Social Democratic" ///
                         2 "Conservative" ///
                         3 "Liberal" ///
                         4 "Mediterranean" ///
                         5 "Post-Communist" ///
                         6 "Hybrid"
label values welfare_regime welfare_lbl
  
tab cntry if missing(welfare_regime)

/*

    Country |      Freq.     Percent        Cum.
------------+-----------------------------------
         AL |        644       26.55       26.55
         ME |      1,077       44.39       70.94
         MK |        705       29.06      100.00
------------+-----------------------------------
      Total |      2,426      100.00
	  
	  Looks like we have some issues whereby our welfare regime is not picking up three countries. I will assign these in the post-comunist countries

  */
  
replace welfare_regime = 5 if inlist(cntry, "AL", "ME", "MK")


*recoding of welfare regime - there were some errors for post-comunist countries: 

replace welfare_regime = 5 if inlist(cntry, "RS", "RU", "UA", "XK")



 *_______________________________________________________________________*

*recode Israel into 'liberal' or 'mediterraneal welfare regime 

/*
Some researchers (e.g., Ayalon, 2011) argue that Israel shares similarities with Southern European or Mediterranean regimes:

Strong role of family and religion.

Fragmented social insurance.

Weak state redistribution.

In cross-national comparative work, some ESS-based classifications (e.g., Arts & Gelissen 2002; Bambra 2007) occasionally cluster Israel near the Mediterranean group.

BUT - borderline between Med and Liberal (if we try to infer based on EA's key dimensions:

Liberal elements: means-tested assistance, strong role of private provision, market orientation.

Social Democratic elements: universal healthcare, relatively high female labor force participation.

Conservative elements: familialism and certain religious/occupational segmentation.

It mixes elements of all three — but overall leans toward Liberal, because of its relatively residual welfare approach and reliance on targeted benefits.)
*/

* I also need to recode Turkey into mediteranean regime 

replace welfare_regime = 3 if cntry == "IL"

replace welfare_regime = 4 if cntry == "TR"


 *_______________________________________________________________________*

*now we double check the countries in our data and remove any for which we do not have sufficient observations (i.e. <10) - not done yet

tab cntry, m

encode cntry, gen(cntry_id)

/*
Country	Freq.	Percent	Cum.
			
AL	456	0.52	0.52
AT	1,765	2.03	2.55
BE	3,747	4.30	6.85
BG	2,130	2.44	9.29
CH	3,365	3.86	13.16
CY	969	1.11	14.27
CZ	3,541	4.06	18.33
DE	5,491	6.30	24.64
DK	2,267	2.60	27.24
EE	2,247	2.58	29.82
ES	3,616	4.15	33.97
FI	2,638	3.03	36.99
FR	3,704	4.25	41.25
GB	2,907	3.34	44.58
GR	1,401	1.61	46.19
HR	2,194	2.52	48.71
HU	2,723	3.13	51.83
IE	3,925	4.50	56.34
IL	3,333	3.83	60.16
IS	1,103	1.27	61.43
IT	2,704	3.10	64.53
LT	2,671	3.07	67.60
LU	1	0.00	67.60
LV	587	0.67	68.27
ME	615	0.71	68.98
MK	517	0.59	69.57
NL	4,007	4.60	74.17
NO	3,092	3.55	77.72
PL	3,472	3.98	81.71
PT	2,750	3.16	84.86
RO	736	0.84	85.71
RS	778	0.89	86.60
RU	2,255	2.59	89.19
SE	2,099	2.41	91.60
SI	2,714	3.11	94.71
SK	2,473	2.84	97.55
UA	1,512	1.74	99.28
XK	623	0.72	100.00
			
Total	87,128	100.00

*/


*_______________________________________________________________________*

*generating income inequality index	- the values do not change much over the 20 year period, but I may do a time-varying version at a later date , but if we use the quintile version, small changes over time do not generally shift overall levels of positional inequality (i.e. a country in the highest inequality quintile is likely to remain there, even if the values change slightly over the survey period, since inequality generally increases everywhere - relative position within EU stays the same). 
gen gini = .

replace gini = 29.4 if cntry == "AL"
replace gini = 30.9 if cntry == "AT"
replace gini = 26.4 if cntry == "BE"
replace gini = 38.2 if cntry == "BG"
replace gini = 33.8 if cntry == "CH"
replace gini = 31.5 if cntry == "CY"
replace gini = 25.9 if cntry == "CZ"
replace gini = 32.4 if cntry == "DE"
replace gini = 29.3 if cntry == "DK"
replace gini = 32.3 if cntry == "EE"
replace gini = 33.6 if cntry == "ES"
replace gini = 27.9 if cntry == "FI"
replace gini = 31.2 if cntry == "FR"
replace gini = 32.4 if cntry == "GB"
replace gini = 33.4 if cntry == "GR"
replace gini = 30.0 if cntry == "HR"
replace gini = 30.2 if cntry == "HU"
replace gini = 29.9 if cntry == "IE"
replace gini = 26.6 if cntry == "IS"
replace gini = 33.7 if cntry == "IT"
replace gini = 36.6 if cntry == "LT"
replace gini = 34.3 if cntry == "ME"
replace gini = 33.5 if cntry == "MK"
replace gini = 25.7 if cntry == "NL"
replace gini = 26.9 if cntry == "NO"
replace gini = 28.9 if cntry == "PL"
replace gini = 36.3 if cntry == "PT"
replace gini = 32.8 if cntry == "RS"
replace gini = 35.1 if cntry == "RU"
replace gini = 31.6 if cntry == "SE"
replace gini = 24.3 if cntry == "SI"
replace gini = 24.1 if cntry == "SK"
replace gini = 25.6 if cntry == "UA"
replace gini = 34.3 if cntry == "XK"
replace gini = 37.9 if cntry == "IL"
replace gini = 34.2 if cntry == "LV"	
replace gini = 30.6 if cntry == "LU"	

*GINI quintiles
egen gini_quintile = cut(gini), group(5)
label define gini_q_lbl 0 "1 (Lowest inequality)" 1 "2" 2 "3" 3 "4" 4 "5 (Highest inequality)"
label values gini_quintile gini_q_lbl

*_______________________________________________________________________*

*additional drops (missing + doctor respondents)

*drop if income_5_cat==6
*drop if med_prof==1



gen medprof_edu_concordance = .

* 1. Both med profs, both post-sec ed
replace medprof_edu_concordance = 1 if med_prof == 1 & med_prof_spouse == 1 ///
    & inrange(eisced_grouped, 3, 4) & inrange(eiscedp_grouped, 3, 4)

* 2. Only spouse med prof, both post-sec ed
replace medprof_edu_concordance = 2 if med_prof == 0 & med_prof_spouse == 1 ///
    & inrange(eisced_grouped, 3, 4) & inrange(eiscedp_grouped, 3, 4)

* 3. Only respondent med prof, both post-sec ed
replace medprof_edu_concordance = 3 if med_prof == 1 & med_prof_spouse == 0 ///
    & inrange(eisced_grouped, 3, 4) & inrange(eiscedp_grouped, 3, 4)

* 4. Only spouse med prof, respondent lower ed
replace medprof_edu_concordance = 4 if med_prof == 0 & med_prof_spouse == 1 ///
    & inlist(eisced_grouped, 1, 2) & inrange(eiscedp_grouped, 3, 4)

* 5. Only respondent med prof, partner lower ed
replace medprof_edu_concordance = 5 if med_prof == 1 & med_prof_spouse == 0 ///
    & inlist(eiscedp_grouped, 1, 2) & inrange(eisced_grouped, 3, 4)

* 6. Neither med prof, both post-sec ed
replace medprof_edu_concordance = 6 if med_prof == 0 & med_prof_spouse == 0 ///
    & inrange(eisced_grouped, 3, 4) & inrange(eiscedp_grouped, 3, 4)

* 7. Neither med prof, both lower ed
replace medprof_edu_concordance = 7 if med_prof == 0 & med_prof_spouse == 0 ///
    & inlist(eisced_grouped, 1, 2) & inlist(eiscedp_grouped, 1, 2)

* 8. Neither med prof, respondent post-sec, partner lower ed
replace medprof_edu_concordance = 8 if med_prof == 0 & med_prof_spouse == 0 ///
    & inrange(eisced_grouped, 3, 4) & inlist(eiscedp_grouped, 1, 2)

* 9. Neither med prof, respondent lower ed, partner post-sec
replace medprof_edu_concordance = 9 if med_prof == 0 & med_prof_spouse == 0 ///
    & inlist(eisced_grouped, 1, 2) & inrange(eiscedp_grouped, 3, 4)

label define medprofedu_lbl ///
    1 "Both med profs, both post-sec ed" ///
    2 "Only spouse med prof, both post-sec ed" ///
    3 "Only respondent med prof, both post-sec ed" ///
    4 "Only spouse med prof, respondent lower ed" ///
    5 "Only respondent med prof, partner lower ed" ///
    6 "Neither med profs, both post-sec ed" ///
    7 "Neither med profs, both lower ed" ///
    8 "Neither med profs, resp post-sec, partner lower ed" ///
    9 "Neither med profs, resp lower ed, partner post-sec"

label values medprof_edu_concordance medprofedu_lbl

  replace medprof_edu_concordance = 10 if missing(medprof_edu_concordance)
  label define medprofedu_lbl 10 "Missing or unclassified", add
  
  * note: I did some explorations as to why the 10 missing category is so large, and realized that sometimes there are cases in which i.e. we have educational attainment missing for spouses of doctors or own education of respondent missing for doctor spouses ( + lots of non-harmonizable missingness for individuals in couples where neither is a doctor). Unfortunately there is not much imputation to be done in this case - we simply don't know the educational level of these people. 
 
  *Setting up analytical sample (drops)
  
*need to drop individuals who are not married/cohabiting 

tab new_marital_status, m


/*

      Marital Status: 1 = Married/Civil |
   Partnership/Living with partner, 0 = |
                              Not Marri |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
Not Married/Civil Partnership/living wi |    236,911       44.64       44.64
Married/Civil Partnership/living with p |    293,800       55.36      100.00
----------------------------------------+-----------------------------------
                                  Total |    530,711      100.00

*/

tab new_marital_status med_prof_spouse, m
*there are individuals for whom we have a flag that they have a medical professional spouse, but yet were misclassified as 'not married'. Need to remedy this
replace new_marital_status=1 if med_prof_spouse==1

drop if new_marital_status==0
*(236,698 observations deleted)

*Note that marital status was recoded so that the variable captures also people living with their partners, not just those who are married/in civil partnership 


*need to drop individuals with missing value for our main outcome variable - subjective health 

tab subjective_health, m
*missingness is not substantial (0.18%)

/*

 Subjective |
    general |
     health |      Freq.     Percent        Cum.
------------+-----------------------------------
   Very bad |      3,469        1.18        1.18
        Bad |     18,160        6.18        7.36
       Fair |     79,996       27.23       34.59
       Good |    128,802       43.84       78.43
  Very good |     63,011       21.45       99.88
         .a |         67        0.02       99.90
         .b |        233        0.08       99.98
         .c |         62        0.02      100.00
------------+-----------------------------------
      Total |    293,800      100.00

*/

drop if subjective_health==.a
drop if subjective_health==.b
drop if subjective_health==.c

*362 observations deleted
	
    *_______________________________________________________________________*
  
  *Double-checking all of our main variables and potential missingness
  
  *overall sample 
  
	tab subjective_health med_prof_spouse, m
    tab gender med_prof_spouse, m
    tab age_category med_prof_spouse, m
    tab wkhtot_cat med_prof_spouse, m
    tab wkhtot_cat_partner med_prof_spouse, m
    tab edu_respondent_cat med_prof_spouse, m
			*there is very little missingness in the edu_respondent_cat variable (less than 0.0007%, or only 196 people in the control group + 0 in treatment group,) and so the missingness category is not necessary for such a small sample of observations 
			drop if edu_respondent_cat==3
			*196 observations dropped

	tab edu_spouse_cat med_prof_spouse, m 
	tab edu_mother_cat med_prof_spouse, m 
			*both have much more substantial missingness than in the respondent education, so will keep the observations in a separate missing category
  
	tab edu_concordance med_prof_spouse, m 
	*there are 14,055 missing in the variable, since those are folks that do not have reported educational attainment for their spouses (currently coded as missing in my partner education variable). If I want to use this variable in my current analytical sample, I need to create an additional category for missingness here 
		
		
		drop if edu_concordance==.
		*Label the variable and its values

	tab occclass_collapsed med_prof_spouse, m 
	tab occclass_collapsed_partner med_prof_spouse, m 
	tab occ_concordance med_prof_spouse, m 
	tab income_5_cat med_prof_spouse, m 
		*income quintile variable was coded before we had some attrition, so the quintiles represented the overall ESS study sample, not our analytical sample - will need to recode a new income quintile variable now that we have a final analytical sample - since we had more drops from individuals from the lowest income category during our analytical sample refinement 
	
		*generate a new quintile variable, since after drops, our 10 category or 5 category income variable is not correct - 10 categories are not evenly spacedand I want empirical quintiles

		xtile income_quintile = income_best if !missing(income_best), nq(5)
		replace income_quintile=6 if income_best==.

		label define inc_q 1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 (highest)" 6 "Missing", replace
		label values income_quintile inc_q
		tab income_quintile, m	
		tab income_quintile income_best, m
		tab income_quintile med_prof_spouse, m
				
		recode income_best (1/2 = 1) (3/4 = 2) (5/6 = 3) (7/8 = 4) (9/10 = 5), gen(income_6)
		replace income_6 = . if inlist(income_best, 77, 88, 99)
		replace income_6 = 6 if missing(income_6)
		label values income_6 income_5cat_lbl
		tab income_6, m

		*The original income variable was initially coded into deciles. I recoded it into quintiles during my data cleaning and variable preparation. At the end of this process, I did my missingness handling and drops to get my final analytical sample. As such, the variable no longer looks like quintiles. I am undecided if this is better than recoding it into quintile after the analytical sample was finalized. This version is more representative of income inequality in the broader society, as opposed to income inequality within the analytical sample only. 
		
	
	tab household_size med_prof_spouse, m 
		*there is some missingness in the household size variable, but not very significant (0.01%), so will be deleting these observations 
		drop if household_size==.
		*(3,166 observations deleted)
	
	tab children_home med_prof_spouse, m 
	tab welfare_regime med_prof_spouse, m 
	tab gini_quintile med_prof_spouse, m
  
svy: tab subjective_health med_prof_spouse, row percent format(%5.1f)
svy: tab gender med_prof_spouse, row percent format(%5.1f)
svy: tab age_category med_prof_spouse, row percent format(%5.1f)
svy: tab wkhtot_cat med_prof_spouse, row percent format(%5.1f)
svy: tab wkhtot_cat_partner med_prof_spouse, row percent format(%5.1f)
svy: tab edu_respondent_cat med_prof_spouse, row percent format(%5.1f)
svy: tab edu_spouse_cat med_prof_spouse, row percent format(%5.1f)
svy: tab edu_mother_cat med_prof_spouse, row percent format(%5.1f)
svy: tab edu_concordance med_prof_spouse, row percent format(%5.1f)
svy: tab occclass_collapsed med_prof_spouse, row percent format(%5.1f)
svy: tab occclass_collapsed_partner med_prof_spouse, row percent format(%5.1f)
svy: tab occ_concordance med_prof_spouse, row percent format(%5.1f)
svy: tab income_5_cat med_prof_spouse, row percent format(%5.1f)
svy: tab household_size med_prof_spouse, row percent format(%5.1f)
svy: tab welfare_regime med_prof_spouse, row percent format(%5.1f)
svy: tab gini_quintile med_prof_spouse, row percent format(%5.1f)
svy: tab children_home med_prof_spouse, row percent format(%5.1f)
  
  *final analytical sample
  tab med_prof_spouse, m
/*
                med_prof_spouse |      Freq.     Percent        Cum.
--------------------------------+-----------------------------------
Not Medical Practitioner spouse |    242,774       99.63       99.63
    Medical Practitioner spouse |        902        0.37      100.00
--------------------------------+-----------------------------------
                          Total |    243,676      100.00
		  						  
*/

*_______________________________________________________________________*


mixed subjective_health ///
	i.gender ///
	i.edu_concordance##ib3.age_category ///
    i.edu_mother_cat ///
    ib5.income_5_cat ///
    i.household_size ///
    i.children_home ///
	ib4.wkhtot_cat ///
	ib4.wkhtot_cat_partner ///
	i.occ_concordance ///
	ib5.welfare_regime ///
	[pweight = norm_weight] ///
    || cntry:, vce(robust)
	
	testparm i.edu_concordance##i.age_category
	margins i.edu_concordance##i.age_category
	
	corr edu_concordance edu_respondent_cat

/*
takes a ridiculous time to run, but works well: 


Mixed-effects regression                            Number of obs    = 274,594
Group variable: cntry                               Number of groups =      39
                                                    Obs per group:
                                                                 min =     762
                                                                 avg = 7,040.9
                                                                 max =  16,825
                                                    Wald chi2(38)    =       .
Log pseudolikelihood =    -389230                   Prob > chi2      =       .

                                            (Std. err. adjusted for 39 clusters in cntry)
-----------------------------------------------------------------------------------------
                        |               Robust
      subjective_health | Coefficient  std. err.      z    P>|z|     [95% conf. interval]
------------------------+----------------------------------------------------------------
               1.gender |  -.0845549   .0128025    -6.60   0.000    -.1096473   -.0594625
                        |
        edu_concordance |
Resp ≥ PSec, Part < ..  |   .0677251   .0168065     4.03   0.000      .034785    .1006652
           Both < PSec  |  -.0281638   .0120456    -2.34   0.019    -.0517727   -.0045549
           Both ≥ PSec  |   .0941346   .0187171     5.03   0.000     .0574497    .1308195
                        |
           age_category |
                 18-29  |   .3700244   .0402957     9.18   0.000     .2910462    .4490026
                 30-39  |   .1801348   .0265286     6.79   0.000     .1281397    .2321298
                 50-59  |  -.1863448   .0246796    -7.55   0.000     -.234716   -.1379736
                 60-69  |  -.2796871   .0439499    -6.36   0.000    -.3658273   -.1935469
                 70-79  |  -.4224546   .0521102    -8.11   0.000    -.5245887   -.3203206
                   80+  |  -.4923901   .0783956    -6.28   0.000    -.6460426   -.3387376
                        |
        edu_concordance#|
           age_category |
Resp ≥ PSec, Part < .. #|
                 18-29  |  -.0642189   .0393358    -1.63   0.103    -.1413156    .0128779
Resp ≥ PSec, Part < .. #|
                 30-39  |   .0094492   .0293411     0.32   0.747    -.0480584    .0669568
Resp ≥ PSec, Part < .. #|
                 50-59  |  -.0085191   .0236144    -0.36   0.718    -.0548026    .0377643
Resp ≥ PSec, Part < .. #|
                 60-69  |  -.0154791   .0271832    -0.57   0.569    -.0687572    .0377989
Resp ≥ PSec, Part < .. #|
                 70-79  |  -.0462285   .0291137    -1.59   0.112    -.1032903    .0108334
Resp ≥ PSec, Part < .. #|
                   80+  |  -.1699122   .0640666    -2.65   0.008    -.2954805   -.0443438
     Both < PSec#18-29  |  -.0297839   .0351164    -0.85   0.396    -.0986108    .0390429
     Both < PSec#30-39  |   .0465138   .0218058     2.13   0.033     .0037752    .0892523
     Both < PSec#50-59  |   -.056434   .0187144    -3.02   0.003    -.0931135   -.0197545
     Both < PSec#60-69  |   -.112716   .0282504    -3.99   0.000    -.1680857   -.0573464
     Both < PSec#70-79  |  -.1315814   .0338779    -3.88   0.000    -.1979808   -.0651819
       Both < PSec#80+  |  -.1959482   .0691056    -2.84   0.005    -.3313926   -.0605037
     Both ≥ PSec#18-29  |   -.072875    .036891    -1.98   0.048    -.1451799     -.00057
     Both ≥ PSec#30-39  |  -.0105338   .0272227    -0.39   0.699    -.0638893    .0428217
     Both ≥ PSec#50-59  |   .0157018   .0237153     0.66   0.508    -.0307794    .0621829
     Both ≥ PSec#60-69  |  -.0107686   .0314525    -0.34   0.732    -.0724144    .0508771
     Both ≥ PSec#70-79  |  -.0160685   .0331889    -0.48   0.628    -.0811176    .0489805
       Both ≥ PSec#80+  |  -.1455331    .071924    -2.02   0.043    -.2865016   -.0045645
                        |
         edu_mother_cat |
Post-secondary or more  |   .0115448   .0103058     1.12   0.263    -.0086543    .0317438
               Missing  |  -.0784023    .010978    -7.14   0.000    -.0999188   -.0568857
                        |
           income_5_cat |
         Lowest income  |  -.3160426    .017507   -18.05   0.000    -.3503558   -.2817295
     Low-middle income  |  -.2058848   .0138885   -14.82   0.000    -.2331058   -.1786638
         Middle income  |  -.1205357   .0127894    -9.42   0.000    -.1456024    -.095469
   Upper-middle income  |   -.053646   .0109684    -4.89   0.000    -.0751437   -.0321484
  Missing income value  |   -.106464   .0152528    -6.98   0.000    -.1363591    -.076569
                        |
         household_size |
             3 members  |  -.0208562    .014462    -1.44   0.149    -.0492012    .0074888
             4 members  |  -.0047198   .0138846    -0.34   0.734     -.031933    .0224934
            5+ members  |  -.0216955   .0138015    -1.57   0.116     -.048746    .0053549
                        |
          children_home |
Respondent does not ..  |  -.0057063   .0170739    -0.33   0.738    -.0391705    .0277579
               Missing  |   .0831923   .0259342     3.21   0.001     .0323622    .1340224
                        |
             wkhtot_cat |
               <15 hrs  |  -.0046264   .0132366    -0.35   0.727    -.0305697    .0213168
             15–29 hrs  |  -.0238856   .0145127    -1.65   0.100      -.05233    .0045587
             30–35 hrs  |   .0043309    .015757     0.27   0.783    -.0265522    .0352139
             46–55 hrs  |  -.0190712    .006793    -2.81   0.005    -.0323852   -.0057573
               >55 hrs  |  -.0458256   .0091384    -5.01   0.000    -.0637366   -.0279147
  Missing/Not reported  |   -.041208   .0091924    -4.48   0.000    -.0592247   -.0231913
                        |
     wkhtot_cat_partner |
               <15 hrs  |   .0096088   .0198579     0.48   0.628    -.0293119    .0485295
             15–29 hrs  |  -.0284324    .010442    -2.72   0.006    -.0488983   -.0079664
             30–35 hrs  |  -.0380805   .0086831    -4.39   0.000    -.0550991   -.0210619
             46–55 hrs  |    .010851   .0103665     1.05   0.295    -.0094671     .031169
               >55 hrs  |  -.0022658    .014256    -0.16   0.874     -.030207    .0256755
  Missing/Not reported  |  -.0485565   .0089521    -5.42   0.000    -.0661022   -.0310107
                        |
        occ_concordance |
Resp M/P, Partner Lo..  |  -.0271748   .0082517    -3.29   0.001    -.0433478   -.0110017
Partner M/P, Resp Lo..  |  -.0487101   .0109393    -4.45   0.000    -.0701508   -.0272694
       Both Lower ISCO  |  -.1105598   .0105202   -10.51   0.000     -.131179   -.0899405
                        |
         welfare_regime |
     Social Democratic  |    .328473   .0749185     4.38   0.000     .1816355    .4753105
          Conservative  |   .2344919     .08571     2.74   0.006     .0665034    .4024804
               Liberal  |   .4370142   .0977753     4.47   0.000     .2453782    .6286503
         Mediterranean  |   .2458423   .1184149     2.08   0.038     .0137534    .4779312
                        |
                  _cons |    3.98821   .0637356    62.57   0.000      3.86329     4.11313
-----------------------------------------------------------------------------------------

------------------------------------------------------------------------------
                             |               Robust           
  Random-effects parameters  |   Estimate   std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
cntry: Identity              |
                  var(_cons) |   .0445063   .0105267      .0279958    .0707537
-----------------------------+------------------------------------------------
               var(Residual) |   .6034125   .0170095      .5709786    .6376887
------------------------------------------------------------------------------

Warning: Sampling weights were specified only at the first level in a multilevel model.
         If these weights are indicative of overall and not conditional inclusion
         probabilities, then results may be biased.

Warning: Convergence not achieved.

.         
.         testparm i.edu_concordance##i.age_category

 ( 1)  [subjective_health]2.edu_concordance = 0
 ( 2)  [subjective_health]3.edu_concordance = 0
 ( 3)  [subjective_health]4.edu_concordance = 0
 ( 4)  [subjective_health]1.age_category = 0
 ( 5)  [subjective_health]2.age_category = 0
 ( 6)  [subjective_health]4.age_category = 0
 ( 7)  [subjective_health]5.age_category = 0
 ( 8)  [subjective_health]6.age_category = 0
 ( 9)  [subjective_health]7.age_category = 0
 (10)  [subjective_health]2.edu_concordance#1.age_category = 0
 (11)  [subjective_health]2.edu_concordance#2.age_category = 0
 (12)  [subjective_health]2.edu_concordance#4.age_category = 0
 (13)  [subjective_health]2.edu_concordance#5.age_category = 0
 (14)  [subjective_health]2.edu_concordance#6.age_category = 0
 (15)  [subjective_health]2.edu_concordance#7.age_category = 0
 (16)  [subjective_health]3.edu_concordance#1.age_category = 0
 (17)  [subjective_health]3.edu_concordance#2.age_category = 0
 (18)  [subjective_health]3.edu_concordance#4.age_category = 0
 (19)  [subjective_health]3.edu_concordance#5.age_category = 0
 (20)  [subjective_health]3.edu_concordance#6.age_category = 0
 (21)  [subjective_health]3.edu_concordance#7.age_category = 0
 (22)  [subjective_health]4.edu_concordance#1.age_category = 0
 (23)  [subjective_health]4.edu_concordance#2.age_category = 0
 (24)  [subjective_health]4.edu_concordance#4.age_category = 0
 (25)  [subjective_health]4.edu_concordance#5.age_category = 0
 (26)  [subjective_health]4.edu_concordance#6.age_category = 0
 (27)  [subjective_health]4.edu_concordance#7.age_category = 0

           chi2( 27) = 6658.06
         Prob > chi2 =    0.0000

.         margins i.edu_concordance##i.age_category

Predictive margins                                     Number of obs = 274,594
Model VCE: Robust

Expression: Linear prediction, fixed portion, predict()

-----------------------------------------------------------------------------------------
                        |            Delta-method
                        |     Margin   std. err.      z    P>|z|     [95% conf. interval]
------------------------+----------------------------------------------------------------
        edu_concordance |
Resp < PSec, Part ≥ ..  |   3.834273   .0325946   117.64   0.000     3.770388    3.898157
Resp ≥ PSec, Part < ..  |   3.886211   .0346682   112.10   0.000     3.818263     3.95416
           Both < PSec  |    3.76498   .0321178   117.22   0.000      3.70203     3.82793
           Both ≥ PSec  |   3.917792   .0330717   118.46   0.000     3.852972    3.982611
                        |
           age_category |
                 18-29  |   4.251849   .0410948   103.46   0.000     4.171305    4.332394
                 30-39  |   4.126688   .0379092   108.86   0.000     4.052387    4.200989
                 40-49  |   3.921647   .0348366   112.57   0.000     3.853368    3.989925
                 50-59  |   3.706057   .0354214   104.63   0.000     3.636632    3.775481
                 60-69  |   3.574793   .0387249    92.31   0.000     3.498893    3.650692
                 70-79  |   3.416663   .0455992    74.93   0.000      3.32729    3.506036
                   80+  |   3.268427   .0520027    62.85   0.000     3.166504     3.37035
                        |
        edu_concordance#|
           age_category |
Resp < PSec, Part ≥ .. #|
                 18-29  |   4.279319   .0451982    94.68   0.000     4.190732    4.367906
Resp < PSec, Part ≥ .. #|
                 30-39  |   4.089429   .0426223    95.95   0.000     4.005891    4.172967
Resp < PSec, Part ≥ .. #|
                 40-49  |   3.909295   .0361236   108.22   0.000     3.838494    3.980096
Resp < PSec, Part ≥ .. #|
                 50-59  |    3.72295   .0381693    97.54   0.000     3.648139     3.79776
Resp < PSec, Part ≥ .. #|
                 60-69  |   3.629608   .0472475    76.82   0.000     3.537004    3.722211
Resp < PSec, Part ≥ .. #|
                 70-79  |    3.48684   .0479732    72.68   0.000     3.392814    3.580866
Resp < PSec, Part ≥ .. #|
                   80+  |   3.416905   .0761857    44.85   0.000     3.267583    3.566226
Resp ≥ PSec, Part < .. #|
                 18-29  |   4.282825   .0403762   106.07   0.000     4.203689    4.361961
Resp ≥ PSec, Part < .. #|
                 30-39  |   4.166604   .0414113   100.62   0.000     4.085439    4.247768
Resp ≥ PSec, Part < .. #|
                 40-49  |    3.97702   .0389777   102.03   0.000     3.900625    4.053415
Resp ≥ PSec, Part < .. #|
                 50-59  |   3.782156   .0426607    88.66   0.000     3.698542    3.865769
Resp ≥ PSec, Part < .. #|
                 60-69  |   3.681854    .041265    89.22   0.000     3.600976    3.762731
Resp ≥ PSec, Part < .. #|
                 70-79  |   3.508337   .0487348    71.99   0.000     3.412818    3.603855
Resp ≥ PSec, Part < .. #|
                   80+  |   3.314718   .0615034    53.89   0.000     3.194173    3.435262
     Both < PSec#18-29  |   4.221371   .0454728    92.83   0.000     4.132246    4.310496
     Both < PSec#30-39  |   4.107779   .0396116   103.70   0.000     4.030142    4.185417
     Both < PSec#40-49  |   3.881131   .0350131   110.85   0.000     3.812506    3.949755
     Both < PSec#50-59  |   3.638352   .0343024   106.07   0.000      3.57112    3.705584
     Both < PSec#60-69  |   3.488728   .0397915    87.68   0.000     3.410738    3.566718
     Both < PSec#70-79  |   3.327095   .0463666    71.76   0.000     3.236218    3.417972
       Both < PSec#80+  |   3.192793   .0519419    61.47   0.000     3.090988    3.294597
     Both ≥ PSec#18-29  |   4.300579   .0373824   115.04   0.000      4.22731    4.373847
     Both ≥ PSec#30-39  |    4.17303   .0344155   121.25   0.000     4.105577    4.240483
     Both ≥ PSec#40-49  |   4.003429   .0363962   110.00   0.000     3.932094    4.074764
     Both ≥ PSec#50-59  |   3.832786   .0384309    99.73   0.000     3.757463    3.908109
     Both ≥ PSec#60-69  |   3.712973   .0405552    91.55   0.000     3.633487     3.79246
     Both ≥ PSec#70-79  |   3.564906   .0534362    66.71   0.000     3.460173    3.669639
       Both ≥ PSec#80+  |   3.365506   .0655053    51.38   0.000     3.237118    3.493894
-----------------------------------------------------------------------------------------


*/

mixed subjective_health ///
	i.gender ///
	i.edu_concordance##ib3.age_category ///
    i.edu_mother_cat ///
    ib5.income_5_cat ///
    i.children_home ///
	ib4.wkhtot_cat ///
	i.occclass_collapsed ///
	i.occclass_collapsed_partner ///
	[pweight = pspwght] ///
    || cntry:, vce(robust)
	
	testparm i.edu_concordance##i.age_category
	margins i.edu_concordance##i.age_category
/*
Mixed-effects regression                            Number of obs    = 274,594
Group variable: cntry                               Number of groups =      39
                                                    Obs per group:
                                                                 min =     762
                                                                 avg = 7,040.9
                                                                 max =  16,825
                                                    Wald chi2(38)    =       .
Log pseudolikelihood = -330782.68                   Prob > chi2      =       .

                                                     (Std. err. adjusted for 39 clusters in cntry)
--------------------------------------------------------------------------------------------------
                                 |               Robust
               subjective_health | Coefficient  std. err.      z    P>|z|     [95% conf. interval]
---------------------------------+----------------------------------------------------------------
                        1.gender |  -.0865334   .0108387    -7.98   0.000    -.1077768     -.06529
                                 |
                 edu_concordance |
       Resp ≥ PSec, Part < PSec  |   .0612275   .0150318     4.07   0.000     .0317657    .0906892
                    Both < PSec  |  -.0205665   .0101809    -2.02   0.043    -.0405208   -.0006123
                    Both ≥ PSec  |   .0790881   .0152013     5.20   0.000     .0492941    .1088821
                                 |
                    age_category |
                          18-29  |   .3417981   .0328351    10.41   0.000     .2774426    .4061537
                          30-39  |   .1740477   .0224985     7.74   0.000     .1299514     .218144
                          50-59  |  -.1867664   .0223279    -8.36   0.000    -.2305283   -.1430044
                          60-69  |  -.2787319   .0380559    -7.32   0.000    -.3533202   -.2041437
                          70-79  |  -.4277114   .0490022    -8.73   0.000    -.5237539   -.3316689
                            80+  |  -.4846988   .0705427    -6.87   0.000    -.6229599   -.3464377
                                 |
    edu_concordance#age_category |
 Resp ≥ PSec, Part < PSec#18-29  |  -.0412606   .0293586    -1.41   0.160    -.0988025    .0162812
 Resp ≥ PSec, Part < PSec#30-39  |   .0029474   .0235048     0.13   0.900    -.0431211    .0490159
 Resp ≥ PSec, Part < PSec#50-59  |  -.0195913   .0233432    -0.84   0.401    -.0653431    .0261604
 Resp ≥ PSec, Part < PSec#60-69  |  -.0140479   .0217265    -0.65   0.518     -.056631    .0285353
 Resp ≥ PSec, Part < PSec#70-79  |  -.0403221   .0274932    -1.47   0.142    -.0942078    .0135636
   Resp ≥ PSec, Part < PSec#80+  |  -.1816151   .0587703    -3.09   0.002    -.2968028   -.0664275
              Both < PSec#18-29  |  -.0012761   .0253479    -0.05   0.960    -.0509571     .048405
              Both < PSec#30-39  |   .0524485   .0159598     3.29   0.001      .021168    .0837291
              Both < PSec#50-59  |  -.0520575   .0167742    -3.10   0.002    -.0849343   -.0191807
              Both < PSec#60-69  |  -.0989653   .0230634    -4.29   0.000    -.1441687   -.0537619
              Both < PSec#70-79  |  -.1091613    .030408    -3.59   0.000    -.1687599   -.0495627
                Both < PSec#80+  |  -.2025351   .0624576    -3.24   0.001    -.3249497   -.0801204
              Both ≥ PSec#18-29  |  -.0491112   .0261428    -1.88   0.060    -.1003503    .0021278
              Both ≥ PSec#30-39  |  -.0100435   .0223624    -0.45   0.653     -.053873     .033786
              Both ≥ PSec#50-59  |   .0120022   .0206408     0.58   0.561    -.0284531    .0524575
              Both ≥ PSec#60-69  |  -.0006462   .0251719    -0.03   0.980    -.0499821    .0486897
              Both ≥ PSec#70-79  |    .006896   .0311762     0.22   0.825    -.0542081    .0680001
                Both ≥ PSec#80+  |  -.1440238   .0660167    -2.18   0.029    -.2734142   -.0146334
                                 |
                  edu_mother_cat |
         Post-secondary or more  |    .008404   .0092769     0.91   0.365    -.0097785    .0265865
                        Missing  |  -.0767255   .0085989    -8.92   0.000    -.0935791   -.0598719
                                 |
                    income_5_cat |
                  Lowest income  |  -.3040707   .0160994   -18.89   0.000    -.3356248   -.2725165
              Low-middle income  |  -.1911818   .0124168   -15.40   0.000    -.2155183   -.1668454
                  Middle income  |  -.1130266    .011512    -9.82   0.000    -.1355897   -.0904636
            Upper-middle income  |  -.0559393   .0091176    -6.14   0.000    -.0738095   -.0380692
           Missing income value  |  -.0999634   .0149614    -6.68   0.000    -.1292872   -.0706396
                                 |
                   children_home |
Respondent does not live with..  |  -.0043007   .0077854    -0.55   0.581    -.0195598    .0109583
                        Missing  |   .0810101   .0244782     3.31   0.001     .0330337    .1289865
                                 |
                      wkhtot_cat |
                        <15 hrs  |    .002105   .0124153     0.17   0.865    -.0222286    .0264386
                      15–29 hrs  |  -.0202902   .0154018    -1.32   0.188    -.0504772    .0098968
                      30–35 hrs  |  -.0032347   .0125977    -0.26   0.797    -.0279258    .0214564
                      46–55 hrs  |  -.0182349   .0068607    -2.66   0.008    -.0316817   -.0047881
                        >55 hrs  |  -.0432811   .0089331    -4.85   0.000    -.0607897   -.0257725
           Missing/Not reported  |  -.0502506   .0102026    -4.93   0.000    -.0702473   -.0302539
                                 |
              occclass_collapsed |
           Technicians/Clerical  |  -.0279448   .0057996    -4.82   0.000    -.0393118   -.0165778
                  Service/Sales  |  -.0687718   .0093577    -7.35   0.000    -.0871126    -.050431
  Agricultural/Crafts/Operators  |  -.1251047   .0069005   -18.13   0.000    -.1386295   -.1115799
         Elementary Occupations  |  -.1976586   .0111512   -17.73   0.000    -.2195146   -.1758026
Occupational class not report..  |   -.084402   .0116018    -7.27   0.000    -.1071411   -.0616629
                                 |
      occclass_collapsed_partner |
           Technicians/Clerical  |  -.0261315    .008145    -3.21   0.001    -.0420955   -.0101676
                  Service/Sales  |  -.0258505   .0090819    -2.85   0.004    -.0436507   -.0080502
  Agricultural/Crafts/Operators  |  -.0551714   .0089038    -6.20   0.000    -.0726226   -.0377203
         Elementary Occupations  |  -.1034105       .015    -6.89   0.000      -.13281    -.074011
Occupational class not report..  |  -.0878394   .0069055   -12.72   0.000     -.101374   -.0743049
                                 |
                           _cons |   4.143106   .0375605   110.30   0.000     4.069488    4.216723
--------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
                             |               Robust           
  Random-effects parameters  |   Estimate   std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
cntry: Identity              |
                  var(_cons) |   .0639391   .0154007      .0398788     .102516
-----------------------------+------------------------------------------------
               var(Residual) |   .6043328   .0163305      .5731584    .6372029
------------------------------------------------------------------------------

Warning: Sampling weights were specified only at the first level in a multilevel model. If these
         weights are indicative of overall and not conditional inclusion probabilities, then
         results may be biased.

.         
.         testparm i.edu_concordance##i.age_category

 ( 1)  [subjective_health]2.edu_concordance = 0
 ( 2)  [subjective_health]3.edu_concordance = 0
 ( 3)  [subjective_health]4.edu_concordance = 0
 ( 4)  [subjective_health]1.age_category = 0
 ( 5)  [subjective_health]2.age_category = 0
 ( 6)  [subjective_health]4.age_category = 0
 ( 7)  [subjective_health]5.age_category = 0
 ( 8)  [subjective_health]6.age_category = 0
 ( 9)  [subjective_health]7.age_category = 0
 (10)  [subjective_health]2.edu_concordance#1.age_category = 0
 (11)  [subjective_health]2.edu_concordance#2.age_category = 0
 (12)  [subjective_health]2.edu_concordance#4.age_category = 0
 (13)  [subjective_health]2.edu_concordance#5.age_category = 0
 (14)  [subjective_health]2.edu_concordance#6.age_category = 0
 (15)  [subjective_health]2.edu_concordance#7.age_category = 0
 (16)  [subjective_health]3.edu_concordance#1.age_category = 0
 (17)  [subjective_health]3.edu_concordance#2.age_category = 0
 (18)  [subjective_health]3.edu_concordance#4.age_category = 0
 (19)  [subjective_health]3.edu_concordance#5.age_category = 0
 (20)  [subjective_health]3.edu_concordance#6.age_category = 0
 (21)  [subjective_health]3.edu_concordance#7.age_category = 0
 (22)  [subjective_health]4.edu_concordance#1.age_category = 0
 (23)  [subjective_health]4.edu_concordance#2.age_category = 0
 (24)  [subjective_health]4.edu_concordance#4.age_category = 0
 (25)  [subjective_health]4.edu_concordance#5.age_category = 0
 (26)  [subjective_health]4.edu_concordance#6.age_category = 0
 (27)  [subjective_health]4.edu_concordance#7.age_category = 0

           chi2( 27) = 4606.23
         Prob > chi2 =    0.0000

.         margins i.edu_concordance##i.age_category

Predictive margins                                     Number of obs = 274,594
Model VCE: Robust

Expression: Linear prediction, fixed portion, predict()

-------------------------------------------------------------------------------------------------
                                |            Delta-method
                                |     Margin   std. err.      z    P>|z|     [95% conf. interval]
--------------------------------+----------------------------------------------------------------
                edu_concordance |
      Resp < PSec, Part ≥ PSec  |   3.789573   .0438018    86.52   0.000     3.703723    3.875423
      Resp ≥ PSec, Part < PSec  |    3.83285   .0434897    88.13   0.000     3.747611    3.918088
                   Both < PSec  |   3.735078    .041102    90.87   0.000     3.654519    3.815636
                   Both ≥ PSec  |     3.8622   .0437123    88.35   0.000     3.776525    3.947874
                                |
                   age_category |
                         18-29  |   4.209003   .0422665    99.58   0.000     4.126162    4.291844
                         30-39  |   4.084782   .0396031   103.14   0.000     4.007162    4.162403
                         40-49  |   3.883331    .040244    96.49   0.000     3.804455    3.962208
                         50-59  |   3.667792   .0454344    80.73   0.000     3.578742    3.756842
                         60-69  |   3.547702   .0522392    67.91   0.000     3.445315    3.650089
                         70-79  |   3.391489   .0612688    55.35   0.000     3.271404    3.511574
                           80+  |   3.233423   .0662373    48.82   0.000     3.103601    3.363246
                                |
   edu_concordance#age_category |
Resp < PSec, Part ≥ PSec#18-29  |   4.212376   .0463521    90.88   0.000     4.121527    4.303224
Resp < PSec, Part ≥ PSec#30-39  |   4.044625   .0457423    88.42   0.000     3.954972    4.134278
Resp < PSec, Part ≥ PSec#40-49  |   3.870577   .0396698    97.57   0.000     3.792826    3.948329
Resp < PSec, Part ≥ PSec#50-59  |   3.683811   .0485081    75.94   0.000     3.588737    3.778885
Resp < PSec, Part ≥ PSec#60-69  |   3.591846   .0582548    61.66   0.000     3.477668    3.706023
Resp < PSec, Part ≥ PSec#70-79  |   3.442866   .0644943    53.38   0.000      3.31646    3.569273
  Resp < PSec, Part ≥ PSec#80+  |   3.385879   .0833989    40.60   0.000      3.22242    3.549338
Resp ≥ PSec, Part < PSec#18-29  |   4.232342   .0406369   104.15   0.000     4.152695    4.311989
Resp ≥ PSec, Part < PSec#30-39  |     4.1088   .0402066   102.19   0.000     4.029997    4.187604
Resp ≥ PSec, Part < PSec#40-49  |   3.931805   .0426136    92.27   0.000     3.848284    4.015326
Resp ≥ PSec, Part < PSec#50-59  |   3.725447   .0479117    77.76   0.000     3.631542    3.819353
Resp ≥ PSec, Part < PSec#60-69  |   3.639025   .0537109    67.75   0.000     3.533754    3.744297
Resp ≥ PSec, Part < PSec#70-79  |   3.463772   .0641399    54.00   0.000      3.33806    3.589483
  Resp ≥ PSec, Part < PSec#80+  |   3.265491   .0758036    43.08   0.000     3.116919    3.414063
             Both < PSec#18-29  |   4.190533     .04586    91.38   0.000     4.100649    4.280417
             Both < PSec#30-39  |   4.076507   .0407175   100.12   0.000     3.996702    4.156312
             Both < PSec#40-49  |   3.850011   .0403062    95.52   0.000     3.771012     3.92901
             Both < PSec#50-59  |   3.611187   .0444988    81.15   0.000     3.523971    3.698403
             Both < PSec#60-69  |   3.472314   .0519835    66.80   0.000     3.370428      3.5742
             Both < PSec#70-79  |   3.313138   .0605187    54.75   0.000     3.194524    3.431753
               Both < PSec#80+  |   3.162777    .064034    49.39   0.000     3.037273    3.288281
             Both ≥ PSec#18-29  |   4.242352   .0388041   109.33   0.000     4.166298    4.318407
             Both ≥ PSec#30-39  |    4.11367   .0370026   111.17   0.000     4.041146    4.186194
             Both ≥ PSec#40-49  |   3.949666   .0420116    94.01   0.000     3.867324    4.032007
             Both ≥ PSec#50-59  |   3.774901   .0483692    78.04   0.000       3.6801    3.869703
             Both ≥ PSec#60-69  |   3.670287    .053686    68.37   0.000     3.565065     3.77551
             Both ≥ PSec#70-79  |    3.52885   .0680829    51.83   0.000      3.39541     3.66229
               Both ≥ PSec#80+  |   3.320943   .0806061    41.20   0.000     3.162958    3.478928
-------------------------------------------------------------------------------------------------

	
*/
	
*At the end, I use the margins generated to produe my graph in R studio quarto doc using the following code 

/* 

{r}
library(tidyverse)
library(ggridges)

# --- 1) Long, publication-friendly legend labels (with line breaks) ---
edu_levels <- c(
  "Resp < PSec, Part ≥ PSec",
  "Resp ≥ PSec, Part < PSec",
  "Both < PSec",
  "Both ≥ PSec"
)

edu_labels_long <- c(
  "Resp < PSec, Part ≥ PSec" = "Respondent's education < post-secondary\nPartner's education ≥ post-secondary",
  "Resp ≥ PSec, Part < PSec" = "Respondent's education ≥ post-secondary\nPartner's education < post-secondary",
  "Both < PSec"              = "Both partners' education < post-secondary",
  "Both ≥ PSec"              = "Both partners' education ≥ post-secondary"
)

# Optional: set specific fills so the legend is stable and readable
edu_fills <- c(
  "Resp < PSec, Part ≥ PSec" = "#F4A3A3",
  "Resp ≥ PSec, Part < PSec" = "#9FD3A7",
  "Both < PSec"              = "#7FB6FF",
  "Both ≥ PSec"              = "#B59BFF"
)

# --- 2) Your margins data (unchanged values) ---
margins_df <- tribble(
  ~edu_concordance, ~age_category, ~mean, ~ci_low, ~ci_high,

  "Resp < PSec, Part ≥ PSec", "18-29", 4.279319, 4.190732, 4.367906,
  "Resp < PSec, Part ≥ PSec", "30-39", 4.089429, 4.005891, 4.172967,
  "Resp < PSec, Part ≥ PSec", "40-49", 3.909295, 3.838494, 3.980096,
  "Resp < PSec, Part ≥ PSec", "50-59", 3.722950, 3.648139, 3.797760,
  "Resp < PSec, Part ≥ PSec", "60-69", 3.629608, 3.537004, 3.722211,
  "Resp < PSec, Part ≥ PSec", "70-79", 3.486840, 3.392814, 3.580866,
  "Resp < PSec, Part ≥ PSec", "80+",   3.416905, 3.267583, 3.566226,

  "Resp ≥ PSec, Part < PSec", "18-29", 4.282825, 4.203689, 4.361961,
  "Resp ≥ PSec, Part < PSec", "30-39", 4.166604, 4.085439, 4.247768,
  "Resp ≥ PSec, Part < PSec", "40-49", 3.977020, 3.900625, 4.053415,
  "Resp ≥ PSec, Part < PSec", "50-59", 3.782156, 3.698542, 3.865769,
  "Resp ≥ PSec, Part < PSec", "60-69", 3.681854, 3.600976, 3.762731,
  "Resp ≥ PSec, Part < PSec", "70-79", 3.508337, 3.412818, 3.603855,
  "Resp ≥ PSec, Part < PSec", "80+",   3.314718, 3.194173, 3.435262,

  "Both < PSec", "18-29", 4.221371, 4.132246, 4.310496,
  "Both < PSec", "30-39", 4.107779, 4.030142, 4.185417,
  "Both < PSec", "40-49", 3.881131, 3.812506, 3.949755,
  "Both < PSec", "50-59", 3.638352, 3.571120, 3.705584,
  "Both < PSec", "60-69", 3.488728, 3.410738, 3.566718,
  "Both < PSec", "70-79", 3.327095, 3.236218, 3.417972,
  "Both < PSec", "80+",   3.192793, 3.090988, 3.294597,

  "Both ≥ PSec", "18-29", 4.300579, 4.227310, 4.373847,
  "Both ≥ PSec", "30-39", 4.173030, 4.105577, 4.240483,
  "Both ≥ PSec", "40-49", 4.003429, 3.932094, 4.074764,
  "Both ≥ PSec", "50-59", 3.832786, 3.757463, 3.908109,
  "Both ≥ PSec", "60-69", 3.712973, 3.633487, 3.792460,
  "Both ≥ PSec", "70-79", 3.564906, 3.460173, 3.669639,
  "Both ≥ PSec", "80+",   3.365506, 3.237118, 3.493894
) %>%
  mutate(
    age_category = factor(
      age_category,
      levels = c("18-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80+")
    ),
    edu_concordance = factor(edu_concordance, levels = edu_levels)
  )

# --- 3) Simulate samples and truncate at CI bounds (same approach) ---
set.seed(123)
expanded_df <- margins_df %>%
  rowwise() %>%
  mutate(
    sd_est = (ci_high - ci_low) / (2 * 1.96),
    samples = list(rnorm(2000, mean, sd_est))
  ) %>%
  unnest(samples) %>%
  filter(samples >= ci_low & samples <= ci_high)

# --- 4) Plot ---
p <- ggplot(expanded_df, aes(x = samples, y = age_category, fill = edu_concordance)) +
  geom_density_ridges(
    alpha = 0.55,
    scale = 1.2,
    color = "navy",
    rel_min_height = 0.01
  ) +
  scale_fill_manual(
    values = edu_fills,
    breaks = edu_levels,
    labels = edu_labels_long
  ) +
  labs(
    title = "Educational Concordance, Age, and Self-Rated Health",
    x = "Predicted self-rated health (1 = poor, 5 = very good)",
    y = "Respondent's age",
    fill = "Educational concordance\nwithin the couple"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "top",
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 10),
    panel.grid.minor = element_blank(),
    axis.text.y = element_text(size = 10),
    axis.title.x = element_text(size = 12),
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5)
  ) +
  guides(fill = guide_legend(nrow = 4, byrow = TRUE))  # helps long legend fit nicely


p

ggsave(
  filename = "age_education_health_wide.png",
  plot = p,
  width = 10,
  height = 8,
  units = "in",
  dpi = 300
)

*/

