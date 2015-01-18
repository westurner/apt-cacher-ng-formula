#!/usr/bin/env python

from distutils.core import setup
from distutils.cmd import Command
class TestCommand(Command):
    user_options = []

    def initialize_options(self):
        pass

    def finalize_options(self):
        pass

    def run(self):
        import sys, subprocess

        raise SystemExit(
            subprocess.call(['nosetests',
                             '--verbosity=999']))
            #subprocess.call([sys.executable,
            #                 '-m',
            #                 'nose',
            #                 ]))

setup(name='apt_cacher_ng_formula',
      version='1.0',
      description='Salt formula for apt-cacher-ng',
      author='Wes Turner',
      author_email='wes@wrd.nu',
      url='https://github.com/westurner/apt-cacher-ng-formula',
      #packages=['apt_cacher_ng'],
      requires=['saltstack', 'nose'],
      data_files=[
          ('/etc/salt/master.d/', 
           [
               'salt/master.d/conf.master.file_roots.apt-cacher-ng-formula'
           ]),

          ('/srv/formulas/apt_cacher_ng', 
           [
               'apt_cacher_ng/init.sls',
               'apt_cacher_ng/client.sls',             
               'apt_cacher_ng/map.jinja',
          ]),

          ('/srv/formulas/apt_cacher_ng/files', 
           [
               'apt_cacher_ng/files/acng.conf.jinja',
               'apt_cacher_ng/files/apt.conf.jinja',
               'apt_cacher_ng/files/acng_latest.sh',
           ])
      ],

      cmdclass={
          'test': TestCommand
      }
  )
