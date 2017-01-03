*y*<sub>*i*</sub> = *α* + *β**x*<sub>*i*</sub> + *μ*<sub>*k*</sub> + *ν*<sub>*j**k*</sub> + *η*<sub>*i**j**k*</sub>

R using lme4
------------

In R (version 3.3.2), I estimate the model using the `lmer` command from the lme4 package (version 1.1-12) with the following code:

``` r
lmer(y ~ by + gender + (1 | id2), data = small, REML = FALSE)
```

    ## Linear mixed model fit by maximum likelihood  ['lmerMod']
    ## Formula: y ~ by + gender + (1 | id2)
    ##    Data: small
    ##       AIC       BIC    logLik  deviance  df.resid 
    ##  270791.9  270997.8 -135372.0  270743.9     39258 
    ## Random effects:
    ##  Groups   Name        Std.Dev.
    ##  id2      (Intercept) 5.873   
    ##  Residual             5.975   
    ## Number of obs: 39282, groups:  id2, 16981
    ## Fixed Effects:
    ## (Intercept)       by1966       by1967       by1968       by1969  
    ##    -2.00769      1.21482      1.65712     -0.08254      0.33591  
    ##      by1970       by1971       by1972       by1973       by1974  
    ##    -1.24248      1.24677      0.54394     -0.80063      0.35069  
    ##      by1975       by1976       by1977       by1978       by1979  
    ##    -0.53378     -1.56570     -0.77106      0.78871     -0.48239  
    ##      by1980       by1981       by1982       by1983       by1984  
    ##    -0.10404     -0.22224     -0.55732     -2.12114     -0.83314  
    ##      by1985      gender1  
    ##     0.11956      1.59091

julia using MixedModels
-----------------------

In julia (version 0.5.0), I use the `lmm` command from the MixedModels package (version 0.7.3) using this code:

``` julia
fit!(lmm(y ~ by + gender + (1 | id2), small))
```

    ## Linear mixed model fit by maximum likelihood
    ##  Formula: y ~ by + gender + (1 | id2)
    ##    logLik    -2 logLik     AIC        BIC    
    ##  -1.35371952×10⁵2.70743904×10⁵2.70791904×10⁵2.70997789×10⁵
    ## 
    ## Variance components:
    ##               Column    Variance  Std.Dev. 
    ##  id2      (Intercept)  34.497515 5.8734585
    ##  Residual              35.705207 5.9753834
    ##  Number of obs: 39282; levels of grouping factors: 16981
    ## 
    ##   Fixed-effects parameters:
    ##                Estimate Std.Error   z value P(>|z|)
    ## (Intercept)    -2.00769  0.227734  -8.81596  <1e-17
    ## by: 1966.0      1.21482  0.272929   4.45103   <1e-5
    ## by: 1967.0      1.65712  0.272936   6.07146   <1e-8
    ## by: 1968.0   -0.0825446  0.271159 -0.304414  0.7608
    ## by: 1969.0     0.335909  0.273444   1.22844  0.2193
    ## by: 1970.0     -1.24248  0.271853  -4.57043   <1e-5
    ## by: 1971.0      1.24677  0.273026   4.56649   <1e-5
    ## by: 1972.0     0.543941  0.274257   1.98332  0.0473
    ## by: 1973.0    -0.800634  0.273418  -2.92824  0.0034
    ## by: 1974.0     0.350688  0.272864   1.28521  0.1987
    ## by: 1975.0    -0.533778  0.271522  -1.96587  0.0493
    ## by: 1976.0      -1.5657    0.2727  -5.74148   <1e-8
    ## by: 1977.0    -0.771063  0.272147  -2.83326  0.0046
    ## by: 1978.0     0.788711   0.27043   2.91651  0.0035
    ## by: 1979.0     -0.48239  0.270731  -1.78181  0.0748
    ## by: 1980.0    -0.104036  0.273955 -0.379754  0.7041
    ## by: 1981.0    -0.222241  0.269755 -0.823864  0.4100
    ## by: 1982.0    -0.557319  0.270803  -2.05802  0.0396
    ## by: 1983.0     -2.12114  0.271564  -7.81085  <1e-14
    ## by: 1984.0    -0.833143  0.271468  -3.06903  0.0021
    ## by: 1985.0     0.119559  0.317983   0.37599  0.7069
    ## gender: 1       1.59091  0.071009   22.4043  <1e-99

Stata using mixed
-----------------

In Stata (version 14.2) I use the mixed command. Here is the code:

``` stata
mixed y i.by i.gender || id2:, mle
```

    ## Performing EM optimization: 
    ## 
    ## Performing gradient-based optimization: 
    ## 
    ## Iteration 0:   log likelihood = -135371.96  
    ## Iteration 1:   log likelihood = -135371.95  
    ## 
    ## Computing standard errors:
    ## 
    ## Mixed-effects ML regression                     Number of obs     =     39,282
    ## Group variable: id2                             Number of groups  =     16,981
    ## 
    ##                                                 Obs per group:
    ##                                                               min =          1
    ##                                                               avg =        2.3
    ##                                                               max =          9
    ## 
    ##                                                 Wald chi2(21)     =    1209.51
    ## Log likelihood = -135371.95                     Prob > chi2       =     0.0000
    ## 
    ## ------------------------------------------------------------------------------
    ##            y |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
    ## -------------+----------------------------------------------------------------
    ##           by |
    ##        1966  |   1.214815   .2729288     4.45   0.000     .6798844    1.749746
    ##        1967  |    1.65712   .2729359     6.07   0.000     1.122175    2.192064
    ##        1968  |  -.0825446   .2711592    -0.30   0.761    -.6140068    .4489176
    ##        1969  |   .3359088   .2734443     1.23   0.219    -.2000322    .8718497
    ##        1970  |  -1.242483   .2718528    -4.57   0.000    -1.775305   -.7096614
    ##        1971  |   1.246773   .2730263     4.57   0.000     .7116511    1.781895
    ##        1972  |   .5439406   .2742574     1.98   0.047     .0064059    1.081475
    ##        1973  |  -.8006341   .2734182    -2.93   0.003    -1.336524   -.2647441
    ##        1974  |   .3506877   .2728645     1.29   0.199    -.1841169    .8854924
    ##        1975  |  -.5337776   .2715217    -1.97   0.049     -1.06595   -.0016048
    ##        1976  |  -1.565702   .2727001    -5.74   0.000    -2.100185    -1.03122
    ##        1977  |  -.7710628   .2721472    -2.83   0.005    -1.304461   -.2376642
    ##        1978  |    .788711   .2704299     2.92   0.004     .2586782    1.318744
    ##        1979  |    -.48239    .270731    -1.78   0.075    -1.013013    .0482331
    ##        1980  |  -.1040357   .2739555    -0.38   0.704    -.6409786    .4329071
    ##        1981  |  -.2222414   .2697547    -0.82   0.410     -.750951    .3064681
    ##        1982  |  -.5573188    .270803    -2.06   0.040    -1.088083   -.0265547
    ##        1983  |  -2.121142   .2715637    -7.81   0.000    -2.653397   -1.588887
    ##        1984  |  -.8331431   .2714681    -3.07   0.002    -1.365211   -.3010754
    ##        1985  |   .1195586   .3179834     0.38   0.707    -.5036775    .7427946
    ##              |
    ##     1.gender |   1.590908    .071009    22.40   0.000     1.451732    1.730083
    ##        _cons |  -2.007694   .2277341    -8.82   0.000    -2.454045   -1.561344
    ## ------------------------------------------------------------------------------
    ## 
    ## ------------------------------------------------------------------------------
    ##   Random-effects Parameters  |   Estimate   Std. Err.     [95% Conf. Interval]
    ## -----------------------------+------------------------------------------------
    ## id2: Identity                |
    ##                   var(_cons) |    34.4975   .5889731      33.36223     35.6714
    ## -----------------------------+------------------------------------------------
    ##                var(Residual) |   35.70521   .3339987      35.05655    36.36588
    ## ------------------------------------------------------------------------------
    ## LR test vs. linear model: chibar2(01) = 7739.31       Prob >= chibar2 = 0.0000

The table below shows median estimation times (over 10 replications) for the two- and three-level models using small, medium, and large data sets and estimated using maximum likelihood and restricted maximum likelihood (not available in julia).
<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="8" style="text-align: left;">
Estimation times for multilevel models
</td>
</tr>
<tr>
<th style="border-top: 2px solid grey;">
</th>
<th colspan="3" style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
2-level model
</th>
<th style="border-top: 2px solid grey;; border-bottom: hidden;">
 
</th>
<th colspan="3" style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
3-level model
</th>
</tr>
<tr>
<th style="border-bottom: 1px solid grey;">
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
Small
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
Medium
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
Large
</th>
<th style="border-bottom: 1px solid grey;" colspan="1">
 
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
Small
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
Medium
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
Large
</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="8" style="font-weight: 900;">
Maximum likelihood
</td>
</tr>
<tr>
<td style="text-align: left;">
  julia
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
0.1
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
0.9
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
9.9
</td>
<td style colspan="1">
 
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
0.2
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
2.6
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
28.2
</td>
</tr>
<tr>
<td style="text-align: left;">
  R
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
1.7
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
18.9
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
166.2
</td>
<td style colspan="1">
 
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
3.6
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
42.4
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
436.5
</td>
</tr>
<tr>
<td style="text-align: left;">
  Stata
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
17.1
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
207.9
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
2258.5
</td>
<td style colspan="1">
 
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
48.5
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
549.8
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
</td>
</tr>
<tr>
<td colspan="8" style="font-weight: 900;">
Restricted maximum likelihood
</td>
</tr>
<tr>
<td style="text-align: left;">
  R
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
1.8
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
18.9
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
165.0
</td>
<td style colspan="1">
 
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
3.5
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
42.3
</td>
<td style="padding-left: 1em; padding-right: .5em; text-align: right;">
286.1
</td>
</tr>
<tr>
<td style="border-bottom: 2px solid grey; text-align: left;">
  Stata
</td>
<td style="padding-left: 1em; padding-right: .5em; border-bottom: 2px solid grey; text-align: right;">
19.3
</td>
<td style="padding-left: 1em; padding-right: .5em; border-bottom: 2px solid grey; text-align: right;">
228.6
</td>
<td style="padding-left: 1em; padding-right: .5em; border-bottom: 2px solid grey; text-align: right;">
2482.6
</td>
<td style="border-bottom: 2px solid grey;" colspan="1">
 
</td>
<td style="padding-left: 1em; padding-right: .5em; border-bottom: 2px solid grey; text-align: right;">
53.4
</td>
<td style="padding-left: 1em; padding-right: .5em; border-bottom: 2px solid grey; text-align: right;">
598.3
</td>
<td style="padding-left: 1em; padding-right: .5em; border-bottom: 2px solid grey; text-align: right;">
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="8">
Median times in seconds from 10 replications for each combination.
</td>
</tr>
</tfoot>
</table>
To visualize the speed differences, below I plot median estimation times relative to julia (julia median times have all been normalized to unity, and the other times have been divided with the corresponding julia times). The plot only shows the two-level model estimated with maximum likelihood, since this is the only specification that is possible with all three packages. ![](index_files/figure-markdown_github/relative_plot-1.png)

It is clear from this plot that R is around 20 times slower than julia, while Stata is around 200 times slower, and thus around 10 times slower than R.
