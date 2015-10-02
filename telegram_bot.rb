require 'telegram/bot'

class TelegramNotifier

  def initialize(message)
    @message = message
  end

  def notify
    Telegram::Bot::Client.run(TELEGRAM_TOKEN) do |bot|
      5.times do
        bot.api.sendMessage(chat_id: 5827016, text: @message)
        sleep(2)
      end
    end
  end
end
