require 'spec_helper'
require 'ali_pay'
RSpec.describe AliPay do
  it 're-arranges parameters alphabetically' do
    expect(AliPay.new.pay).to eq '_input_charset=gbk&out_trade_no=6741334835157966&partner=2088101568338364&payment_type=1&return_url=http://www.test.com/alipay/return_url.asp&seller_email=alipay-test01@alipay.com&service=create_forex_trade&subject=test&total_fee=100'
  end

  it 'creates the api url' do
    expected_api_url = <<-EOF.gsub(/^\s+/, '').gsub(/\s+$/, '').gsub(/\R+/, '')
      https://intlmapi.alipay.com/gateway.do?
        _input_charset=UTF-8&
        body=iphone cellphone&
        currency=USD&
        extend_params={
          "secondary_merchant_name":"Lotte",
          "secondary_merchant_id":"123",
          "secondary_merchant_industry":"5812",
          "store_id":"A101",
          "store_name":"McDonald in 966 3rd Ave, New York"
       }&
       notify_url=http://api.test.alipay.net/atinterface/receive_notify.htm&
       out_trade_no=4363476566647440&
       partner=2088021966388155&
       passback_parameters=test&
       price=0.01&
       product_code=OVERSEAS_MBARCODE_PAY&
       quantity=1&
       seller_email= testoverseas1980@alipay.com&
       seller_id=2088021966388155&
       sendFormat=normal&
       service=alipay.acquire.precreate&
       show_url=http://www.taobao.com/product/113714.html&
       subject=Payment by QR-Code&
       total_fee=0.01&
       trans_currency=USD&
       sign=18420f53772727a55457dd9e6f72cd00
    EOF
       # sign=2127020ad640f41eec725c639f1de294

    ali_pay = AliPay.new(
      :_input_charset => "UTF-8",
      :extend_params  => {
        "secondary_merchant_name"     => "Lotte",
        "secondary_merchant_id"       => "123",
        "secondary_merchant_industry" => "5812",
        "store_id"                    => "A101",
        "store_name"                  => "McDonald in 966 3rd Ave, New York"
      },
      :notify_url     => "http://api.test.alipay.net/atinterface/receive_notify.htm",
      :price          => "0.01",
      :quantity       => "1",
      :show_url       => "http:\/\/www.taobao.com\/product\/113714.html",
      :trans_currency => "USD",
      :out_trade_no   => "4363476566647440",
      :seller_email   => " testoverseas1980@alipay.com",
      :sendFormat     => "normal"
    )
    expect(ali_pay.pay_url).to eq expected_api_url
  end

  it 'sign a message' do
    ali_pay = AliPay.new(
      :_input_charset => "utf-8",
      :extend_params  => {
        "secondary_merchant_name"     => "Lotte",
        "secondary_merchant_id"       => "123",
        "secondary_merchant_industry" => "5812",
        "store_id"                    => "A101",
        "store_name"                  => "McDonald in 966 3rd Ave, New York"
      },
      :notify_url     => "http:\/\/\u5546\u6237\u7f51\u5173\u5730\u5740\/alipay.acquire.precreate-PHP-UTF-8-MD5\/notify_url.php",
      :price          => "0.01",
      :quantity       => "1",
      :show_url       => "http:\/\/www.taobao.com\/product\/113714.html",
      :timestamp      => "2018-04-09 10:43:38",
      :trans_currency => "USD",
      :seller_email   => "testoverseas1980@alipay.com"
    )
    expect(ali_pay.md5_sign).to eq 'f1f75100c82dcfc40aa0c86477ba11a1'
  end
end
