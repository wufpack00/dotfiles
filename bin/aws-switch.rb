#!/usr/bin/env ruby

if(File.file?(File.join(File.expand_path('~'), '.aws', 'config')))
require 'inifile'
configs = IniFile.load(File.join(File.expand_path('~'), '.aws', 'config'))

profile_name_input = ARGV[0]
case profile_name_input
when 'default'
  profile_name = 'default'
when nil
  profile_name = 'default'
when ""
  profile_name = 'default'
else
  profile_name = "profile #{profile_name_input}"
end

id = configs[profile_name]['aws_access_key_id']
key = configs[profile_name]['aws_secret_access_key']
region = configs[profile_name]['region']

puts "export AWS_DEFAULT_REGION=#{region}"
puts "export AWS_ACCESS_KEY_ID=#{id}"
puts "export AWS_SECRET_ACCESS_KEY=#{key}"
puts "export AMAZON_ACCESS_KEY_ID=#{id}"
puts "export AMAZON_SECRET_ACCESS_KEY=#{key}"
puts "export AWS_ACCESS_KEY=#{id}"
puts "export AWS_SECRET_KEY=#{key}"

end
