require_relative 'credentials'
require_relative 'webdriver'

class RegistrationHelper
  attr_reader :browser

  def initialize
    @browser = Webdriver.new(Watir::Browser.new)
  end

  def perform
    i = 0
    success = false
    until success do
      i += 1
      puts "perform attempt #{i*1000 - 1000} at #{Time.new.strftime('%H:%M:%S')}"
      success = browser.do_dirty_job
    end
    sleep(300)
  end
end

helper = RegistrationHelper.new
helper.perform while true
