#!/usr/bin/env ruby

require 'json'

def setup
  unless smartthings_cli_installed?
    puts "Installing official SmartThings CLI..."
    `brew install smartthingscommunity/smartthings/smartthings`
    puts "Installed official SmartThings CLI."
  end
end

def smartthings_cli_installed?
  !!system("smartthings --version")
end

def smartthings_device_id
  devices_json = `smartthings devices --json`
  devices = JSON.parse(devices_json)
  first_ac_device = devices.detect { |device| device["ocf"]["ocfDeviceType"] == "oic.d.airconditioner" }
  unless first_ac_device
    puts "Sorry, seems like you don't have a Samsung AC"
    exit(1)
  end
  first_ac_device["deviceId"]
end

def action(action_name, *args)
  setup

  send(action_name, *args)
end

def turn_on
  `smartthings devices:commands #{smartthings_device_id} 'switch:on'`
end

def turn_off
  `smartthings devices:commands #{smartthings_device_id} 'switch:off'`
end

def turn_on_windfree_mode
  `smartthings devices:commands #{smartthings_device_id} 'custom.airConditionerOptionalMode:setAcOptionalMode("windFree")'`
end

def turn_off_windfree_mode
  `smartthings devices:commands #{smartthings_device_id} 'custom.airConditionerOptionalMode:setAcOptionalMode("off")'`
end

def integer?(value)
  Integer(value)
  true
rescue ArgumentError
  false
end

def set_temperature(temperature)
  `smartthings devices:commands #{smartthings_device_id} 'thermostatCoolingSetpoint:setCoolingSetpoint(#{temperature})'`
end

def print_usage
  puts "Usage: #{File.basename($0)} [on|off|windfree [on|off]]"
end

case ARGV[0]
when "on"
  action("turn_on")
when "off"
  action("turn_off")
when "windfree"
  case ARGV[1]
  when "on"
    action("turn_on_windfree_mode")
  when "off"
    action("turn_off_windfree_mode")
  else
    print_usage
  end
else
  if integer?(ARGV[0])
    action("set_temperature", ARGV[0].to_i)
  else
    print_usage
  end
end
