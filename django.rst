:title: Introduction to Django
:data-transition-duration: 200
:css: django.css

----

Level 1: overview
=================

.. image:: img/django.png
	:width: 800px


.. note::
	
	2 part, part 1 for non-developer, part 2 for dev
	
----

What is Django
==============

*"Django is a high-level Python Web framework that encourages rapid development and clean, pragmatic design"*

- Mature in production ( since July 2005 )
- OpenSource project with active community
- Easy learning web framework 
- Really well documented framework
- Rapid prototyping framework

.. note::

   - Django is not new, project started in 2004
	- Can start working with really few knowledge of python
	
----

Who is using Django
===================

- disqus.com
- bitbucket.org
- lanyrd.com 
- addons.mozilla.org
- The guardian.co.uk
- washingtonpost.com
- instagram
- pinterest
- rdio
- **... many many more ...**

----

How "good" is django
====================

*http://stackoverflow.com/questions/886221/does-django-scale*

**Single machine, Intel Core i7 32Gb RAM**

- Running **24 / 7**
- **600'000** visitor / day
- **500'000** hit / hour
- **1'000** concurrent user
- **240** concurrent requests 

----

Where django is not so "good"
=============================

- Async sockets ( WebSocket, Comet, ... )
- Not working well with large file upload / download
	- object store wanted
- NoSQL database support is tricky ( becoming better )

----

Django project structure
========================

.. image:: img/project.png
	:width: 1024px

.. note::
	- The goal of this slide is to understand modularity and reut
	
----

Supported database
==================

- In django project
	- Postgres, SQLite (dev), Oracle, Mysql
- 3rd party
	- Sybase, DB2, SQL Server, Firebird, ODBC, ...
	
----


Components
==========

.. image:: img/overview.png
	:width: 1024px

.. note::

	- This is not HTML targeted
	- View can generate JSON / XML ( rest framework )
	- Caching is transparent
	- About WSGI ( dev connector / gunicorn / uWSGI )
	
----

Other components
================

- Web admin (django.contrib.admin)
- Command line 
- HTTP(s) middleware
- Template tags
- Database backend
- File storage
- ...

.. note:: 
	- Some components are provided by applications.
	- Application can introspect project to enhance its behavior

----

Useful Django projects
======================

- **django-rest-framework.** ReST views on model
- **django-social-auth** Facebook, Twitter... authentication
- **django-imagekit** Automated image processing
- **django-auth-ldap** LDAP authentication
- **django-debug-toolbar** Tool bar on development page 
- **django-cms** CMS by "divio" Zurich company
- **django-getpaid** Payment gateway integration

**https://www.djangopackages.com/**

----

Free admin portal
=================

- Generate admin based on model
- Highly customizable front-end
- Admin portal enhanceable by 3rd party project

.. image:: img/admin_site.png
	
.. note:: 

	- Talk also about debug-toolbar
	
----

Typical deployment
==================

.. image:: img/deployment.png
		:width: 800px
		
.. note:: 
	Apache to replace nginx
	Apache authentication mechanism ( delegate ) for uWSGI
	Celery + RabbitMQ to replace RQ

----

Level 2: / inside django
========================

.. image:: img/pony.png
	:width: 1024px
	
----

Some words on python
====================

.. image:: img/python.png
	:align: center

----

Python types
------------

.. code:: python

		x = 10 # int (32-bits)
		x = 20L # long (only limited by memory)
		y = 12.5 # float ( equivalent to 'C' double )
		c = 3 + 1j # Complex numbber ( float )
		b = False # Boolean
		s = "Hello" # string ( python2: non unicode, python3: unicode)
		s = u"Hello" # string unicode ( python 2 et python 3.3 )
		t = (10, "hello") # tuple ( immutable list )
		a = [20, "hello"] # list ( mutable )
		d = {'key': 'my_value'} # dictionary
		def do_something(): return "Done"
		f = lambda x: x**2 # function
		f = do_something # function

		http://docs.python.org/2/library/types.html

----

Function
--------

.. code:: python

	def my_function(name, age=8):
	   print "My name is {0} and I am {1} years old".format(
	      name, age
	   )
		
	my_function('django')
	# My name is django and I am 8 years old
	my_function('John', 20)


.. note::
	Ask who already used python
	
	
----

Function arguments
------------------

.. code:: python

	def my_function(*args, **kwargs):
	   print "args are: {0}".format(args)
		print "kwargs are: {0}".format(kwargs)
	
	
	my_function('test', position=10, other='hello')
	# args are: ('test',)
	# kwargs are: {'position': 10, 'other': 'hello'}

----

Python class
------------

.. code:: python

		class Person(object):
		  def __init__(self, name, age):
		    self.name = name
		    self.age = age

		class Developer(Person):
		  skills = []
		  def __init__(self, name, age, skills):
		    super(Developer, self).__init__(name,age)
		    self.skills = ["skill:{0}".format(s) for s in skills]

		  def __str__(self):
		    return "{0} / {1} / {2}".format(
		      self.name, self.age, self.skills
		    )

		john = Developer("John Doe", 33, ("python", "java"))
		print john
		# John Doe / 33 / ['skill:python', 'skill:java']

	
----

Setting up a django project
===========================

.. code::

	django-admin.py startproject facile_backlog
	
	./facile_backlog/
		manage.py
		facile_backlog/
			__init__.py
			settings.py
			urls.py
			wsgi.py

----

Setting up a application
========================

.. code::

	python manage.py startapp backlog

	./facile_backlog/
		manage.py
		facile_backlog/
			__init__.py
			settings.py
			urls.py
			wsgi.py
		backlog/
			__init__.py
			models.py
			views.py

.. note::
	What is an application
	
----

The model
=========

.. code:: python

	from django.conf import settings
	from django.db import models
	from django.utils.translation import ugettext_lazy as _
	
	User = settings.AUTH_USER_MODEL #  'core.User' string
	
	class Project(models.Model):
		name = models.CharField(_('Name'), max_length=1023)
		bio = models.TextField(_('Biography'), help_text=MARKDOWN,
		                       blank=True)
		owner = models.ForeignKey(User, verbose_name=_('Owner'),
		                  	     related_name='organizations')

	class Backlog(models.Model):
		name = models.CharField(_('name'), max_length=1023)
		project = models.ForeignKey(Project, 
											 verbose_name=_('Project'),
									       related_name='people')
		
		
.. note:: 
	
	- Explain about User application.
	- localisation ( _() )
	- reference namming by Class or Application name

----

The urls
=========

----

Django Views
============


----


Database schema migration
=========================

* South (http://south.aeracode.org/)
* Will become part of django core.

----

**The End**
===========