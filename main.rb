require_relative 'mailer'
require_relative 'webdriver'
require_relative 'telegram_bot'
require_relative 'credentials'

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
      puts "perform attempt #{i*50 - 50}"
      success = browser.do_dirty_job
      sleep(5)
    end
    sleep(60)
  end
end

helper = RegistrationHelper.new
helper.perform while true
