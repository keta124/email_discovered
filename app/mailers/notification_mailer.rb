class NotificationMailer < ApplicationMailer

  def notify condition
    return unless condition.mailable?
    condition.update! last_notified_at: Time.current
    mail to: condition.user.email, subject: generate_subject(condition)
  end

  private
  def generate_subject condition
    case
    when condition.yesterday?
      "BTC price has changed more than #{condition.value} since yesterday on #{condition.source}"
    when condition.one_week_ago?
      "BTC price has changed more than #{condition.value} since last week on #{condition.source}"
    when condition.one_month_ago?
      "BTC price has changed more than #{condition.value} since last month on #{condition.source}"
    when condition.one_year_ago?
      "BTC price has changed more than #{condition.value} since last year on #{condition.source}"
    end
  end

end
