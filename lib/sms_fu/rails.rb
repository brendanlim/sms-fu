module SMSFu
  class Engine < ::Rails::Engine
    initializer "setup for rails" do
      ActionView::Base.send :include, SMSFuHelper
    end
  end
end
