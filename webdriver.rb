require 'watir-webdriver'

class Webdriver
  attr_accessor :b, :success

  def initialize(browser)
    @b = browser
    @success = false
  end

  def do_dirty_job
    prepare rescue return false
    50.times do
      begin
        do_proper_select
        if success = check_sucess
          notify!
          return success
        else
          sleep(4)
        end
      rescue
        return false
      end
    end
    false
  end

  private

  def prepare
    pass_first_page
    pass_second_page
  end

  def pass_first_page
    b.goto 'www.polandvisa-ukraine.com/scheduleappointment_2.html'
    b.iframe.link(id: 'ctl00_plhMain_lnkSchApp').click
  end

  def pass_second_page
    b.iframe.select_list(id: 'ctl00_plhMain_cboVAC').select('Польщі Одеса') #('Польщі Одеса') for tests Харків
    b.iframe.select_list(id: 'ctl00_plhMain_cboPurpose').select('Подача документів')
    b.iframe.input(id: 'ctl00_plhMain_btnSubmit').click
  end

  def do_proper_select
    selector = b.iframe.select_list(id: 'ctl00_plhMain_cboVisaCategory')
    selector.select(selector.selected?('-Оберіть візову категорію-') ? 'Національна Віза' : '-Оберіть візову категорію-')
  end

  def check_sucess
    b.iframe.span(id: 'ctl00_plhMain_lblMsg').exist? &&
    b.iframe.span(id: 'ctl00_plhMain_lblMsg').text.include?('2015')
  end

  def notify!
    message = b.iframe.span(id: 'ctl00_plhMain_lblMsg').text
    th1 = Thread.new { TelegramNotifier.new(message).notify }
    th2 = Thread.new { NotificationMailer.new(EMAIL, PASSWORD).notify }
    [th1, th2].each(&:join)
  end
end
