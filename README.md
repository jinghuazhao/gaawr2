---
output: github_document
---



# Genetic Association Analysis with R (II)

An R package companion to a titled Henry-Stewart talk, part 2.

<!-- badges: start -->
[![pages-build-deployment](https://github.com/jinghuazhao/gaawr2/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/jinghuazhao/gaawr2/actions/workflows/pages/pages-build-deployment)
[![R-CMD-check](https://github.com/jinghuazhao/gaawr2/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jinghuazhao/gaawr2/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Description

This package illustrates creation and maintenance of package used in genetic association analysis.

## Installation

The latest version of gaawr2 can be installed as usual:

### 1. Install from R

```r
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github("jinghuazhao/gaawr2")
```

### 2. Install from GitHub repository

```bash
git clone https://github.com/jinghuazhao/gaawr2
R CMD INSTALL gaawr2
```

Dependencies are detailed in the DECRIPTION file of the package at GitHub.

## A summary of functions

This can be seen from R with

```r
library(help=gaawr2)
```

or

```r
library(gaawr2)
?gaawr2
```
