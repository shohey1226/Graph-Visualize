#!/bin/sh

perl -Mojo -E 'a({text => "<img src=\"./test.png\">"})->start' daemon
