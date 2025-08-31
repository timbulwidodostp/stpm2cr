{smcl}
{* *! version 1.00 22Sep2016}{...}
{cmd:help stpm2cr postestimation}{right: ({browse "http://www.stata-journal.com/article.html?article=st0482":SJ17-2: st0482})}
{hline}

{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{cmd:stpm2cr postestimation} {hline 2}}Postestimation tools for stpm2cr{p_end}
{p2colreset}{...}


{title:Description}

{pstd}
The following postestimation commands are of special interest after
{cmd:stpm2cr}:

{synoptset 13}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_adjust2
{p2col :{helpb estat##predict:estat}}postestimation statistics{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_nlcom
{p2col :{helpb stpm2 postestimation##predict:predict}}predictions, residuals, etc.{p_end}
INCLUDE help post_predictnl
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {newvar} {ifin} [{cmd:,} {it:statistic}]

{phang}
Note: In the table below, {it:vn} is an abbreviation for {it:varname}.  Each
cause-specific prediction is stored in {newvar}{cmd:_c#}, where {cmd:#} is the
indicator value.

{synoptset 35 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab:Main}
{synopt :{opt at(vn # [vn # ...])}}predict {cmd:at()} values of specified covariates{p_end}
{synopt :{opt cause(numlist)}}specify the causes on which to make the predictions for and are stored in {it:newvar}{cmd:_c}{it:#}{p_end}
{synopt :{opt chrd:enominator(vn # [vn # ...])}}denominator for (time-dependent) cause-specific hazard ratio{p_end}
{synopt :{opt shrd:enominator(vn # [vn # ...])}}denominator for (time-dependent) subdistribution hazard ratio{p_end}
{synopt :{opt chrn:umerator(vn # [vn # ...])}}numerator for (time-dependent) cause-specific hazard ratio{p_end}
{synopt :{opt shrn:umerator(vn # [vn # ...])}}numerator for (time-dependent) subdistribution hazard ratio{p_end}
{synopt :{opt ci}}calculate confidence intervals{p_end}
{synopt :{opt cif}}predict:1 the cause-specific cumulative incidence function{p_end}
{synopt :{opt cifdiff1(vn # [vn # ...])}}first cumulative incidence function for difference in cumulative incidence functions{p_end}
{synopt :{opt cifdiff2(vn # [vn # ...])}}second cumulative incidence function for difference in cumulative incidence functions{p_end}
{synopt :{opt cifratio}}relative contribution to overall risk of a cause-specific cumulative incidence function{p_end}
{synopt :{opt csh}}cause-specific hazard function{p_end}
{synopt :{opt cumodds}}cumulative odds{p_end}
{synopt :{opt cumsub:hazard}}predict the cumulative subdistribution hazard function{p_end}
{synopt :{opt cure:d}}cure proportion{p_end}
{synopt :{opt subdens:ity}}subdensity function{p_end}
{synopt :{opt sub:hazard}}subdistribution hazard function{p_end}
{synopt :{opt time:var(vn)}}time variable used for predictions; default is {cmd:timevar(_t)}{p_end}
{synopt :{opt uncured}}obtain cause-specific cumulative incidence and subdistribution hazard functions for the "uncured"{p_end}
{synopt :{opt xb}}the linear predictor{p_end}
{synopt :{opt zero:s}}sets all covariates to zero (baseline prediction){p_end}

{syntab:Subsidiary}
{synopt :{opt dxb}}derivative of linear predictor{p_end}
{synopt :{opt lev:el(#)}}sets confidence level; default is {cmd:level(95)}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2} 
Statistics are available both in and out of sample; type
{cmd:predict} {it:...} {cmd:if e(sample)} {it:...} if wanted only for the
estimation sample.{p_end}


{title:Options for predict}

{dlgtab:Main}

{phang}
{opt at(varname # [varname # ...])} requests that the covariates specified by
the listed {it:varname}s be set to the listed {it:#} values.  For example,
{cmd:at(x1 1 x3 50)} would evaluate predictions at {cmd:x1} = 1 and {cmd:x3} =
50.  This is a useful way to obtain out-of-sample predictions.  Note that if
{opt at()} is used together with {opt zeros}, all covariates not listed in
{cmd:at()} are set to zero.  If {opt at()} is used without {opt zeros}, then
all covariates not listed in {opt at()} are set to their sample values.  See
also {opt zeros}.

{phang}
{opt cause(numlist)} specifies the causes on which to make the predictions for
and are stored in {it:newvar}{cmd:_c}{it:#}.  If {cmd:cause()} is not
specified, then predictions are made for all causes included in the model and
stored in {it:newvar}{cmd:_c}{it:#}.

{phang}
{opt chrdenominator(varname # [varname # ...])} and
{opt shrdenominator(varname # [varname # ...])} 
specify the denominator of the cause-specific hazard ratio or subdistribution
hazard ratio for a specific cause.  By default, all covariates not specified
using this option are set to zero.  See the cautionary note in
{cmd:chrnumerator()} and {cmd:shrnumerator()} below.  If {it:#} is set to
missing ({cmd:.}), then the covariate has the values defined in the dataset.

{phang}
{opt chrnumerator(varname # [varname # ...])} and
{opt shrnumerator(varname # [varname # ...])} 
specify the numerator of the (time-dependent) cause-specific hazard ratio or
subdistribution hazard ratio for a specific cause.  By default, all covariates
not specified using this option are set to zero.  Setting the remaining values
of the covariates to zero may not always be sensible, particularly on models
other than those on the cumulative subdistribution hazard scale or when more
than one variable has a time-dependent effect.  If {it:#} is set to missing
({cmd:.}), then the covariate has the values defined in the dataset.

{phang}
{opt ci} calculates a confidence interval for the requested statistic and
stores the confidence limits in {it:newvar}{cmd:_lci} and
{it:newvar}{cmd:_uci}.

{phang}
{cmd:cif} predicts the cause-specific cumulative incidence function.

{phang}
{opt cifdiff1(varname # [varname # ...])} and 
{opt cifdiff2(varname # [varname # ...])} predict the
difference in cause-specific cumulative incidence functions, with the first
cause-specific cumulative incidence function defined by the covariate values
listed for {opt cifdiff1()} and the second by those listed for
{cmd:cifdiff2()}.  By default, covariates not specified using either option
are set to zero.  Setting the remaining values of the covariates to zero may
not always be sensible.  If {it:#} is set to missing ({cmd:.}), then
{it:varname} takes its observed values in the dataset.

{pmore}
Example: {cmd:cifdiff1(stage 1)} (without specifying {cmd:cifdiff2()})
computes the difference in predicted cause-specific cumulative incidence
functions at {cmd:stage} = 1 compared with {cmd:stage} = 0 and all other
covariates set to 0.

{pmore}
Example: {cmd:cifdiff1(stage 2) cifdiff2(stage 1)} computes the difference in
predicted cause-specific cumulative incidence functions at {cmd:stage} = 2
compared with {cmd:stage} = 1.

{pmore}
Example: {cmd:cifdiff1(stage 2 age 50)} {cmd:cifdiff2(stage 1 age 70)}
computes the difference in predicted hazard functions at {cmd:stage} = 2 and
{cmd:age} = 50 compared with {cmd:stage} = 1 and {cmd:age} = 70 with all other
covariates set to 0.

{phang}
{opt cifratio} predicts the relative contribution of failing from an event to
the overall cumulative incidence function.  For example, if the event of
interest is in cancer, this is the relative contribution of dying from cancer
to the total mortality.  {cmd:cifratio} must be used along with the
{cmd:cause()} option to specify the cause-specific cumulative incidence
function on the numerator of the ratio.

{phang}
{opt csh} predicts the cause-specific hazard function.

{phang}
{opt cumodds} predicts the cumulative odds-of-failure function.

{phang}
{opt cumsubhazard} predicts the cumulative subdistribution hazard function.

{phang}
{opt cured} predicts the cause-specific cure proportion after fitting a cure
model.

{phang}
{opt subdensity} predicts the subdensity function.

{phang}
{opt subhazard} predicts the subdistribution hazard function.

{phang}
{opt timevar(varname)} defines the variable used as time in the predictions.
The default is {cmd:timevar(_t)}.  The use of {cmd:timevar()} is useful for
large datasets where, for plotting purposes, predictions are needed for only
200 observations, for example.  Be cautious when using this option because
predictions may be made at whatever covariate values are in the first 200 rows
of data.  This can be avoided by using the {cmd:at()} option or the
{cmd:zeros} option to define the covariate patterns for which you require the
predictions.

{phang}
{opt uncured} can be used after fitting a cure model for a specific cause.  It
can be used with the {cmd:subhazard} and {cmd:cif} options to base predictions
for the uncured group.

{phang}
{opt xb} predicts the linear predictor, including the spline function.

{phang}
{opt zeros} sets all covariates to zero (baseline prediction).  For example,
{cmd:predict cif, cause(1) cif zeros} calculates the baseline cause-specific
cumulative incidence function for cause = 1.

{dlgtab:Subsidiary}

{phang}
{opt dxb} calculates the derivatives of the linear predictors.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for confidence
intervals.  The default is {cmd:level(95)} or as set by {helpb set level}.


{title:Examples}

{pstd}Setup{p_end}
{phang2}{bf:. {stata "use http://www.stata-journal.com/software/sj4-2/st0059/prostatecancer"}}{p_end}
{phang2}{bf:. {stata "stset time, failure(status==1, 2, 3) scale(12) id(id) noshow"}}{p_end}
{phang2}{bf:. {stata "tabulate treatment, generate(trt)"}}{p_end}

{pstd}Proportional subdistribution hazard model{p_end}
{phang2}{bf:. {stata "stpm2cr [prostate: , scale(hazard) df(4)] [CVD: , scale(hazard) df(4)] [other: , scale(hazard) df(4)], events(status) cause(1 2 3) censvalue(0) eform"}}{p_end}

{phang2}{bf:. {stata "predict cif, cif ci"}}{p_end}
{phang2}{bf:. {stata "generate CVD = cif_c1 + cif_c2"}}{p_end}
{phang2}{bf:. {stata "generate Other = CVD + cif_c3"}}{p_end}
{phang2}{bf:. {stata "generate Cancer = cif_c1"}}{p_end}
{phang2}{bf:. {stata "twoway (area Other _t, sort) (area CVD _t, sort) (area Cancer _t, sort), ylabel(0(0.2)1) ytitle(Cumulative incidence)"}}{p_end}

{pstd}Time-dependent effects on cumulative hazard scale{p_end}
{phang2}{bf:. {stata "stpm2cr [prostate: trt2, scale(hazard) df(4) tvc(trt2) dftvc(2)] [CVD: trt2, scale(hazard) df(4) tvc(trt2) dftvc(2)] [other: trt2, scale(hazard) df(4) tvc(trt2) dftvc(2)], events(status) cause(1 2 3) censvalue(0) eform"}}{p_end}

{pstd}Use of the {cmd:at()} option{p_end}
{phang2}{bf:. {stata "predict cif_trt2, cif at(trt1 0 trt2 1) ci"}}{p_end}
{phang2}{bf:. {stata "generate CVD_trt2 = cif_c1 + cif_trt2_c2"}}{p_end}
{phang2}{bf:. {stata "generate Other_trt2 = CVD_trt2 + cif_trt2_c3"}}{p_end}
{phang2}{bf:. {stata "generate Cancer_trt2 = cif_trt2_c1"}}{p_end}
{phang2}{bf:. {stata "twoway (area Other_trt2 _t, sort) (area CVD_trt2 _t, sort) (area Cancer_trt2 _t, sort), ylabel(0(0.2)1) ytitle(Cumulative incidence)"}}{p_end}

{pstd}Obtain relative and absolute predictions{p_end}
{phang2}{bf:. {stata "predict shr_trt2, shrnumerator(trt2 1) shrdenominator(trt1 1) ci"}}{p_end}
{phang2}{bf:. {stata "line shr_trt2_c1 shr_trt2_c2 shr_trt2_c3 _t, sort yline(1, lpattern(dash)) ytitle(Rate of Failure)"}}{p_end}

{phang2}{bf:. {stata "predict cifdiff, cifdiff1(trt2 1) ci"}}{p_end}
{phang2}{bf:. {stata "line cifdiff_c1* _t, sort lpattern(solid dash dash) scheme(sj) ytitle(Cumulative incidence) title(Prostate cancer) name(g1) legend(off)"}}{p_end}
{phang2}{bf:. {stata "line cifdiff_c2* _t, sort lpattern(solid dash dash) scheme(sj) ytitle(Cumulative incidence) title(CVD) name(g2) legend(off)"}}{p_end}
{phang2}{bf:. {stata "line cifdiff_c3* _t, sort lpattern(solid dash dash) scheme(sj) ytitle(Cumulative incidence) title(Other) name(g3) legend(off)"}}{p_end}
{phang2}{bf:. {stata "graph combine g1 g2 g3, nocopies ycommon cols(3)"}}{p_end}

{phang2}{bf:. {stata "predict cifratio, cifratio at(trt2 1)"}}{p_end}
{phang2}{bf:. {stata "generate CVD_ratio = cifratio_c1 + cifratio_c2"}}{p_end}
{phang2}{bf:. {stata "generate Other_ratio = CVD_ratio + cifratio_c3"}}{p_end}
{phang2}{bf:. {stata "generate Cancer_ratio = cifratio_c1"}}{p_end}
{phang2}{bf:. {stata "twoway (area Other_ratio _t, sort) (area CVD_ratio _t, sort) (area Cancer_ratio _t, sort), ytitle(Relative contribution to total mortality)"}}{p_end}


{title:Authors}

{pstd}
Sarwar Islam Mozumder{break}
Department of Health Sciences{break}
University of Leicester{break}
Leicester, UK{break}
{browse "mailto:si113@leicester.ac.uk":si113@leicester.ac.uk}

{pstd}
Paul Lambert{break}
Department of Health Sciences{break}
University of Leicester{break}
Leicester, UK{break}
and{break}
Medical Epidemiology and Biostatistics{break}
Karolinska Institutet{break}
Stockholm, Sweden{break}
{browse "mailto:paul.lambert@leicester.ac.uk":paul.lambert@leicester.ac.uk}

{pstd}
Mark Rutherford{break}
Department of Health Sciences{break}
University of Leicester{break}
Leicester, UK{break}
{browse "mailto:mark.rutheford@leicester.ac.uk":mark.rutherford@leicester.ac.uk}


{title:Also see}

{p 4 14 2}Article:  {it:Stata Journal}, volume 17, number 2: {browse "http://www.stata-journal.com/article.html?article=st0482":st0482}{p_end}

{p 7 14 2}Help:  {helpb stpm2cr} (if installed){p_end}
