module SMSFu
  class Client
    DELIVERY_METHODS = [:action_mailer, :pony]
    attr_accessor :delivery, :pony_config

    # Sets up a new SMSFu::Client.  Allows for use of ActionMailer or
    # Pony for e-mail delivery.  Pony requires :pony_config to be 
    # defined to work properly.
    # 
    # * ActionMailer 3
    #   sms_fu = SMSFu::Client.configure(:delivery => :action_mailer)
    #
    # * Pony 1.0
    #   sms_fu = SMSFu::Client.configure(:delivery => :pony, 
    #      :pony_config => { :via => :sendmail })
    #
    def self.configure(opts = {})
      new(opts)
    end

    def initialize(opts = {})
      self.delivery     = opts[:delivery].to_sym
      self.pony_config  = opts[:pony_config]
      raise SMSFuException.new("Pony configuration required") if @delivery == :pony && @pony_config.nil?
    end

    def delivery=(new_delivery)
      if DELIVERY_METHODS.include?(new_delivery.to_sym)
        @delivery = new_delivery
      else
        raise SMSFuException.new("Delivery options can only be: '#{DELIVERY_METHODS.join(", ")}'")
      end
    end

    # Delivers the SMS message in the form of an e-mail
    #   sms_fu.deliver("1234567890","at&t","hello world")
    def deliver(number, carrier, message, options = {})
      raise SMSFuException.new("Can't deliver blank message to #{format_number(number)}") if message.nil? || message.empty?

      limit   = options[:limit] || message.length
      from    = options[:from] || SMSFu.from_address
      message = message[0..limit-1]
      email   = SMSFu.sms_address(number,carrier)

      if @delivery == :pony
        Pony.mail({:to => email, :body => message, :from => from}.merge!(@pony_config))
      else
        SMSNotifier.send_sms(email, message, from).deliver
      end
    end
  end
  
  class << self
    def config_yaml
      @@config_yaml ||= YAML::load(File.open("#{template_directory}/sms_fu.yml"))
    end
  
    # Returns back a list of all carriers
    #   SMSFu.carriers
    def carriers
      config_yaml['carriers'] 
    end
  
    def from_address
      config_yaml['config']['from_address']
    end

    def carrier_name(key)
      carrier(key)['name']
    end
  
    def carrier_email(key)
      carrier(key.downcase)['value']
    end
    
    def carrier(key)
      raise SMSFuException.new("Carrier (#{key}) is not supported") unless SMSFu.carriers.has_key?(key.downcase)
      carriers[key]
    end

    # Returns back a properly formatted SMS e-mail address
    #   SMSFu.sms_address("1234567890","at&t")
    def sms_address(number,carrier)
      raise SMSFuException.new("Missing number or carrier") if number.nil? || carrier.nil?
      format_number(number) + carrier_email(carrier.downcase)
    end

    protected

    def format_number(number)
      stripped = number.gsub("-","").strip
      formatted = (stripped.length == 11 && stripped[0,1] == "1") ? stripped[1..stripped.length] : stripped
      raise SMSFuException.new("Number (#{number}) is not formatted correctly") unless valid_number?(formatted)
      formatted
    end

    def valid_number?(number)
      number.length >= 10 && number[/^.\d+$/]
    end  

    def template_directory
      directory = defined?(Rails) ? "#{Rails.root}/config" : "#{File.dirname(__FILE__)}/../../templates"
      if (defined?(Rails) && Rails.env == 'test') || (defined?(RAILS_ENV) && RAILS_ENV == 'test)')
        "#{File.dirname(__FILE__)}/../../templates"
      else
        directory
      end
    end
  end
end

class SMSFuException < StandardError; end
