require 'watir-webdriver'

require_relative 'notifyer'

class Webdriver
  attr_reader :browser

  def initialize(browser)
    @browser = browser
  end

  def do_dirty_job
    begin
      prepare
      1000.times do
        do_proper_select
        if sucess?
          notify!
          return true
        end
        sleep(2)
      end
    rescue => e
      puts "ERROR: #{e.message} at #{time}"
    end
    false
  end

  private

  def prepare
    pass_first_page
    pass_second_page
  end

  def pass_first_page
    browser.goto 'www.polandvisa-ukraine.com/scheduleappointment_2.html'
    iframe.link(id: 'ctl00_plhMain_lnkSchApp').click
  end

  def pass_second_page
    iframe.select_list(id: 'ctl00_plhMain_cboVAC').select(CONSULATE)
    iframe.select_list(id: 'ctl00_plhMain_cboPurpose').select('Подача документів')
    iframe.input(id: 'ctl00_plhMain_btnSubmit').click
  end

  def do_proper_select
    selector = iframe.select_list(id: 'ctl00_plhMain_cboVisaCategory')
    selector.select(selector.selected?('-Оберіть візову категорію-') ? VISA_TYPE : '-Оберіть візову категорію-')
  end

  def sucess?
    iframe.span(id: 'ctl00_plhMain_lblMsg').exist? &&
    iframe.span(id: 'ctl00_plhMain_lblMsg').text.include?('2015')
  end

  def notify!
    message = iframe.span(id: 'ctl00_plhMain_lblMsg').text
    Notifyer.notify!(message)
  end

  def iframe
    browser.iframe
  end
end
