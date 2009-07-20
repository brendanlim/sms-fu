# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sms-fu}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brendan G. Lim"]
  s.date = %q{2009-07-20}
  s.description = %q{SMS Fu allows ou to send a text-message for free in the form of an e-mail to a mobile recipient.}
  s.email = %q{brendangl@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "CHANGELOG",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "init.rb",
     "install.rb",
     "lib/sms_fu.rb",
     "lib/sms_fu_helper.rb",
     "lib/sms_notifier.rb",
     "sms-fu.gemspec",
     "tasks/sms_fu_tasks.rake",
     "templates/sms_fu.yml",
     "test/sms_fu_test.rb",
     "uninstall.rb",
     "views/sms_notifier/sms_message.html.erb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/brendanlim/sms-fu}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{SMS Fu allows ou to send a text-message for free in the form of an e-mail to a mobile recipient.}
  s.test_files = [
    "test/sms_fu_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
