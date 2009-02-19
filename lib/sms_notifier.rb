require 'yaml'
# Copyright (c) 2008 Brendan G. Lim (brendangl@gmail.com)
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

class SmsNotifier < ActionMailer::Base
  @config = YAML::load(File.open("#{RAILS_ROOT}/config/sms_fu.yml"))

  def sms_message(recipient, message, sender_email)
    content_type      "text/plain"
    recipients        recipient
    from              sender_email
    body['message'] = message
  end

  view_path = File.join(File.dirname(__FILE__), '..', 'views')
  if public_methods.include?('append_view_path')
    self.append_view_path view_path
  elsif public_methods.include?("view_paths")
    self.view_paths << view_path
  else
    self.template_root = view_path
  end
  
end