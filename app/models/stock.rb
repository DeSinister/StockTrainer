class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks



  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: "Tpk_826ceb1c02c24265b0ed1f6627db60d0",
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.make_chart(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: ENV["PUBLISHABLE"],
      endpoint: 'https://sandbox.iexapis.com/v1'
      # secret_token: ENV["SECRET"],
      # endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin
      client.chart(ticker_symbol)
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
