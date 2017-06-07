# scratch
### Hooks for the editor to set the default target

current: target
include target.mk

##################################################################

# make files

Sources = Makefile .gitignore README.md sub.mk LICENSE.md
include sub.mk
# include $(ms)/perl.def

##################################################################

## Content

Sources += $(wildcard *.R *.rmd *.mkd)

sim.Rout: sim.R

fakesim.Rout: sim.Rout fakesim.R

binfits.Rout: fakesim.Rout binfits.R
cardfits.Rout: fakesim.Rout cardfits.R
poisfits.Rout: fakesim.Rout poisfits.R 

bolker.Rout: bolker.R

Archive += .fakesim.RData

######################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
-include $(ms)/oldlatex.mk
-include $(ms)/pandoc.mk
