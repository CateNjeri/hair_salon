require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/client')
require('./lib/stylist')
require('pg')
require('pry')

DB = PG.connect({:dbname => "hair_salon"})

get('/') do
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/new') do
  erb(:stylist_form)
end

post('/stylists') do
  name = params['name']
  station = params['station']
  @stylist = Stylist.new({:id => nil, :name => name, :station => station})
  @stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/:id') do
  @stylist = Stylist.find_by_id(params.fetch('id').to_i())
  stylist_id = @stylist.id()
  @clients = Client.find_by_stylist_id(stylist_id)
  erb(:stylist)
end

get('/stylists/:id/edit') do
  @stylist = Stylist.find_by_id(params.fetch('id').to_i())
  erb(:stylist_edit)
end

patch('/stylists/:id') do
  @stylist = Stylist.find_by_id(params.fetch('id').to_i())
  name = params.fetch('name')
  if name.==('')
    name = @stylist.name()
  end
  station = params.fetch('station')
  if station.==('')
    station = @stylist.station()
  end
  @stylist.update({:name => name, :station => station})
  @stylists = Stylist.all()
  erb(:stylists)
end

delete ('/stylists/:id') do
  @stylist = Stylist.find_by_id(params['id'].to_i())
  @stylist.delete()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/clients') do
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:clients)
end

get('/clients/new') do
  @stylists = Stylist.all()
  erb(:client_form)
end

post('/clients') do
  name = params.fetch('name')
  phone = params.fetch('phone')
  email = params.fetch('email')
  stylist_id = params['stylist_id'].to_i()
  @client = Client.new({:id => nil, :name => name, :phone => phone, :email => email})
  @client.save()
  @client.assign(stylist_id)
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:clients)
end

get('/clients/:id') do
  @client = Client.find_by_id(params.fetch('id').to_i())
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:client)
end

get('/clients/:id/edit') do
  @stylists = Stylist.all()
  @clients = Client.all()
  @client = Client.find_by_id(params.fetch('id').to_i())
  erb(:client_edit)
end

patch('/clients/:id/update') do
  @client = Client.find_by_id(params.fetch('id').to_i())
  name = params.fetch('name')
  if name.==('')
    name = @client.name()
  end
  phone = params.fetch('phone')
  if phone.==('')
    phone = @client.phone()
  end
  email = params.fetch('email')
  if email.==('')
    email = @client.email()
  end
  stylist_id = params['stylist_id'].to_i()
  if stylist_id.==('')
    stylist_id = @client.stylist_id()
  end
  @client.update({:name => name, :phone => phone, :email => email, :stylist_id => stylist_id})
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:clients)
end

get('/clients/:id/assign') do
  @stylists = Stylist.all()
  @clients = Client.all()
  @client = Client.find_by_id(params.fetch('id').to_i())
  erb(:client_assign)
end

post ('/clients/:id/assign') do
  @client = Client.find_by_id(params['id'].to_i())
  stylist_id = params.fetch('stylist_id').to_i()
  @client.assign(stylist_id)
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:clients)
end

delete ('/clients/:id/delete') do
  @client = Client.find_by_id(params['id'].to_i())
  @client.delete()
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:clients)
end
