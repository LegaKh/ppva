class Webdriver
  attr_reader :browser

  def initialize(browser)
    @browser = browser
  end

  def do_dirty_job
    prepare
    do_clicks
    notify!
    rescue => e
      puts "ERROR: #{e.message} at #{time}"
      return false
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

  def do_clicks
    loop do
      sleep(2)
      do_proper_select
      break if sucess?
    end
  end

  def sucess?
    iframe.span(id: 'ctl00_plhMain_lblMsg').exist? &&
    iframe.span(id: 'ctl00_plhMain_lblMsg').text.include?('2015')
  end

  def notify!
    Notifyer.notify(iframe.span(id: 'ctl00_plhMain_lblMsg').text)
  end

  def iframe
    browser.iframe
  end
end
