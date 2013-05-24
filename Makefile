FILE="django.rst"
OUTDIR=outdir

all: compile

compile:
	hovercraft $(FILE) $(OUTDIR)

show: compile, view

watch: compile
	./watch.sh
