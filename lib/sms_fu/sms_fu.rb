class SMSFu
  DELIVERY_OPTIONS = [:action_mailer, :pony]
  
  def self.configure(options = {})
    new(options)
  end

  def initialize(options = {})
    raise_exception("Delivery options can only be: '#{DELIVERY_OPTIONS.join(", ")}'") unless DELIVERY_OPTIONS.include?(options[:delivery])
    if options[:delivery] == :pony && (options[:pony_options][:via].to_sym != :sendmail && !options[:pony_options].has_key?(:via_options))
      raise_exception("Missing Pony configuration options") 
    end
    
    @@mail_config = { :delivery => options[:delivery].to_sym, :pony_options => options[:pony_options] }
    @@yaml_config = YAML::load(options[:yaml_config] ? options[:yaml_config] : File.open("#{template_directory}/sms_fu.yml"))
  end
  
  def from_address
    @@yaml_config['config']['from_address']
  end

  def carriers
    @@yaml_config['carriers'] 
  end

  def carrier_name(key)
    carrier(key)['name']
  end
  
  def carrier_email(key)
    carrier(key.downcase)['value']
  end
  
  def carrier(key)
    raise_exception("Carrier (#{key}) is not supported") unless carriers.has_key?(key.downcase)
    carriers[key]
  end

  def deliver(number, carrier, message, options = {})
    raise_exception("Can't deliver blank message to #{format_number(number)}") if message.nil? or message.empty?
    limit   = options[:limit] || message.length
    from    = options[:from] || from_address
    message = message[0..limit-1]
    email   = sms_address(number,carrier)
  
    if @@mail_config[:delivery] == :pony
      Pony.mail(:to => email, 
        :body => message, 
        :from => from, 
        :via => @@mail_config[:pony_options][:via],
        :via_options => @@mail_config[:pony_options][:via_options])
    else
      SMSNotifier.send_sms(email, message, from).deliver
    end
  end

  def sms_address(number,carrier)
    format_number(number) + carrier_email(carrier.downcase)
  end

  protected

  def format_number(number)
    stripped = number.gsub("-","").strip
    formatted = (stripped.length == 11 && stripped[0,1] == "1") ? stripped[1..stripped.length] : stripped
    raise_exception("Number (#{number}) is not formatted correctly") unless valid_number?(formatted)
    formatted
  end

  def valid_number?(number)
    number.length >= 10 && number[/^.\d+$/]
  end  

  def template_directory
    directory = defined?(Rails) ? "#{RAILS_ROOT}/config" : "#{File.dirname(__FILE__)}/../../templates"
    if (defined?(Rails) && Rails.env == 'test') || (defined?(RAILS_ENV) && RAILS_ENV == 'test)')
      "#{File.dirname(__FILE__)}/../../templates"
    else
      directory
    end
  end
  
  def raise_exception(message)
    raise SMSFuException.new(message)
  end
end

class SMSFuException < StandardError; end