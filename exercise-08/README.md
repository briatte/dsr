# DSR: Exercise 8

This exercise focuses on estimating, manipulating and interpreting (simple) linear models. Prior exposure to Keynesian macroeconomics will help, but is not required.

## Scenario

By some weird twist of fate that might or might not be related to your wearing of your Noam Chomsky t-shirt during job interviews, you are interning at the _[Financial Times][ft]_ (FT), under the auspices of [Chris Giles][cg].

[ft]: https://www.ft.com/
[cg]: https://www.ft.com/chris-giles

Giles has just released a story titled "[Robustness of IMF data scrutinised][ft-archive]" (October 12, 2012), in which he tries, and fails, to replicate some of the results published in the [World Economic Outlook 2012][weo12] report of the International Monetary Fund (IMF).

[ft-article]: https://www.ft.com/content/85a0c6c2-1476-11e2-8cf2-00144feabdc0
[ft-archive]: https://archive.is/JpiCS
[weo12]: https://www.imf.org/en/Publications/WEO/Issues/2016/12/31/Coping-with-High-Debt-and-Sluggish-Growth

Giles asks you to independently check that his calculations, which cast some doubt on Box 1.1 of the report (pp. 41–3, "Are We Underestimating Short-Term Fiscal Multipliers?"), are correct.

The data in this folder come from a blog post by Chris Giles, published on the same day as the article:

> Chris Giles, "[Has the IMF proved multipliers are really large? (wonkish)][cg-blog-archive]," _Money Supply_, 12 October 2012.

[cg-blog-archive]: https://web.archive.org/web/20121016004157/http://blogs.ft.com/money-supply/2012/10/12/has-the-imf-proved-multipliers-are-really-large-wonkish/
[cg-blog]: http://blogs.ft.com/money-supply/2012/10/12/has-the-imf-proved-multipliers-are-really-large-wonkish/

## Instructions

In a nutshell, the aim of the analysis is to assess whether fiscal consolidation (a common strategy in the aftermath of the global fiscal crisis) helps or harms growth. The IMF found a negative effect, which suggests that debt restructuring actually hampers growth, and that the smart thing to do is actually to let government spending help national income to grow, a relationship that John Maynard Keyne's student Richard Kahn dubbed the ['multiplier effect'][fiscal-multiplier] back in 1931.

[fiscal-multiplier]: https://en.wikipedia.org/wiki/Fiscal_multiplier

Giles looked at the same data, and disagrees. Read the article and blog post to understand why, and what the IMF replied to his request for clarifications.

Once you have read both sources, do the following:

1. Import the second sheet of Giles' dataset ('IMF replication').

    What you need for what follows are the last five columns, i.e. `Country`, `Dgrowth` (growth forecast error), `Dstruct` (structural deficit forecast, also called 'fiscal consolidation forecast' in the IMF report), `DCAPB` (cyclically-adjusted primary balance) and `CA def` (current account deficit).

2. Create three subsets of the data:

    1. An 'IMF subset' that contains only the countries shown in Fig. 1.1.1. of the IMF report (European Union countries, plus Australia, Canada, Japan, Korea and the United States).
    2. A 'Giles subset #1' that contains all countries except New Zealand, Germany and Greece, and a 'Giles subset #2' that contains all countries except Germany and Greece.
  
    You will need to have read the aforementioned sources to understand the rationale behind those subsets, and you will need to inspect missing values to understand how they differ from each other.

3. Plot the data to replicate Fig. 1.1.1. of the IMF report, but include _two_ regression lines: one for all countries, and one for the IMF subset.

    How do you interpret the difference?

4. Estimate a series of 7 linear regression models:

    - Model 1: regress `Dgrowth` on `Dstruct` for the IMF subset
    - Model 2: regress `Dgrowth` on `Dstruct` for all countries
    - Model 3: regress `Dgrowth` on `Dstruct` for the Giles subset #1
    - Model 4: regress `Dgrowth` on `DCAPB` for all countries
    - Model 5: regress `Dgrowth` on `DCAPB` for the Giles subset #2
    - Model 6: regress `Dgrowth` on `Dstruct` _and_ `CA def` for all countries
    - Model 7: regress `Dgrowth` on `Dstruct` _and_ `CA def` for the Giles subset #2
        
    Make sure that you understand what the models are trying to estimate. Then, compare the respective performance of each model, in more than one way (hint: goodness-of-fit).
    
    Now that you have replicated most of Chris Giles' blog post, do you understand why he came to the conclusions that led him to publish his _FT_ story?

5. Plot the distribution of the residuals for each model, and assess how they perform overall, as well as relatively to each other.

6. Plot the residuals-versus-fitted values of Model 2. What do you observe?

7. Based on Model 2, establish which countries should be considered as outliers according to their Cook's distance, and which should be considered as outliers according to their standardized residuals.

8. Last, go back to the [World Economic Outlook 2012][weo12] report Web page, download the data that the IMF provided for Box 1.1, and replicate the effect size published by the IMF and contested by Chris Giles' reanalysis.

9. Draw _at least two_ substantive conclusions on the controversy, one of which might cost you your intern position at the _Financial Times_.

If you want to watch the people involved in this controversy discuss a related topic, turn to this recent documentary by the _Financial Times_: "[Why governments are 'addicted' to debt](https://youtu.be/n1jhoU9Mp_U)," 27 March 2025. For a much deeper treatment, see Valerie Ramey's lecture at the London School of Economics, "[Rethinking Keynesian Fiscal Stimulus](https://youtu.be/Ct5yMQpH3lE)," 2 April 2025.

---

> Economics is the science of thinking in terms of models joined to the art of choosing models that are relevant to the contemporary world.  
> --- [John Maynard Keynes](https://twitter.com/rodrikdani/status/992020848646197248?lang=en)

> To allow the market mechanism to be sole director of the fate of human beings and their natural environment, indeed, even of the amount and use of purchasing power, would result in the demolition of society.  
> --- [Karl Polanyi](https://www.goodreads.com/author/quotes/30514.Karl_Polanyi)
