require_relative 'credentials'
require_relative 'webdriver'

def time
  Time.new.strftime('%H:%M:%S')
end

class RegistrationHelper

  def initialize
    @driver = Webdriver.new(Watir::Browser.new)
  end

  def perform
    i = 0
    success = false
    until success do
      i += 1
      puts "perform attempt #{i*1000 - 1000} at #{time}"
      success = @driver.do_dirty_job
    end
    sleep(300)
  end
end

helper = RegistrationHelper.new
helper.perform while true
