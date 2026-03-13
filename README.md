# Couples, Aging, and Diverging Health: Educational Concordance and Self-Rated Health in Europe

**Michaela Bunakova**  
McGill University  
*Socius: Sociological Research for a Dynamic World* — Data Visualization Special Collection

---

## Overview

This repository contains the Stata analysis code used to produce the data visualization considered for publication in *Socius*. The study examines how the *educational concordance* of romantic partnerships — the combined educational profile of both partners — relates to self-rated health across age groups in Europe.

Drawing on Fundamental Cause Theory (Link & Phelan, 1995), the analysis shows that education operates not only as an individual resource but as a shared household resource whose protective health effects may be amplified when both partners possess higher educational attainment — and whose absence compounds health disadvantage, particularly in older age groups.

---

## Repository Contents

| File | Description |
|------|-------------|
| `SOCIUS_concordance.do` | Main Stata do file: data cleaning, variable construction, analytical sample preparation, multilevel regression, and predictive margins |
| `README.md` | This file |

The visualization itself was produced in R (ggridges/ggplot2) using the predictive margins exported from the Stata model. The R code is included as a comment block at the end of the `.do` file.

---

## Data

**Source:** European Social Survey (ESS), Rounds 1–11 (2001–2023)  
**Access:** [europeansocialsurvey.org](https://www.europeansocialsurvey.org)  
**Coverage:** 39 European countries  
**Analytical sample:** N = 274,594 partnered respondents (married, in civil union, or cohabiting)

The raw ESS data are not included in this repository and must be downloaded directly from the ESS website. The do file assumes the full pooled dataset is saved as `ESS_data.dta`.

---

## Variables

### Outcome
- **Subjective self-rated health** (`subjective_health`): Five-point Likert scale (1 = Very bad, 5 = Very good), reverse-coded from the original ESS `health` variable for intuitive interpretation.

### Key Exposure
- **Educational concordance** (`edu_concordance`): A four-category variable capturing the joint educational profile of the couple:
  - *Both < post-secondary* — both partners have upper secondary education or less
  - *Respondent ≥ post-secondary, partner < post-secondary* — mixed (respondent higher)
  - *Respondent < post-secondary, partner ≥ post-secondary* — mixed (partner higher)
  - *Both ≥ post-secondary* — both partners have post-secondary education or higher

  Educational attainment is measured using the harmonized EISCED variable (ES-ISCED classification), collapsed into a binary: less than post-secondary vs. post-secondary or above. Country-specific and round-specific education variables (`edulvlpa`, `edulvlma`, `edulvla`, `edulvlb`) were used to fill missingness across earlier ESS rounds (2002–2006) where the standard `eiscedp`/`eiscedm` variables were not collected.

### Moderator
- **Age group** (`age_category`): Seven categories (18–29, 30–39, 40–49, 50–59, 60–69, 70–79, 80+). The interaction between educational concordance and age is the central focus of the visualization.

### Covariates (Level 1)
| Variable | Description |
|----------|-------------|
| `gender` | Binary (0 = male, 1 = female) |
| `edu_mother_cat` | Mother's educational attainment (3 categories + missing) |
| `income_5_cat` | Household income quintile (5 categories + missing) |
| `household_size` | Number of household members (2–4, 5+) |
| `children_home` | Whether children reside in the household |
| `wkhtot_cat` | Respondent's weekly working hours (7 categories) |
| `wkhtot_cat_partner` | Partner's weekly working hours (7 categories) |
| `occ_concordance` | Occupational class concordance (ISCO-08/ISCOCO, 4 categories) |

### Covariates (Level 2)
| Variable | Description |
|----------|-------------|
| `cntry` | Country fixed effects (39 countries, encoded as `cntry_id`) |
| `year` | Survey round year fixed effects (2002–2023) |
| `welfare_regime` | Welfare state typology (Social Democratic, Conservative, Liberal, Mediterranean, Post-Communist) |

---

## Analytical Strategy

### Sample construction
The full pooled ESS dataset (N ≈ 530,000) was restricted to partnered respondents (married, in civil union, or cohabiting), yielding a final analytical sample of N = 274,594 after the following exclusions:
- Non-partnered respondents
- Respondents with missing values on subjective health
- Respondents with missing or non-harmonizable educational attainment
- Respondents with missing household size

### Survey weights
A combined weight (`norm_weight = dweight × pspwght`) was used to account for both within-country design weights and cross-national population size weights, following ESS guidelines for pooled cross-national analyses.

### Model
Predictive margins for the visualization were derived from a **weighted multilevel OLS regression** with respondents (Level 1) nested within countries (Level 2):

```stata
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
```

The central interaction term `i.edu_concordance##ib3.age_category` tests whether the association between educational concordance and health differs across age groups (reference: 40–49). Predictive margins were computed using `margins i.edu_concordance##i.age_category`.

The joint significance of the interaction was confirmed with `testparm` (χ²(27) = 6658.06, p < 0.001).

### Visualization
Predictive margins and their 95% confidence intervals were exported and visualized in R using `ggplot2` and `ggridges`. Simulated density distributions were generated from the predictive margins (2,000 draws per cell, truncated at CI bounds) to produce the kernel density ridge plot. The full R code is included as a comment block at the end of `SOCIUS_concordance.do`.

---

## Key Findings

Three patterns are visible in the figure:

1. **Health declines with age** across all educational pairings.
2. **Health distributions widen with age** — density plots spread and overlap less among older respondents, reflecting growing heterogeneity in health trajectories.
3. **Educational concordance matters, especially in later life** — couples where both partners have lower education show the lowest predicted health at every age, and this disadvantage grows more pronounced with age. The gap between jointly low-educated and jointly high-educated couples is modest in young adulthood but substantial in older age groups.

---

## Notes and Limitations

- The analysis is **cross-sectional** (pooled cohort comparison), not longitudinal. Age differences reflect variation across cohorts, not individual trajectories over time.
- **Partnership selection** — more educated individuals are more likely to be in stable partnerships and to partner assortatively — is not addressed causally. Estimates should be interpreted as descriptive of health stratification by educational concordance.
- **Missing spousal education** (particularly in Rounds 1–3) was addressed through country-specific variables; residual missingness led to exclusion from the analytical sample.
- Medical professionals (doctors) were identified and flagged using ISCO-08/ISCOCO codes. Their educational attainment was corrected where inconsistencies were detected.

---

## Software

- **Stata** (data cleaning, variable construction, multilevel regression, predictive margins)
- **R** (ggplot2, ggridges — visualization)
- Last updated: July 2025

---

## References

Link, B. G., & Phelan, J. (1995). Social conditions as fundamental causes of disease. *Journal of Health and Social Behavior*, 35, 80–94.

European Social Survey (2024). *About ESS*. https://www.europeansocialsurvey.org/about-ess

Halpern-Manners, A., Hernandez, E. M., & Wilbur, T. G. (2022). Crossover effects of education on health within married couples. *Journal of Health and Social Behavior*, 63(2), 301–318.
