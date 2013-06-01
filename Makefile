FILE="django.rst"
OUTDIR=outdir

all: compile

compile_highlevel: 
	hovercraft "django-highlevel.rst" "out-highlevel"

compile_dev:
	hovercraft "django-dev.rst" "out-dev"

compile: compile_dev compile_highlevel
  
show: compile 
	!sh -c 'open "out-highlevel/intex.html"'

