#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
test_apt-cacher-ng_formula
----------------------------------

Tests for `apt_cacher_ng_formula` module.
"""

import unittest
import salt.utils.templates
import salt.template
import salt.loader
import salt.renderers.jinja
import pprint
import logging
import sys
logging.basicConfig(
    stream=sys.stderr,
    level=logging.DEBUG
)

import salt.renderers.jinja
import salt.transport
import pprint
from mock import MagicMock
import mock




class TestAptCacherNgFormula(unittest.TestCase):

    def setUp(self):

        salt.renderers.jinja.__salt__= MagicMock()
        salt.renderers.jinja.__grains__= MagicMock()
        salt.renderers.jinja.__opts__= {
            'cachedir' : "/tmp/cachedir",
            'jinja_trim_blocks' : False,
            'jinja_lstrip_blocks' : False,
            'allow_undefined' : False,
            'file_client' : 'remote',
            'transport' : 'local', #'raet', 'zeromq' 
            'id' : 'somerole',
            '__role' : 'master', # minion
            'pillar' : {},
            'master' : {},
            'pki_dir' : '/tmp/pki',
            #call.__getitem__().__iadd__('minion.pub'),
            #('minion.pem'),
            'syndic_master' : None,
            'alert_master' : None
        }

        salt.renderers.jinja.__pillar__= {
            'message_do_not_modify' : 'do not modify'
        }
        
        self.things = {
            "SALT": salt.renderers.jinja.__salt__,
            "GRAINS": salt.renderers.jinja.__grains__,
        }

        return True

    def test_jinga_acng_conf(self):

        sfn = './apt-cacher-ng/files/acng.conf.jinja'
        rend = salt.renderers.jinja.render
        x = salt.template.compile_template(sfn, {'':rend}, default='')
        pprint.pprint(x)

        return True

    def tearDown(self):
        #return True
        for k in self.things.keys():
            o = self.things[k]
            print k, 
            pprint.pprint(o.mock_calls)
            
        pprint.pprint({
            "OPTS": salt.renderers.jinja.__opts__,
            "PILLAR" : salt.renderers.jinja.__pillar__
        })
            

if __name__ == '__main__':
    unittest.main()
