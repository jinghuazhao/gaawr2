# Diabetes Dataset

A diabetes dataset on 1,000 patients.

## Usage

``` r
diabetes
```

## Format

A data frame with 1,000 rows and 14 variables:

-   `ID`:

    Unique identifier for each patient (unitless).

-   `No_Pation`:

    Patient number (unitless).

-   `Gender`:

    Categorical variable (Female, Male).

-   `AGE`:

    Years (age of the person).

-   `Urea`:

    Chief nitrogenous end product of the metabolic breakdown of proteins
    in milligrams per deciliter (mg/dL).

-   `Cr`:

    Creatinine ratio (Cr) (mg/dL).

-   `HbA1c`:

    Hemoglobin A1c (HbA1c) % (percentage).

-   `Chol`:

    Cholesterol (Chol) (mg/dL).

-   `TG`:

    Triglycerides (TG) (mg/dL).

-   `HDL`:

    High-density lipoprotein (HDL) (mg/dL).

-   `LDL`:

    Low-density lipoprotein (LDL) (mg/dL).

-   `VLDL`:

    Very-low-density lipoprotein (VLDL) (mg/dL).

-   `BMI`:

    Body mass index (BMI).

-   `CLASS`:

    Class (the patient's diabetes disease class may be Diabetic,
    Non-Diabetic, or Predict-Diabetic).

## Source

Rashid A (2020), “Diabetes Dataset”, Mendeley Data, V1, doi:
10.17632/wj9rwkp9c2.1.

## Details

The data were collected from the Iraqi society, as they data were
acquired from the laboratory of Medical City Hospital and (the
Specializes Center for Endocrinology and Diabetes-Al-Kindy Teaching
Hospital).

## See also

`DiaHealth`.

## Examples

``` r
data(diabetes)
knitr::kable(head(diabetes,5),caption="Five individuals in diabetes data")
#> 
#> 
#> Table: Five individuals in diabetes data
#> 
#> |  ID| No_Pation|Gender | AGE| Urea| Cr| HbA1c| Chol|  TG| HDL| LDL| VLDL| BMI|CLASS |
#> |---:|---------:|:------|---:|----:|--:|-----:|----:|---:|---:|---:|----:|---:|:-----|
#> | 502|     17975|F      |  50|  4.7| 46|   4.9|  4.2| 0.9| 2.4| 1.4|  0.5|  24|N     |
#> | 735|     34221|M      |  26|  4.5| 62|   4.9|  3.7| 1.4| 1.1| 2.1|  0.6|  23|N     |
#> | 420|     47975|F      |  50|  4.7| 46|   4.9|  4.2| 0.9| 2.4| 1.4|  0.5|  24|N     |
#> | 680|     87656|F      |  50|  4.7| 46|   4.9|  4.2| 0.9| 2.4| 1.4|  0.5|  24|N     |
#> | 504|     34223|M      |  33|  7.1| 46|   4.9|  4.9| 1.0| 0.8| 2.0|  0.4|  21|N     |
```
