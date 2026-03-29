#!/usr/bin/env ruby

require 'json'

# require 'pry'

class AcDevice
  def initialize(id)
    @id = id
  end

  def turn_on
    `smartthings devices:commands #{@id} 'switch:on'`
  end

  def turn_off
    `smartthings devices:commands #{@id} 'switch:off'`
  end

  def turn_on_windfree_mode
    `smartthings devices:commands #{@id} 'custom.airConditionerOptionalMode:setAcOptionalMode("windFree")'`
  end

  def turn_off_windfree_mode
    `smartthings devices:commands #{@id} 'custom.airConditionerOptionalMode:setAcOptionalMode("off")'`
  end

  def set_temperature(temperature)
    `smartthings devices:commands #{@id} 'thermostatCoolingSetpoint:setCoolingSetpoint(#{temperature})'`
  end
end

def install_prerequisities
  unless smartthings_cli_installed?
    puts "Installing official SmartThings CLI..."
    `brew install smartthingscommunity/smartthings/smartthings`
    puts "Installed official SmartThings CLI."
  end
end

def smartthings_cli_installed?
  !!system("smartthings --version")
end

def ac_device(ac_number)
  install_prerequisities

  devices_json = `smartthings devices --json`
  devices = JSON.parse(devices_json)
  record = devices.sort_by { |device| device["createTime"] }[ac_number - 1]
  unless record
    puts "Please provide a valid ac number as the first argument"
    exit(1)
  end
  AcDevice.new(record["deviceId"])
end

def integer?(value)
  Integer(value)
  true
rescue ArgumentError
  false
end

def print_usage
  puts "Usage: #{File.basename($0)} [ac_number] [on|off|windfree [on|off]]"
end

if !integer?(ARGV[0])
  print_usage
  exit(1)
end
ac_number = ARGV[0].to_i

subcommand = ARGV[1]
case subcommand
when "on"
  ac_device(ac_number).turn_on
when "off"
  ac_device(ac_number).turn_off
when "windfree"
  case ARGV[2]
  when "on"
    ac_device(ac_number).turn_on_windfree_mode
  when "off"
    ac_device(ac_number).turn_off_windfree_mode
  else
    print_usage
  end
else
  if integer?(subcommand)
    ac_device(ac_number).set_temperature(subcommand.to_i)
  else
    print_usage
  end
end
