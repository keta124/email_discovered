require 'coinbase/wallet'

class BitcoinPriceCrawler
  class << self

    def coinbase
      client = Coinbase::Wallet::Client.new(api_key: "UHjU5ZUDjh4cRZxs",
                                            api_secret: "PIvQBT2amWSqQwkhFjmrNwKq6Ej2nAFQ",
                                            CB_VERSION: "2017-05-19")

      currency_code = 'USD'

      current = client.spot_price(currency: currency_code).amount.to_f
      CoinBaseDatum.create! created_at: Time.current, currency: currency_code, price: current
    end

    def bitfinex
      data = Bitfinex::Client.new.ticker
      BitfinexDatum.create!(
        price: data["last_price"].to_f,
        currency: 'USD',
        created_at: Time.zone.at(data["timestamp"].to_f)
      )
    end

    def cex
      data = CEX::API.new("up107234684", "47voKyYL3jpPJDEJtgMLqUGe0", "PaLOf4rhg2HqZcEHUcIFPoq5As").ticker('BTC/USD')
      CexDatum.create!(
        price: data["last"].to_f,
        currency: 'USD',
        created_at: Time.zone.at(data["timestamp"].to_f)
      )
    end

  end
end
