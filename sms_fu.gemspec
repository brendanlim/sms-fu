# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sms_fu}
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brendan G. Lim"]
  s.date = %q{2010-08-23}
  s.description = %q{SMS Fu allows you to send text messages to a mobile recipient for free.  It leverages ActionMailer or Pony for delivery of text messages through e-mail.}
  s.email = %q{brendangl@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "CHANGELOG",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "install.rb",
     "lib/sms_fu.rb",
     "lib/sms_fu/sms_fu.rb",
     "lib/sms_fu/sms_fu_helper.rb",
     "lib/sms_fu/sms_notifier.rb",
     "sms_fu.gemspec",
     "tasks/sms_fu_tasks.rake",
     "templates/sms_fu.yml",
     "test/sms_fu_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/brendanlim/sms-fu}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{sms_fu allows you to send free text messages to a mobile recipient.}
  s.test_files = [
    "test/sms_fu_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<action_mailer>, [">= 3.0.0.rc2"])
      s.add_development_dependency(%q<pony>, [">= 1.0"])
    else
      s.add_dependency(%q<action_mailer>, [">= 3.0.0.rc2"])
      s.add_dependency(%q<pony>, [">= 1.0"])
    end
  else
    s.add_dependency(%q<action_mailer>, [">= 3.0.0.rc2"])
    s.add_dependency(%q<pony>, [">= 1.0"])
  end
end
