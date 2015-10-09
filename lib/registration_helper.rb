class RegistrationHelper

  def initialize
    @driver = Webdriver.new Watir::Browser.new
  end

  def perform
    succes = false
    until succes do
      puts "perform new attempt at #{time}"
      succes = @driver.register_me
    end
    sleep 60
  end
end

def time
  Time.new.strftime '%H:%M:%S'
end
