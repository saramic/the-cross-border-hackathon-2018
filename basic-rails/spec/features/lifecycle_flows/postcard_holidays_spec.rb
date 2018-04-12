require 'rails_helper'

feature 'Lifecycle flow for a postcard holiday' do
  Steps 'A Chinese national goes on a holiday inspired by postcards from a friend' do

    When 'Li Jing(李静) receives a message from her friend Zhang Wei(张伟)' do
      visit root_path
      click_link 'new message'
    end

    Then "she sees 3 postcard images from Zhang Wei's recent holiday to Australia" do
      wait_for { page }.to have_content('postcard 1')
      wait_for { page }.to have_content('postcard 2')
      wait_for { page }.to have_content('postcard 3')
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

