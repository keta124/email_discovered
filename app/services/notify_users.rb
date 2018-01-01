class NotifyUsers
  def self.call model, price
    yesterday = model.constantize.where("created_at >= ?", Time.current - 1.day).order(created_at: :asc).first.price
    last_week = model.constantize.where("created_at >= ?", Time.current - 1.week).order(created_at: :asc).first.price
    last_month = model.constantize.where("created_at >= ?", Time.current - 1.month).order(created_at: :asc).first.price
    price = price.to_f
    yesterday_price_changed = (price - yesterday).abs
    yesterday_percent_changed = ((price - yesterday) / yesterday).abs
    last_week_price_changed = (price - last_week).abs
    last_week_percent_changed = ((price - last_week) / last_week).abs
    last_month_price_changed = (price - last_month).abs
    last_month_percent_changed = ((price - last_month) / last_month).abs

    scope = case model
      when CoinBaseDatum.name
        Condition.coinbase
      when BitfinexDatum.name
        Condition.bitfinex
      when CexDatum.name
        Condition.cex
      end
    scope.find_each do |condition|
      next unless condition.mailable?
      send = case
        when condition.yesterday? && condition.percent?
          condition.value <= yesterday_percent_changed
        when condition.yesterday? && condition.price?
          condition.value <= yesterday_price_changed
        when condition.one_week_ago? && condition.percent?
          condition.value <= last_week_percent_changed
        when condition.one_week_ago? && condition.price?
          condition.value <= last_week_price_changed
        when condition.one_month_ago? && condition.percent?
          condition.value <= last_month_percent_changed
        when condition.one_month_ago? && condition.price?
          condition.value <= last_month_price_changed
        end
      NotificationMailer.notify(condition).deliver_later if send
    end
  end
end
