require 'ftools'
require 'fileutils'
puts IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
File.copy(File.dirname(__FILE__)+'/templates/sms_fu.yml', File.dirname(__FILE__)+'/../../../config')