# DiaHealth

A Bangladeshi dataset for Type 2 diabetes prediction.

## Usage

``` r
DiaHealth
```

## Format

A data frame with 5,437 patients and 14 variables on demographics,
clinical parameters, and medical history.

-   `age`:

    Years (age of the person).

-   `gender`:

    Categorical variable (Female, Male).

-   `pulse_rate`:

    Beats per minute (bpm).

-   `systolic_bp`:

    SBP in millimeters of mercury (mmHg).

-   `diastolic_bp`:

    DBP (mmHg).

-   `glucose`:

    Milligrams per deciliter (mg/dL).

-   `height`:

    Meter (m).

-   `weight`:

    Kilogram (kg).

-   `bmi`:

    Body mass index (BMI).

-   `family_diabetes`:

    Family history of diabetes.

-   `hypertensive`:

    Hypertension.

-   `family_hypertension`:

    Family history of hypertension.

-   `cardiovascular_disease`:

    CVD.

-   `stroke`:

    Stroke.

-   `diabetic`:

    Diabetic.

## Source

Prama TT, Zaman M, Sarker F, Mamun KA. (2024), “DiaHealth: A Bangladeshi
Dataset for Type 2 Diabetes Prediction ”, Mendeley Data, V1, doi:
10.17632/7m7555vgrn.1

## Details

Key features include age, gender, pulse rate, blood pressure (systolic
and diastolic), glucose level, BMI, and family history of diabetes and
related conditions like hypertension and cardiovascular disease. The
dataset is labeled with a binary outcome indicating whether each patient
has diabetes. This rich dataset is designed to support the development
and evaluation of machine learning models for diabetes detection,
management, and treatment.

## See also

`diabetes`

## Examples

``` r
data(DiaHealth)
knitr::kable(head(DiaHealth,5),caption="Five individauls in DiaHealth")
#> 
#> 
#> Table: Five individauls in DiaHealth
#> 
#> | age|gender | pulse_rate| systolic_bp| diastolic_bp| glucose| height| weight|   bmi| family_diabetes| hypertensive| family_hypertension| cardiovascular_disease| stroke|diabetic |
#> |---:|:------|----------:|-----------:|------------:|-------:|------:|------:|-----:|---------------:|------------:|-------------------:|----------------------:|------:|:--------|
#> |  42|Female |         66|         110|           73|    5.88|   1.65|   70.2| 25.75|               0|            0|                   0|                      0|      0|No       |
#> |  35|Female |         60|         125|           68|    5.71|   1.47|   42.5| 19.58|               0|            0|                   0|                      0|      0|No       |
#> |  62|Female |         57|         127|           74|    6.85|   1.52|   47.0| 20.24|               0|            0|                   0|                      0|      0|No       |
#> |  73|Male   |         55|         193|          112|    6.28|   1.63|   57.4| 21.72|               0|            0|                   0|                      0|      0|No       |
#> |  68|Female |         71|         150|           81|    5.71|   1.42|   36.0| 17.79|               0|            0|                   0|                      0|      0|No       |
```
