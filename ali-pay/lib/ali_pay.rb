require 'json'

class AliPay
  PARTNER = '2088021966388155'
  PARTNER_KEY = 'w0nu2sn0o97s8ruzrpj64fgc8vj8wus6'
  HTTPS_REQUEST_URL = 'https://intlmapi.alipay.com/gateway.do' # production

  PARAMS = {
    "service"       => "create_forex_trade",
    "partner"       => "2088101568338364",
    "_input_charset"=> "gbk",
    "return_url"    => "http://www.test.com/alipay/return_url.asp",
    "out_trade_no"  => "6741334835157966",
    "subject"       => "test",
    "payment_type"  => "1",
    "seller_email"  => "alipay-test01@alipay.com",
    "total_fee"     => "100"
  }

  def pay_url
    extended_parameters = {
      "secondary_merchant_name"     => "Lotte",
      "secondary_merchant_id"       => "123",
      "secondary_merchant_industry" => "5812",
      "store_id"                    => "A101",
      "store_name"                  => "McDonald in 966 3rd Ave, New York"
    }
    query_params = {
      "_input_charset"      => "UTF-8",
      "body"                => "iphone cellphone",
      "currency"            => "USD",
      "extend_params"       => extended_parameters.to_json,
      "notify_url"          => "http://api.test.alipay.net/atinterface/receive_notify.htm",
      "out_trade_no"        => "4363476566647440",
      "partner"             => "2088021966388155",
      "passback_parameters" => "test",
      "price"               => "0.01",
      "product_code"        => "OVERSEAS_MBARCODE_PAY",
      "quantity"            => "1",
      "seller_email"        => " testoverseas1980@alipay.com",
      "seller_id"           => PARTNER,
      "sendFormat"          => "normal",
      "service"             => "alipay.acquire.precreate",
      "show_url"            => "http://www.taobao.com/product/113714.html",
      "subject"             => "Payment by QR-Code",
      "total_fee"           => "0.01",
      "trans_currency"      => "USD"
    }
    query_params_string = hash_to_sorted_query_params(query_params)
    query_params_string = [query_params_string, "sign=2127020ad640f41eec725c639f1de294"].join('&')
    # TODO use proper URI or CGI to create query params
    [HTTPS_REQUEST_URL, query_params_string].join('?')
  end

  def pay
    hash_to_sorted_query_params(PARAMS)
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

