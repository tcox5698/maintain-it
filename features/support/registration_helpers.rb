module RegistrationHelper
  def enter_registration_info(user_name, password)
    page.fill_in 'user[email]', :with => user_name
    page.fill_in 'Password', :with => password
    page.fill_in 'Password confirmation', :with => password
    page.click_on 'Sign up'
  end

  def click_email_confirmation_link
    email = ActionMailer::Base.deliveries.last
    page = Nokogiri::HTML(email.body.to_s)
    confirm_link = page.xpath('//a').first['href']

    visit confirm_link
  end

  def log_in(user_name, password)
    fill_in 'Email', with: user_name
    fill_in 'Password', with: password
    click_button 'Log in'
  end

  def register_and_login(user_name)
    visit '/'
    click_link('Sign Up!', match: :first)
    enter_registration_info(user_name, 'Password7!')
    click_email_confirmation_link
    log_in(user_name, 'Password7!')
  end

  def logout
    click_link 'Logout'
    expect(page).to have_content('Signed out successfully.')
  end
end

World(RegistrationHelper)