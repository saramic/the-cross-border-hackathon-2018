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
       sign=2127020ad640f41eec725c639f1de294
    EOF

    expect(AliPay.new.pay_url).to eq expected_api_url
  end
end
