{smcl}
{* *! version 1.00 22Sept2016}{...}
{cmd:help stpm2cr}{right: ({browse "http://www.stata-journal.com/article.html?article=st0482":SJ17-2: st0482})}
{hline}

{title:Title}

{p2colset 5 16 18 2}{...}
{p2col :{hi:stpm2cr} {hline 2}}Flexible parametric competing-risks regression models{p_end}
{p2colreset}{...}


{title:Syntax}

{p 8 16 2}{cmd:stpm2cr} {cmd:[}{it:cause1}{cmd::} [{varlist}]{cmd:,} {opt scale(scalename)} [{it:{help stpm2cr##suboptions:suboptions}}]{cmd:]} 
{cmd:[}{it:cause2}{cmd::} [{varlist}]{cmd:,} {opt scale(scalename)} [{it:{help stpm2cr##suboptions:suboptions}}]{cmd:]} 
... {cmd:[}{it:causeN}{cmd::} [{varlist}]{cmd:,} {opt scale(scalename)} [{it:{help stpm2cr##suboptions:suboptions}}]{cmd:]} 
						{ifin}{cmd:,}
						{opt e:vents(varname)}
						[{cmd:,} {it:{help stpm2cr##options:options}}]

{marker suboptions}{...}
{synoptset 29 tabbed}{...}
{synopthdr: suboptions}
{synoptline}
{syntab: Equation options}
{p2coldent:* {opt scale(scalename)}}specify the scale on which the survival model is to be fit{p_end}
{synopt :{opt df(#)}}degrees of freedom for baseline hazard function{p_end}
{synopt :{opt knots(numlist)}}knot locations for baseline hazard{p_end}
{synopt :{opt tvc(varlist)}}time-varying effects{p_end}
{synopt :{opt dftvc(df_list)}}degrees of freedom for each time-dependent effect{p_end}
{synopt :{opt knotstvc(knotslist)}}knot locations for time-dependent effects{p_end}
{synopt :{opt bk:nots(knotslist)}}boundary knots for baseline{p_end}
{synopt :{opt bknotstvc(knotslist)}}boundary knots for time-dependent effects{p_end}
{synopt :{opt nocon:stant}}suppress constant term{p_end}
{synopt :{opt cure}}fit a cure model for {it:causeN}{p_end}
{synoptline}
{p2colreset}{...}
{pstd}
* {cmd:scale()} is required.{p_end}

{marker options}{...}
{synoptset 29 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Main options}
{p2coldent:* {opt e:vents(varname)}}specify the {it:varname} that contains the indicators for each competing event failure{p_end}
{synopt :{opt c:ause(numlist)}}indicator values for {it:causeN}{p_end}
{synopt :{opt cens:value(#)}}indicators for censored values; default is {cmd:censvalue(0)}{p_end}
{synopt :{opt noorth:og}}do not use orthogonal transformation of splines variables{p_end}

{syntab:Reporting}
{synopt :{opt alleq}}report all equations{p_end}
{synopt :{opt ef:orm}}exponentiate coefficients{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}

{syntab:Max options}
{synopt :{opt lininit}}obtain initial values by first fitting a linear function of ln(time){p_end}
{synopt :{it:{help stpm2cr##maximize_options:maximize_options}}}control the maximization process; seldom used{p_end}
{synoptline}
{p2colreset}{...}
{pstd}
* {cmd:events()} is required.{p_end}
{p 4 6 2}
You must {cmd:stset} your data before using {cmd:stpm2cr}; see {manhelp stset ST}.{p_end}
{p 4 6 2}
{cmd:fweight}s, {cmd:iweight}s, and {cmd:pweight}s may be specified using {cmd:stset}; {manhelp stset ST}.{p_end}


{title:Description}

{pstd}
{cmd:stpm2cr} fits competing-risks flexible parametric regression models
(Royston-Parmar models) by directly modeling the cumulative incidence
function.  {cmd:stpm2cr} can be used with single- or multiple-record {cmd:st}
data.  However, it cannot be used for multiple failures per subject.
{cmd:stpm2cr} can be fit on either the log cumulative subdistribution hazard
scale or the log cumulative odds-of-failure scale.

{pstd}
Alternatively, we may fit models with {helpb stpm2} in the presence of
competing risks to estimate the crude probability of death after
fitting a relative survival model (see {helpb stpm2cm}); estimate the
cumulative incidence function, that is, cause-specific hazards using 
{helpb stpm2cif}; or calculate the net probability of death in a hypothetical
world where competing events do not occur (a relative survival model).


{title:Main options}

{dlgtab:Model}

{phang}
{opt events(varname)} specifies the {it:varname} that contains the indicators
for each competing event failure.  {cmd:events()} is required.

{phang}
{opt cause(numlist)} specifies the indicator values in the data for the causes
fit in the model.

{phang}
{opt censvalue(#)} specifies the indicator values in {cmd:events()} for
censored individuals.  The default is {cmd:censvalue(0)}.

{phang}
{cmd: noorthog} suppresses orthogonal transformation of spline variables.

{dlgtab:Reporting}

{phang}
{opt alleq} reports all equations used by {cmd:ml}.  The models are fit by
using various constraints for parameters associated with the derivatives of
the spline functions.  These parameters are generally not of interest and thus
are not shown by default.  Also, an extra equation is used when fitting
delayed-entry models and is also not shown by default.

{phang}
{opt eform} reports the exponentiated coefficients.  For models on the log
cumulative-subdistribution hazard scale, {cmd:scale(hazard)}, this option
gives subdistribution hazard ratios if the covariate is not time dependent.
Similarly, for models on the log cumulative-subdistribution odds scale,
{cmd:scale(odds)}, this option will give odds ratios for nontime-dependent
effects.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for confidence
intervals.  The default is {cmd:level(95)} or as set by {helpb set level}.

{marker maximize_options}{...}
{dlgtab:Max options}

{phang}
{opt lininit} obtains initial values by fitting only the first spline basis
function (that is, a linear function of log survival-time).  This is useful
when models fail to converge using the initial values obtained in the usual
way.  However, this option is seldom needed.

{phang}
{it:maximize_options}; {opt dif:ficult}, {opt tech:nique(algorithm_spec)},
{opt iter:ate(#)}, [{cmdab:no:}]{opt lo:g}, {opt tr:ace}, {opt grad:ient}, 
{opt showstep}, {opt hess:ian}, {opt shownr:tolerance}, {opt tol:erance(#)},
{opt ltol:erance(#)}, {opt gtol:erance(#)}, {opt nrtol:erance(#)}, 
{opt nonrtol:erance}, and {opt from(init_specs)}; see {manhelp maximize R}.
These options are seldom used, but the {opt difficult} option may be useful if
there are convergence problems when fitting models that use the Aranda-Ordaz
family of link functions.


{title:Suboptions}

{dlgtab:Equation options}

{phang}
{opt scale(scalename)} specifies the scale on which to model the
cause-specific cumulative incidence function.  {cmd:scale()} is required.

{phang2}
{cmd:scale({ul:h}azard)} fits a model on the log cumulative-subhazard scale,
that is, the scale of ln[-ln{1 - F(t)}].  If no time-dependent effects are
specified, the resulting model assumes proportionality.

{phang2}
{cmd:scale({ul:o}dds)} fits a model on the log cumulative-odds scale,
that is, the scale of ln{(F(t)}/{1 - F(t)}.  If no time-dependent effects 
are specified, the resulting model assumes proportionality of the odds
ratios over time.

{phang}
{opt df(#)} specifies the degrees of freedom for the restricted cubic spline
function used for the baseline subdistribution hazard rate.  Usually a value
between 3 and 5 is sufficient, and the choice of degrees of freedom is
insensitive to parameter estimates.  Using {cmd:df(1)} is equivalent to
fitting a Weibull model when using {cmd:scale(hazard)}.  The internal knots
are placed at the centiles of the distribution of the uncensored log times
with boundary knots placed at the 0th and 100th centiles.  An example is
provided below for {cmd:df(5)}:

        {hline 71}
        Degrees of freedom      Internal knots     Centile positions (log time)
        {hline 71}
         5                      4                  20th, 40th, 60th, 80th
        {hline 71}

{phang}
{opt knots(numlist)} specifies knot locations for the baseline distribution
function, as opposed to the default knot locations set by {cmd:df()}.  The
locations of the knots are placed on the log-time scale.  Default knot
positions are determined by the {cmd:df()} option.

{phang}
{opt tvc(varlist)} specifies the names of the time-dependent variables.
Time-dependent effects are fit using restricted cubic splines.  The degrees of
freedom are specified using the {opt dftvc()} option.

{phang}
{opt dftvc(df_list)} specifies the degrees of freedom for time-dependent
effects.  If the same degree of freedom is used for all time-dependent
effects, then the syntax is the same as {opt df(#)}.  With one degree of
freedom, a linear effect of log time is fit.  If there is more than one
time-dependent effect and different degrees of freedom are required for each
time-dependent effect, then the following syntax can be used: 
{cmd:dftvc(x1:3 x2:2 1)}, where {cmd:x1} has three degrees of freedom,
{cmd:x2} has two degrees of freedom, and any remaining time-dependent effects
have one degree of freedom.

{phang}
{opt knotstvc(knotslist)} defines numlist {it:knotslist} as the location of
the interior knots for time-dependent effects.  If different knots are
required for different time-dependent effects, the option is specified, for
example, as follows: {cmd:knotstvc(x1 1 2 3 x2 1.5 3.5)}.

{phang}
{opt bknots(knotslist)} is a two-element list giving the boundary knots.  By
default, these are located at the minimum and maximum of the uncensored
survival times for all cause-specific events on the log scale.

{phang}
{opt bknotstvc(knotslist)} gives the boundary knots for any time-dependent
effects.  By default, these are the same as for the {cmd:bknots()} option.
They are specified on the scale defined by {cmd:scale()}.  For example,
{cmd:bknotstvc(x1 0.01 10 x2 0.01 8)}.

{phang}
{opt noconstant};
see {helpb estimation options##noconstant:[R] estimation options}.

{phang}
{opt cure} is specified when fitting cure models for a particular cause.  It
forces the cause-specific cumulative subdistribution hazard to be constant
after the last knot.  When the {cmd:df()} option is used together with the
{cmd:cure} option, the internal knots are placed evenly according to centiles
of the distribution of the uncensored log survival-times except one, which is
placed at the 95th centile, and the final knot is placed outside the last
uncensored cause-specific log survival-time (110th percentile by default).
Alternative knot locations can be selected using the {cmd:knots()} option.
Cure models can be used only when modeling on the log
cumulative-subdistribution hazard scale ({cmd:scale(hazard)}).


{title:Remarks}

{pstd}
Let t denote time.  {cmd:stpm2cr} first generates the cumulative incidence
function, F(t), using {helpb stcompet}, then fits a regression model against a
function of the cumulative incidence.  The procedure is illustrated for
proportional hazards models specified by the {cmd:scale(hazard)} option.  F(t)
is converted to an estimate of the log cumulative-subhazard function, Z(t), by
the formula

{pin}
Z(t) = ln[-ln{1 - F(t)}]

{pstd}
This estimate of Z(t) is then smoothed on ln(t) using regression splines with
knots placed at certain quantiles of the distribution of t.  The knot
positions are chosen automatically if the spline complexity is specified by
the {cmd:df()} option, or they are chosen manually by the {cmd:knots()}
option.  (Note that the knots are placed on values of ln(t), not t.) Denote
the predicted values of the log cumulative-subhazard function by Z_hat(t).
The density function f(t) is

{pin}
f(t) = dF(t)/dt = dF/dZ_hat dZ_hat/dt = {1 - F(t)} exp(Z_hat) dZ_hat(t)/dt

{pstd}
dZ_hat(t)/dt is computed from the regression coefficients of the fit spline
function.  The estimated cumulative incidence function is calculated as

{pin}
        F_hat(t) = 1 - exp[-exp{Z_hat(t)}]

{pstd}
The subhazard function is calculated as f(t)/{1 - F_hat(t)}.

{pstd}
If {it:varlist} is specified, the baseline cumulative incidence function (that
is, at zero values of the covariates) is used instead of the cumulative
incidence function of the raw observations.  With {cmd:df(1)}, a Weibull model
is fit.

{pstd}
With {cmd:scale(odds)}, the log cumulative odds-of-failure function,
ln[F(t)/{1 - F(t)}], is smoothed instead of the log cumulative-subhazard
function.  With {cmd:df(1)}, a subdistribution log-logistic model is fit.

{pstd}
Estimation is performed by maximum likelihood.  Optimization uses the default
technique, {cmd:nr}, meaning Stata's version of Newton-Raphson iteration.


{title:Examples}

{pstd}Setup{p_end}
{phang2}{bf:. {stata "use http://www.stata-journal.com/software/sj4-2/st0059/prostatecancer"}}{p_end}
{phang2}{bf:. {stata "stset time, failure(status==1, 2, 3) scale(12) id(id) noshow"}}{p_end}
{phang2}{bf:. {stata "tabulate treatment, generate(trt)"}}{p_end}

{pstd}Proportional log cumulative-subdistribution hazard model{p_end}
{phang2}{bf:. {stata "stpm2cr [prostate: trt2, scale(hazard) df(4)] [CVD: trt2, scale(hazard) df(4)] [other: trt2, scale(hazard) df(4)], events(status) cause(1 2 3) censvalue(0) eform"}}{p_end}

{pstd}Proportional odds-of-failure model{p_end}
{phang2}{bf:. {stata "stpm2cr [prostate: trt2, scale(odds) df(4)] [CVD: trt2, scale(odds) df(4)] [other: trt2, scale(odds) df(4)], events(status) cause(1 2 3) censvalue(0) eform"}}{p_end}

{pstd}Time-dependent effects on log cumulative-subdistribution hazard scale{p_end}
{phang2}{bf:. {stata "stpm2cr [prostate: trt2, scale(hazard) df(4) tvc(trt2) dftvc(2)] [CVD: trt2, scale(hazard) df(4) tvc(trt2) dftvc(2)] [other: trt2, scale(hazard) df(4) tvc(trt2) dftvc(2)], events(status) cause(1 2 3) censvalue(0) eform"}}


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

{p 7 14 2}Help:  {help stpm2cr postestimation},
{helpb stpm2},
{helpb stpm2cif} (if installed),
{manhelp stset ST}{p_end}
