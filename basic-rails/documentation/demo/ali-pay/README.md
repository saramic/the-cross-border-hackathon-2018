# Ali Pay in ruby

going from sctatch.

starting on digital signature from
  https://global.alipay.com/service/transaction_QR_Code/29

# using Alipay gem

so apparently MD5 is legacy?
https://github.com/chloerei/alipay/blob/master/doc/legacy_api.md
but not according to the sandbox documentation
  via [Sandbox Handbook](https://isandbox.alipaydev.com/user/intlAccountDetails.htm?redirect_from=isandbox-2-1-1.daily.alipaydev.com%40GZ00a57UVoBB03JXXrI4lbtUStuxw2sandboxGZ00&app_id=2016071201605841&source=alipay_wallet&scope=auth_base&auth_code=15134108bbfd4a1ba2af145cf475VX67)
  https://os.alipayobjects.com/rmsportal/qzepRfDMREmzZQHMwXai.pdf

instead using RSA `alipay.trade.precreate` for QR code
https://github.com/chloerei/alipay/blob/master/doc/quick_start_en.md#qr-code

this is part of https://docs.open.alipay.com/api_1/alipay.trade.precreate
which has an app_id

    ```
    bundle exec ruby bin/ali_pay_gem_demo.rb  
    {
      "alipay_trade_precreate_response": {
        "code": "40002",
        "msg": "Invalid Arguments",
        "sub_code": "isv.invalid-app-id",
        "sub_msg": "??Ч??AppID????"
      }
    }
    ```

or should it be `alipay.aquire.precreate`
https://global.alipay.com/service/transaction_QR_Code/13

which has an partner id

may need to rewrite parts of https://github.com/chloerei/alipay

# using Alipay democode

via https://global.alipay.com/service/transaction_QR_Code/31?_rd=0.8448757037906678#DemoDownload

and running docker as

    ```
    docker run --rm -p 8000:80 -v $(pwd):/var/www/html php:apache
    ```

    from https://www.shiphp.com/blog/2017/php-web-app-in-docker

debugging with echo

    ```
    echo json_encode($response_to_print)
    ```

