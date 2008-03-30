require "action_mailer"
require File.dirname(__FILE__) + '/lib/sms_fu' 
ActionView::Base.send(:include, SMSFu)