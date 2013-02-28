#!/usr/bin/env ruby

require File.expand_path('../../config/application', __FILE__)

# Daemons sets pwd to /, so we have to explicitly set RAILS_ROOT
RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

require 'rubygems'
require 'apn'
require 'apn/sender_daemon'

APN::SenderDaemon.new(ARGV).daemonize