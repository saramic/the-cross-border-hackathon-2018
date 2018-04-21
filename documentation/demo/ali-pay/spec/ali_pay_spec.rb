require 'spec_helper'
require 'ali_pay'
require 'timecop'

RSpec.describe AliPay do
  it 'just works' do
    Timecop.freeze(DateTime.iso8601("2000-12-31T00:00:00+0000")) do
      ENV['ALIPAY_MD5'] = 'XXXX'
      ali_pay           = AliPay.new(out_trade_no: 1234, sign_type: 'MD5')
      expect(ali_pay.pay_url).to eq('https://mapi.alipay.com/gateway.do?_input_charset=utf-8&body=iphone cellphone&currency=USD&extend_params={"secondary_merchant_name":"Lotte","secondary_merchant_id":"123","secondary_merchant_industry":"5812","store_id":"A101","store_name":"McDonald in 966 3rd Ave, New York"}&notify_url=http://商户网关地址/alipay.acquire.precreate-PHP-UTF-8-MD5/notify_url.php&out_trade_no=1234&partner=2088021966388155&passback_parameters=test&price=0.01&product_code=OVERSEAS_MBARCODE_PAY&quantity=1&seller_email=testoverseas1980@alipay.com&seller_id=2088021966388155&service=alipay.acquire.precreate&show_url=http://www.taobao.com/product/113714.html&subject=Payment by QR-Code&timestamp=2000-12-31 08:00:00&total_fee=0.01&trans_currency=USD&sign=6c478998267d747565aff1b8ab595380&sign_type=MD5')
    end
  end
end
