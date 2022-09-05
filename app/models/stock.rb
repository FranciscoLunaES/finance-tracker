class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      secret_token: 'secret_token',
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    begin
      stock = client.quote(ticker_symbol)
      new(ticker: ticker_symbol, name: stock.company_name, last_price: stock.latest_price)
    rescue StandardError => e
      nil
    end
  end
end
