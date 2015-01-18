===============================
apt-cacher-ng-formula
===============================

Salt formula for apt-cacher-ng

* Free software: BSD license
* SaltStack Formula

Installation
------------------------------------

python setup.py install --root=SALTROOT

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``apt-cacher-ng``
-------------------------------------

Installs the apt-cacher-ng package,
templates ``/etc/apt-cacher-ng/acng.conf`` from pillar and a map file,
and starts the associated apt-cacher-ng service.

``apt-cacher-ng.client``
-------------------------------------
Creates ``/etc/apt/apt.conf`` with the apt-cacher-ng server URL from
``pillar.get('apt:proxy_url')``.


