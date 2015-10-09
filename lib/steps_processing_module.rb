module StepsProcessing
  module_function
  def pass_first_page
    browser.goto 'www.polandvisa-ukraine.com/scheduleappointment_2.html'
    iframe.link(id: 'ctl00_plhMain_lnkSchApp').click
  end

  def pass_second_page
    iframe.select_list(id: 'ctl00_plhMain_cboVAC').select CONSULATE
    iframe.select_list(id: 'ctl00_plhMain_cboPurpose').select 'Подача документів'
    submit
  end

  def submit
    iframe.input(id: 'ctl00_plhMain_btnSubmit').click
  end

  def do_proper_select
    selector = iframe.select_list id: 'ctl00_plhMain_cboVisaCategory'
    selector.select selector.selected?(VISA_TYPE) ? '-Оберіть візову категорію-' : VISA_TYPE
  end

  def date_available?
    iframe.span(id: 'ctl00_plhMain_lblMsg').text.include? '20'
  end

  def fill_reciept_number
    iframe.text_field(id: 'ctl00_plhMain_repAppReceiptDetails_ctl01_txtReceiptNumber').set RECIEPT_NUMBER
    submit
  end

  def fill_email_and_password
    iframe.text_field(id: 'ctl00_plhMain_txtEmailID').set EMAIL_FOR_REGISTRATION
    iframe.text_field(id: 'ctl00_plhMain_txtPassword').set PASSWORD_FOR_REGISTRATION
    iframe.input(id: 'ctl00_plhMain_btnSubmitDetails').click
  end

  def fill_register_form
    iframe.text_field(id: 'ctl00_plhMain_repAppVisaDetails_ctl01_tbxPPTEXPDT').set PASSPORT_END_DATE
    iframe.select_list(id: 'ctl00_plhMain_repAppVisaDetails_ctl01_cboTitle').select STATUS
    iframe.text_field(id: 'ctl00_plhMain_repAppVisaDetails_ctl01_tbxFName').set FIRST_NAME
    iframe.text_field(id: 'ctl00_plhMain_repAppVisaDetails_ctl01_tbxLName').set LAST_NAME
    iframe.text_field(id: 'ctl00_plhMain_repAppVisaDetails_ctl01_tbxDOB').set BIRTH_DATE
    iframe.text_field(id: 'ctl00_plhMain_repAppVisaDetails_ctl01_tbxReturn').set RETURN_DATE
    iframe.text_field(id: 'ctl00_plhMain_repAppVisaDetails_ctl01_tbxContactNumber').set PHONE_NUMBER
    iframe.select_list(id: 'ctl00_plhMain_repAppVisaDetails_ctl01_cboNationality').select NATIONALITY
    fill_captcha_and_submit
    puts 'please finish by yourself.   Press enter when you are done'
    STDIN.gets
  end
end
