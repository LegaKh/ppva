class Webdriver
  include StepsProcessing

  attr_reader :browser

  def initialize browser
    @browser = browser
  end

  def register_me
    prepare
    return true if TWO_CAPTCHA_API_KEY.length == 0
    fill_captcha_and_submit
    fill_reciept_number
    fill_email_and_password
    fill_register_form

    rescue => e
      puts "ERROR: #{e.message} at #{time}"
      return false
  end

  private

  def prepare
    pass_first_page
    pass_second_page
    do_clicks
    notify! if NOTIFICATE
  end

  def do_clicks
    loop do
      sleep 2
      do_proper_select
      break if date_available?
    end
  end

  def notify!
    message = iframe.span(id: 'ctl00_plhMain_lblMsg').text + ' ' + CONSULATE
    Notifyer.notify message
  end

  def iframe
    browser.iframe
  end

  def text_from_captcha
    img_url = iframe.image(id: 'recaptcha_challenge_image').src
    CaptchaResolver.resolve img_url
  end

  def fill_captcha_and_submit
    iframe.text_field(id: 'recaptcha_response_field').set text_from_captcha
    submit
  end
end
