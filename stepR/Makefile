# /home/dushoff/git/scratch/stepR
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: read.Rout 

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
# include $(ms)/perl.def

##################################################################

## Content

Sources += test.csv add.R

add.Rout: add.R

read.Rout: read.R

read.rdeps: read.R

######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/stepR.mk
# -include $(ms)/oldlatex.mk
