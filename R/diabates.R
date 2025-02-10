#' Diabetes Dataset
#'
#' @description
#' A diabetes dataset on 1,000 patients.
#'
#' @docType data
#' @keywords datasets internal
#' @format
#' A data frame with 1,000 rows and 14 variables:
#' \describe{
#'   \item{\code{ID}}{ID.}
#'   \item{\code{No_Pation}}{No. of Patient.}
#'   \item{\code{Gender}}{Gender.}
#'   \item{\code{AGE}}{Age.}
#'   \item{\code{Urea}}{Chief nitrogenous end product of the metabolic breakdown of proteins.}
#'   \item{\code{Cr}}{Creatinine ratio (Cr).}
#'   \item{\code{HbA1c}}{Hemoglobin A1c (HbA1c).}
#'   \item{\code{Chol}}{Cholesterol (Chol).}
#'   \item{\code{TG}}{Triglycerides (TG).}
#'   \item{\code{HDL}}{High-density lipoprotein (HDL).}
#'   \item{\code{LDL}}{Low-density lipoprotein (LDL).}
#'   \item{\code{VLDL}}{Very-low-density lipoprotein (VLDL).}
#'   \item{\code{BMI}}{Body mass index (BMI).}
#'   \item{\code{CLASS}}{Class (the patient's diabetes disease class may be Diabetic, Non-Diabetic, or Predict-Diabetic).}
#' }
#' @details
#' The data were collected from the Iraqi society, as they data were acquired from the laboratory of Medical City Hospital
#' and (the Specializes Center for Endocrinology and Diabetes-Al-Kindy Teaching Hospital).
#'
#' @source Rashid A (2020), “Diabetes Dataset”, Mendeley Data, V1, doi: 10.17632/wj9rwkp9c2.1.
#' @examples
#' \dontrun{
#' data(diabetes)
#' head(diabetes)
#' }
#' @seealso \code{\link[gaawr2]{DiaHealth}}.

"diabetes"
