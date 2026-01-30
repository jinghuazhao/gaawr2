# Genetic Association Analysis

This is a companion to Henry-Stewart talk by Zhao (2026,
[doi:10.69645/FRFQ9519](https://doi.org/10.69645/FRFQ9519) ), which
gathers information, metadata and scripts to showcase modern genetic
analysis – ranging from testing of polymorphic variant(s) for
Hardy-Weinberg equilibrium, association with traits using genetic and
statistical models, Bayesian implementation, power calculation in study
design, and genetic annotation. It also covers R integration with the
Linux environment, GitHub, package creation and web applications. The
earlier version by Zhao (2009,
[doi:10.69645/DCRY5578](https://doi.org/10.69645/DCRY5578) ) provides a
brief introduction to these topics.

## Details

Available data and function are listed in the following table.

|               |                                                      |
|---------------|------------------------------------------------------|
| Objects       | Description                                          |
| **Dataset**   |                                                      |
| `DiaHealth`   | A Bangladeshi dataset for Type 2 diabetes prediction |
| `diabetes`    | A diabetes dataset                                   |
| **Functions** |                                                      |
| `welcome`     | An enhanced welcome                                  |

We can add references such as Francois (2014) .

## Usage

Vignettes on package usage:

-   Genetic Association Analysis with R (II), `vignette("gaawr2")`.

-   Web facilities, `vignette("web")`.

## References

Romain Francois (2014). *bibtex: bibtex parser*. R package version
0.4.0.

## See also

Useful links:

-   <https://jinghuazhao.github.io/gaawr2/>

-   <https://github.com/jinghuazhao/gaawr2>

-   Report bugs at <https://github.com/jinghuazhao/gaawr2/issues>

## Author

Jing Hua Zhao in collaboration with other colleagues.

## Examples

``` r
welcome(3)
#> Welcome to gaawr2 3 times!
```
