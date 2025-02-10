#' DiaHealth
#'
#' @description
#' A Bangladeshi Dataset for Type 2 Diabetes Prediction.
#'
#' @docType data
#' @keywords datasets internal
#' @format
#' A data frame with 5,437 patients and 14 variables on demographics, clinical parameters, and medical history.
#' \describe{
#'   \item{\code{age}}{Years (age of the person).}
#'   \item{\code{gender}}{Categorical variable (Female, Male).}
#'   \item{\code{pulse_rate}}{Beats per minute (bpm).}
#'   \item{\code{systolic_bp}}{SBP in millimeters of mercury (mmHg).}
#'   \item{\code{diastolic_bp}}{DBP (mmHg).}
#'   \item{\code{glucose}}{Milligrams per deciliter (mg/dL).}
#'   \item{\code{height}}{Meter (m).}
#'   \item{\code{weight}}{Kilogram (kg).}
#'   \item{\code{bmi}}{Body mass index (BMI).}
#'   \item{\code{family_diabetes}}{Family history of diabetes.}
#'   \item{\code{hypertensive}}{Hypertension.}
#'   \item{\code{family_hypertension}}{Family history of hypertension.}
#'   \item{\code{cardiovascular_disease}}{CVD.}
#'   \item{\code{stroke}}{Stroke.}
#'   \item{\code{diabetic}}{Diabetic.}
#' }
#' @details
#' Key features include age, gender, pulse rate, blood pressure (systolic and diastolic), glucose level, BMI, and family history of diabetes and related conditions like hypertension and cardiovascular disease. The dataset is labeled with a binary outcome indicating whether each patient has diabetes. This rich dataset is designed to support the development and evaluation of machine learning models for diabetes detection, management, and treatment.
#'
#' @source Prama TT, Zaman M, Sarker F, Mamun KA. (2024), “DiaHealth: A Bangladeshi Dataset for Type 2 Diabetes Prediction ”, Mendeley Data, V1, doi: 10.17632/7m7555vgrn.1
#' @examples
#' data(DiaHealth)
#' knitr::kable(head(DiaHealth,5),caption="Five individauls in DiaHealth")
#' @seealso \code{\link[gaawr2]{diabetes}}

"DiaHealth"
