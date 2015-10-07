#!/usr/bin/env ruby

require_relative 'credentials'
require_relative 'lib/requirements'

CONSULATE = "Польщі #{CITIES[(ARGV[0] || 0).to_i]}"

helper = RegistrationHelper.new
helper.perform while true
