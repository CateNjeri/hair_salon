require('spec_helper.rb')
require('capybara/rspec')
require('./app')
require('launchy')
Capybara.app = Sinatra::Application
# set(:show_exceptions, false)

describe 'the stylist path', {:type => :feature} do
  it "gets to the Manage Stylists page" do
    visit '/'
    click_link "stylists"
    expect(page).to have_content("Manage Your Stylists")
  end

  it "allows the user to add a stylist" do
    visit '/stylists'
    click_link 'Add a New Stylist'
    fill_in('name', :with => 'Juma Jackson')
    fill_in('station', :with => '2')
    click_button('Add Stylist')
    expect(page).to have_content("Juma Jackson")
  end

  it "allows the user to view info about a stylist" do
    visit '/stylists'
    click_link 'Add a New Stylist'
    fill_in('name', :with => 'Juma Jackson')
    fill_in('station', :with => '2')
    click_button('Add Stylist')
    click_link('Juma Jackson')
    expect(page).to have_content("Stylist Information")
  end

  it "allows the user to update a stylist" do
    stylist = Stylist.new({:id => nil, :name => 'Chris Damora',:station => '4'})
    stylist.save()
    visit '/stylists'
    click_link('Juma Jackson')
    click_link('Edit or Delete')
    fill_in('Station', :with => '12')
    click_button('Update')
    expect(page).to have_content('Manage Your Stylists')
  end

  it "allows the user to delete a stylist" do
    stylist = Stylist.new({:id => nil, :name => 'Juma Jackson',:station => '4'})
    stylist.save()
    visit '/stylists'
    click_link('Juma Jackson')
    click_link('Edit or Delete')
    click_button('Delete this stylist')
    expect(page).to have_no_content('Juma Jackson')
  end
end

describe 'the client path', {:type => :feature} do
  it "gets to the Manage Clients page" do
    visit '/'
    click_link 'clients'
    expect(page).to have_content('Manage Your Clients')
  end

  it "allows the user to add a client" do
    stylist = Stylist.new({:id => nil, :name => 'Juma Jackson',:station => '4'})
    stylist.save()
    visit '/clients'
    click_link 'Add a New Client'
    fill_in('name', :with => 'Awili Wawili')
    fill_in('phone', :with => '503-250-2173')
    fill_in('email', :with => 'awiliwawili@gmail.com')
    select('Juma Jackson', :from => 'stylist_id')
    click_button('Add Client')
    expect(page).to have_content('Awili Wawili')
  end

  it "allows the user to update a client's info" do
    stylist = Stylist.new({:id => nil, :name => 'Juma Jackson',:station => '4'})
    stylist.save()
    client = Client.new({:id => nil, :name => 'Awili Wawili',:phone => '503-250-2173', :email => 'awiliwawili@gmail.com', :stylist_id => stylist.id})
    client.save()
    visit '/clients'
    click_link('Awili Wawili')
    click_link('edit_delete')
    fill_in("name", :with => 'Miano Miami')
    click_button('Update')
    expect(page).to have_content('Miano Miami')
  end

  it "allows the user to assign a client to a stylist" do
    stylist = Stylist.new({:id => nil, :name => 'Juma Jackson',:station => '4'})
    client = Client.new({:id => nil, :name => 'Awili Wawili',:phone => '503-250-2173', :email => 'awiliwawili@gmail.com', :stylist_id => nil})
    client.save()
    stylist.save()
    visit '/clients'
    click_link('Awili Wawili')
    click_link('edit_delete')
    select('Juma Jackson', :from => 'stylist_id')
    click_button 'Update'
    expect(page).to have_content('Awili Wawili')
  end

  it "allows the user to delete a client" do
    client = Client.new({:id => nil, :name => 'Awili Wawili',:phone => '503-250-2173', :email => 'awiliwawili@gmail.com', :stylist_id => nil})
    client.save()
    visit '/clients'
    click_link('Awili Wawili')
    click_button('Delete Client')
    expect(page).to have_no_content('Awili Wawili')
  end
end
