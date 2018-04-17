require 'rails_helper'

feature 'Lifecycle flow for a postcard holiday' do
  Steps 'A Chinese national goes on a holiday inspired by postcards from a friend' do
    Given 'a postcard holiday site exists' do
      visit root_path
      wait_for { page }.to have_content('Welcome to Postcard Holidays')
    end

    When 'Alan Tsen is wanting to know about our idea' do
      click_link "let's get started"
    end

    Then 'we have a comprehensive message about the dev team' do
      wait_for { page }.to have_content('Development Team')
      wait_for { page }.to have_content('Jake Barber')
      wait_for { page }.to have_content('Tianqi Chen')
      wait_for { page }.to have_content('Gary Manche')
      wait_for { page }.to have_content('Michael Milewski')
      wait_for { page }.to have_content('Selena Small')
    end

    And 'what we have managed to build' do
      wait_for { page }.to have_content('The build')
      wait_for { page }.to have_content('Payment transfer system')
    end

    And 'which of the many useful partner resources we have used' do
      wait_for { page }.to have_content('Partners')
      wait_for { page }.to have_content('NAB')
      wait_for { page }.to have_content('Alipay')
      wait_for { page }.to have_content('Ali cloud')
    end

    When 'Alan Tsen continues to find out about our value proposition' do
      click_link "The value proposition"
    end

    Then """there is a compelling story of Australian natural opportunities,
            tourist operators who provide unsurpassed service,
            Chinese inquisitivness spreading globally,
            and modern economy partners who reduce spend and waste""" do
      wait_for { page }.to have_content('Austrlia')
      wait_for { page }.to have_content('China')
      wait_for { page }.to have_content('Tourism Operators')
      wait_for { page }.to have_content('Modern Economy Partners')
    end

    When 'Alan Tsen asks how it all works' do
      click_link "Show me a demo"
    end

    Then 'a convincing "soci net" engagment takes place about Zhang Wei(张伟) trip to Australia and his friend li jing(李静)' do
      wait_for { page }.to have_content('Yeah, great, Australia is unbelievable')
      wait_for { page }.to have_content('go on such a postcard holiday as well')
    end

    When "li jing(李静) want's to find out what will happen next" do
      click_link 'What happens next?'
    end

    When 'Li Jing submits these postcard images to postcard holiday' do
      click_link 'find me a postcard holiday'
    end

    Then 'she is presented with numerous options that match the postcards presented' do
      wait_for { page }.to have_content('option 1')
      wait_for { page }.to have_content('option 2')
      wait_for { page }.to have_content('option 3')
    end

    When 'Li Jing selects option 2' do
      click_link 'option 2'
    end

    Then 'she is presented with an Alipay QR code' do
      wait_for { page }.to have_content('option 2 QR code')
    end

    When 'Li Jing scans the QR code' do
      click_link 'scan QR code'
    end

    Then 'the holiday is booked and a detailed itinerary is presneted' do
      wait_for { page }.to have_content('option 2 booked')
    end

    And 'there is an exchange rate from NAB presented' do
      wait_for { page }.to have_content('AUD to CNY exchange rate')
    end

    And 'there is an aditional Alipay QR code to put money into an NAB account available on arrival' do
      wait_for { page }.to have_content('QR code to create an NAB account in Australia')
    end

    And 'a map is shown including NAB ATMs around her places of interest' do
      wait_for { page }.to have_content('Map with NAB ATMs near places of interest')
    end

    When 'finally Li Jing takes her holiday she has 3 great postcard photos which she share with her friend Wang Li (王丽)' do
      # and it all happens again
    end
  end
end

