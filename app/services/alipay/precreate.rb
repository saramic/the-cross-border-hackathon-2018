module Alipay
  class Precreate < Base
    def self.fetch(out_trade_no:)
      default_params = {
          _input_charset: 'utf-8',
          body: 'iphone cellphone',    # Specific description of the trade
          currency: 'USD',             # Settlement currency
          out_trade_no: nil,           # Unique order ID in Alipay’s merchant website
          partner: 2088021966388155,
          passback_parameters: 'test', # Alipay will feekback this parameter by the asynchronous notify
          extend_params: {             # Be used for transmitting specific business information of the merchant
                                       "secondary_merchant_name"     => "Lotte",
                                       "secondary_merchant_id"       => "123",
                                       "secondary_merchant_industry" => "5812",
                                       "store_id"                    => "A101",
                                       "store_name"                  => "McDonald in 966 3rd Ave, New York"
                         }.to_json,
          # TODO change price to mandatory input
          price: 0.01,                 # 0.01 # Unit price of the goods in the order
          product_code:
              'OVERSEAS_MBARCODE_PAY', # Order placement used to distinguish the business type
          # TODO change quantity to mandatory input
          quantity: 1,                 # Quantity of the goods in the order
          seller_email:                # Seller's Alipay account
                     'testoverseas1980@alipay.com',
          seller_id: 2088021966388155, # Unique Alipay user ID corresponding to Seller’s Alipay account 16 numbers beginning with 2088
          show_url:                    # Hyperlink for the show of goods on the webpage of checkout counter
              'http://www.taobao.com/product/113714.html',
          subject:
              'Payment by QR-Code',    # Goods title/trade tile/order subject/order key word etc
          # TODO change to be calculated
          total_fee: 0.01,             # Total fee of this order
          trans_currency: 'USD',       # Pricing currency for the transaction
          notify_url:                  # Alipay server takes the initiative to notify merchant of webpage http path designated by website
                   'http:/127.0.0.1/alipay.acquire.precreate-PHP-UTF-8-MD5/notify_url.php',
          service: "alipay.acquire.precreate"
      }
      params = default_params.merge(
          out_trade_no: out_trade_no,
          timestamp: Time.now.getlocal('+08:00').strftime('%F %T') # TODO do this right on sign and send?
      )
      response = Alipay::Request.get(params)
      Precreate.new(response)
    end

    def initialize(response)
      @doc = Nokogiri::XML.parse(response.body)
    end

    def pic_url
      @doc.xpath('/alipay/response/alipay/pic_url').text
    end
  end
end

