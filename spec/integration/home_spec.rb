require 'spec_helper'

describe 'home page' do
  it 'should find form' do
    visit '/'
    page.should have_content(I18n.t("activerecord.attributes.listing.current_occupation"))
  end
end