require 'spec_helper'

describe 'Listings' do

  it 'be able to create new listing' do
    visit '/'
    fill_in(I18n.t('activerecord.attributes.listing.current_occupation'), :with => 'Java Developer')
    fill_in(I18n.t('activerecord.attributes.listing.current_salary'), :with => '1800')
    fill_in(I18n.t('activerecord.attributes.listing.city'), :with => 'Kiev')
    fill_in(I18n.t('activerecord.attributes.listing.future_occupation'), :with => 'Ruby')
    fill_in(I18n.t('activerecord.attributes.listing.future_salary'), :with => '2100')
    fill_in('Email', :with => 'neveragny@gmail.com')
    click_on(I18n.t('helpers.submit.listing.create'))
    page.should have_content(I18n.t('listings.created'))
  end

  describe 'Password set feature' do  #, :js => true
    it 'should be prompted to set password' do
      email = 'neveragny@gmail.com'
      visit '/'
      fill_in(I18n.t('activerecord.attributes.listing.current_occupation'), :with => 'Java Developer')
      fill_in(I18n.t('activerecord.attributes.listing.current_salary'), :with => '1800')
      fill_in(I18n.t('activerecord.attributes.listing.city'), :with => 'Kiev')
      fill_in(I18n.t('activerecord.attributes.listing.future_occupation'), :with => 'Ruby')
      fill_in(I18n.t('activerecord.attributes.listing.future_salary'), :with => '2100')
      fill_in('Email', :with => email)
      click_on(I18n.t('helpers.submit.listing.create'))
      page.should have_content(I18n.t('common.set_password'))
      within("div.password_password") do
        fill_in(I18n.t("simple_form.labels.password.password"), :with => 'kokokoko')
      end
      within("div.password_password_confirmation") do
        fill_in(I18n.t("simple_form.labels.password.password_confirmation"), :with => 'kokokoko')
      end
      click_on(I18n.t('common.save_changes'))
      page.should_not have_content(I18n.t('common.set_password'))
      page.should have_content(email)

    end
  end


end