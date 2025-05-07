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

def action(ac_number, action_name, *args)
  install_prerequisities

  devices_json = `smartthings devices --json`
  devices = JSON.parse(devices_json)
  device = devices.sort_by { |device| device["createTime"] }[ac_number - 1]
  unless device
    puts "Please provide a valid ac number as the first argument"
    exit(1)
  end
  device = AcDevice.new(device["deviceId"])
  device.public_send(action_name, *args)
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

action_name = ARGV[1]
case action_name
when "on"
  action(ac_number, "turn_on")
when "off"
  action(ac_number, "turn_off")
when "windfree"
  case action_name
  when "on"
    action(ac_number, "turn_on_windfree_mode")
  when "off"
    action(ac_number, "turn_off_windfree_mode")
  else
    print_usage
  end
else
  if integer?(action_name)
    action(ac_number, "set_temperature", action_name.to_i)
  else
    print_usage
  end
end
