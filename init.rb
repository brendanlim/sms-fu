require 'actionmailer'
require 'sms_fu'
require 'sms_fu_helper'

ActionController::Base.send(:include, SMSFu)
ActionView::Base.send(:include, SMSFuHelper)
