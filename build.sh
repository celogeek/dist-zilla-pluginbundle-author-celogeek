#!/bin/bash
export PERLLIB=lib
dzil clean
dzil build
cp Dist-Zilla-PluginBundle-Author-Celogeek-*/README.mkdn .

