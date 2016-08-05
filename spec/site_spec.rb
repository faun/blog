require 'spec_helper'

RSpec.describe 'middleman site', type: :feature do
  it 'generates a complete website' do
    visit '/'
    expect(page).to have_content 'Sascha Faun Winter'
  end
end
