require 'json'
require 'digest'
require 'bigdecimal'
require 'bigdecimal/util'

class AliPay
  PARTNER = '2088021966388155'
  PARTNER_KEY = 'w0nu2sn0o97s8ruzrpj64fgc8vj8wus6'
  HTTPS_REQUEST_URL = 'https://intlmapi.alipay.com/gateway.do' # production
  #HTTPS_REQUEST_URL = 'https://openapi.alipaydev.com/gateway.do' # test

  def initialize(_input_charset: nil,
                 extend_params: nil,
                 notify_url: nil,
                 price: nil,
                 quantity: nil,
                 show_url: nil,
                 timestamp: nil,
                 trans_currency: nil,
                 out_trade_no: nil,
                 seller_email: nil,
                 sendFormat: nil
                )
    @_input_charset = _input_charset
    @extend_params = extend_params
    @notify_url = notify_url
    @price = price
    @quantity = quantity
    @show_url = show_url
    @timestamp = timestamp
    @trans_currency = trans_currency
    @out_trade_no = out_trade_no
    @seller_email = seller_email
    @sendFormat = sendFormat
  end

  def query_params
    params = {
      "_input_charset"      => @_input_charset,
      "body"                => "iphone cellphone",
      "currency"            => "USD",
      "extend_params"       => @extend_params.to_json,
      "notify_url"          => @notify_url,
      "partner"             => PARTNER,
      "passback_parameters" => "test",
      "price"               => @price,
      "product_code"        => "OVERSEAS_MBARCODE_PAY",
      "quantity"            => @quantity,
      "seller_email"        => @seller_email,
      "seller_id"           => PARTNER,
      "service"             => "alipay.acquire.precreate",
      "show_url"            => @show_url,
      "subject"             => "Payment by QR-Code",
      "total_fee"           => @price, #(@price.to_d * @quantity).to_s,
      "trans_currency"      => @trans_currency
    }
    params = params.merge("timestamp" => @timestamp) if @timestamp
    params = params.merge("out_trade_no" => @out_trade_no) if @out_trade_no
    params = params.merge("sendFormat" => @sendFormat) if @sendFormat
    params
  end

  def md5_sign
    query_params_string = hash_to_sorted_query_params(query_params)
    Digest::MD5.hexdigest(query_params_string + PARTNER_KEY)
  end

  def pay_url
    query_params_string = hash_to_sorted_query_params(query_params)
    query_params_string = [query_params_string, "sign=#{md5_sign}"].join('&')
    # TODO use proper URI or CGI to create query params
    [HTTPS_REQUEST_URL, query_params_string].join('?')
  end

  private

  def hash_to_sorted_query_params(hash)
    hash
      .sort
      .to_h
      .inject([]) {|ary, (k, v)| ary << "#{k}=#{v}" }
      .join('&')
  end
end

