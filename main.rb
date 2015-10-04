#!/usr/bin/env ruby

require_relative 'credentials'
require_relative 'lib/requirements'

helper = RegistrationHelper.new
helper.perform while true
