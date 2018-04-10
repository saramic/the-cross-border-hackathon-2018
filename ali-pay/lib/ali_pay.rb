require 'json'
require 'digest'
require 'bigdecimal'
require 'bigdecimal/util'
require 'alipay/sign/rsa'

class AliPay
  PARTNER = '2088021966388155'
  PARTNER_KEY = 'w0nu2sn0o97s8ruzrpj64fgc8vj8wus6'
  HTTPS_REQUEST_URL = 'https://intlmapi.alipay.com/gateway.do' # production
  #HTTPS_REQUEST_URL = 'https://openapi.alipaydev.com/gateway.do' # test

  APP_PRIVATE_KEY = """-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQD7FfmVdd570cFX3G76FatugmYlGNFtw9b2kFiBPvJDM0yeX52S
WqAtjVBizaf6zNzib1a9xety7dnAxELidQJmUj3z4lwb3j5PRn+lx5FeAyAJWRBS
m5+J3AzhOoHpStgATvEXT/AUndrgdn5Adfi45koUB8IzJzGZmk+5DabrIwIDAQAB
AoGABd2WjgpJ30SgKqhIo2j8L0G2lylEQzcu/2WR27sXt8AsCwsayD97vHSvqw84
3GAKzPNi6F4GSRILYzhyg43ON3/d3m/S1iTgSFXchTyAsAjy398Iq/ufSj9DOj+u
I88XZ7JVt7jEyihPldSh7FkuMKaaFkJdsNz22LfD3NZIBVECQQD+I/zp+OuxmW5D
GcNDEIXF0bl3mmCAv041ZBBO5JCYrgvpkofC6SRlOi+P3BPXYPHZjyU3Jp3XgaJD
QvHCEkXbAkEA/OxD8FDM5i1JqcwIzha+NyJdm3nJ7Njlx4VIKD9Kx10oG49ge7gG
8fDC7FwduGupfPj9ycKsHBFWC+AIUPSGWQJASqzWbwWWc+wKiyrxxi3/sL3MSomR
G6Oa3nNVm2jr2AEkPPCydaI98ISlXxciuWGiDvRR0h/Ft4I+5JayJP1riwJAHe6o
K6ykUylQ6nNnJ1yxrjy270t+hjU1HGO9omW7J9TyhjB1rq6cw81GhEpyifzT1iJx
hosvazLyB/2/fjUyIQJBAJDzo5n2tVhsQEe5aNlF5ZHTtReyTMnPR4HgfBqGWydc
DV/Wx7roFLX0dYT71CMD3vvHtda0qfNpQe8nM43lJfc=
-----END RSA PRIVATE KEY-----
"""

  ALIPAY_PUBLIC_KEY = <<-EOF
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB

-----END PUBLIC KEY-----
EOF

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
                 sendFormat: nil,
                 sign_type: nil
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
    @sign_type = sign_type
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

  def sign
    query_params_string = hash_to_sorted_query_params(query_params)
    if @sign_type == 'RSA'
      Alipay::Sign::RSA.sign(APP_PRIVATE_KEY, query_params_string)
    else
      Digest::MD5.hexdigest(query_params_string + PARTNER_KEY)
    end
  end

  def pay_url
    query_params_string = hash_to_sorted_query_params(query_params)
    query_params_string = [query_params_string, "sign=#{sign}"].join('&')
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

