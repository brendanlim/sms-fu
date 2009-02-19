require "action_mailer"
require File.dirname(__FILE__) + '/lib/sms_fu' 
require File.dirname(__FILE__) + '/lib/sms_fu_helper.rb'
ActionView::Base.send(:include, SMSFu)
ActionView::Base.send(:include, SMSFuHelper)