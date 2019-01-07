# scratch
### Public 

current: target
-include target.mk

##################################################################

# make files

Sources = Makefile README.md sub.mk LICENSE.md
include sub.mk
-include $(ms)/perl.def
-include $(ms)/python.def

##################################################################


roswell_nmds.Rout: roswell_nmds.R
nmds.Rout: nmds.R

bananas.Rout: bananas.csv bananas.R

FOO=a b

# $(FOO:%=%.R): blah
	# @echo yo!

ICI3D_Lab7_MCMC-Binomial.Rout: ICI3D_Lab7_MCMC-Binomial.R

ICI3D_Lab8_MCMC-SI_HIV.Rout: ICI3D_Lab8_MCMC-SI_HIV.R

## Is this a good place for drafts?

Sources += rabies_sq.md sq.rmu ptrs.csl

rabies_sq.wc: rabies_sq.txt
	wc $< > $@

## Insane branch where you make your own citations (defunct)
rabies_sq.mkd: rabies_sq.txt rabies_sq.pbm cite.pl
	$(PUSH)

## Experimental branch where we learn how to use markdown properly. Looking better
rabies_sq.html: rabies_sq.md sq.bib
	pandoc -s -S --filter=pandoc-citeproc -o $@ $<

damp.html: damp.md

## Bib
sq.bib: sq.rmu
sq.html: sq.rmu

######################################################################

## Premier league table

table.html: /proc/uptime
	wget -O $@ "www.bbc.com/sport/football/premier-league/table"

## Tempering
piano.Rout: piano.R

## Survey stats (what are the odds that I got all 5 answers from 8 responses)

sstats.Rout: sstats.R

##################################################################

## Sid Reed

Sources += $(wildcard *.py)
SIR.out: SIR.py
	$(PITH)

##################################################################

greek.Rout: greek.R

## Shapes Bewketu)

add.Rout: add.R

shapes.Rout: shapes.R

## Inbred explorations (Adler)

Sources += inbred.pl
inbred.out: inbred.pl
	$(PUSH)

##################################################################

## Rcache

sum.Rout: sum.R
sump.Rout: git_cache/sum.Rout sump.R

## New cache

Sources += test.pl
git_cache/test.out: test.pl
	$(PUSH)

test.print: slow/test.out
	cat $< > $@

######################################################################

Sources += $(wildcard *.R *.rmd *.mkd)

############ nlme "bug"

dplyrOrder.Rout: dplyrOrder.R

stochSIRsample.pdf: stochSIRsample.rmd

poly.Rout: poly.R

nlme.html: nlme.rmd

nlme_bug.Rout: nlme_bug.R

Archive += nlme.html

######################################################################

Sources += Policy_meeting.html

room.Rout: room.R

cards.Rout: cards.R

cards.Routput.compare: cards.R

### Compare stuff; may be good for makestuff?

%.setgoal: %
	/bin/cp $@ $*.goal

%.goal: 
	/bin/cp $* $@

%.compare: % %.goal
	diff $* $*.goal > $@

factor.Rout: factor.R

collatz.Rout: collatz.R

####### Scoring stuff

### Exploring the Johnson distribution

johnson.Rout: johnson.R
johnson_test.Rout: johnson.Rout johnson_test.R
johnson.mkd: 
johnson.html: johnson.rmd 
## johnson.rmd: johnson_test.Rout-0.png johnson_test.Rout-1.png johnson_test.Rout-2.png

coexistence.html: coexistence.mkd

Sources += gavin70.tex
gavin70.pdf: gavin70.tex
neighbors.Rout: neighbors.R

### Promotion drafts

Sources += research_statement.tex
research_statement.pdf: fitpage.sty research_statement.tex
Archive += research_statement.pdf

Sources += teaching_statement.tex
teaching_statement.pdf: teaching_statement.tex
Archive += teaching_statement.pdf

fitpage.sty:

######################################################################

### Fitting from BB

stochSIRsample.pdf: slice2D.R

######################################################################

##### Orthogonality

### This is just lm, for reference I guess
lm.Rout: lm.R

### We can do lm manually, and were beginning to play with qr, which we will use for orthogonalizaiton
ortho.Rout: ortho.R

##### model matrix manipulation in clmm (for Tanzania)

### What does the ordinal function look like?
### Why do we care?
ordinal.Rout: ordinal.R

## Functions for filling structural redundancies in models
redundancy.Rout: redundancy.R

## A test
tztest.Rout: redundancy.Rout tztest.R

tztestRE.Rout:redundancy.Rout tztestRE.R

tztestORD.Rout: redundancy.Rout tztestORD.R

######################################################################

### WTF is this? ###

dplyr.Rout: dplyr.R

#### tSIR (move to cards/ subdirectory!)

cards.Rout: cards.R
tSIR.Rout: tSIR.R
Archive += tSIR.Rout

### Fitting for Alejo http://dushoff.github.io/notebook/genFit.html

genFit.Rout: genFit.R

######################################################################

## Useful files

Sources += talk.Makefile

step.Rout: step.R

### Makestuff

# slowdir = datadir
# -include $(ms)/cache.mk

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/stepR.mk
# -include $(ms)/oldlatex.mk

-include $(ms)/pandoc.mk
-include $(ms)/modules.mk

# export autorefs = autorefs
-include autorefs/inc.mk

