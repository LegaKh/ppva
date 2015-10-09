module CaptchaResolver
  def self.resolve url
    puts 'processing captcha'
    TwoCaptcha.new(TWO_CAPTCHA_API_KEY).decode!(url: url).text
  end
end
