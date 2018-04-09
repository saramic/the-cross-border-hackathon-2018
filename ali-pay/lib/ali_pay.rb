class AliPay
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

  def pay
    PARAMS
      .sort
      .to_h
      .inject([]) {|ary, (k, v)| ary << "#{k}=#{v}" }
      .join('&')
  end
end

