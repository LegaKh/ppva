class RegistrationHelper

  def initialize
    @driver = Webdriver.new(Watir::Browser.new)
  end

  def perform
    free_date = false
    until free_date do
      puts "perform new attempt at #{time}"
      free_date = @driver.do_dirty_job
    end
    sleep(300)
  end
end

def time
  Time.new.strftime('%H:%M:%S')
end
