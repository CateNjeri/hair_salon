require('spec_helper')

describe(Client) do

describe('#name') do
    it "returns the name of the client" do
      test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
      expect(test_client.name()).to(eq('Patsy Cline'))
    end
  end

  describe('#id') do
    it "returns the id of the client" do
      test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
      test_client.save()
      expect(test_client.id().class()).to(eq(Fixnum))
    end
  end

  describe('.all') do
    it 'is an array of clients that is empty at first' do
      expect(Client.all()).to(eq([]))
    end
  end

  describe('#==') do
      it 'compares two clients by name and id to see if they are the same' do
        test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
        test_client2 = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
        test_client.eql?(test_client2)
      end
    end

  describe('#save') do
    it 'saves a client' do
      test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end

  describe('.find_by_name') do
    it 'locates clients with a given name' do
      test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
      test_client2 = Client.new({:id => nil, :name => 'Awili Wawili',:phone => '971-554-4455', :email => 'awiliwawili@gmail.com', :stylist_id => nil})
      test_client.save()
      test_client2.save()
      expect(Client.find_by_name(test_client.name())).to(eq([test_client]))
    end
  end

  describe('.find_by_id') do
    it 'locates clients with a given id' do
      test_client = Client.new({:id => 3, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
      test_client2 = Client.new({:id => 4, :name => 'Awili Wawili',:phone => '971-554-4455', :email => 'awiliwawili@gmail.com', :stylist_id => nil})
      test_client.save()
      test_client2.save()
      expect(Client.find_by_id(test_client.id)).to(eq(test_client))
    end
  end

  describe('.find_by_stylist_id') do
    it 'locates clients with a given stylist_id' do
      test_stylist = Stylist.new({:id => nil, :name => 'Juma Jackson',:station => '4'})
      test_stylist.save()
      test_stylist2 = Stylist.new({:id => nil, :name => 'Max Wells',:station => '3'})
      test_stylist2.save()
      test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => test_stylist.id()})
      test_client.save()
      test_client.assign(test_stylist.id)
      test_client2 = Client.new({:id => nil, :name => 'Awili Wawili',:phone => '971-554-4455', :email => 'awiliwawili@gmail.com', :stylist_id => test_stylist2.id()})
      test_client2.save()
      test_client2.assign(test_stylist2.id)
      expect(Client.find_by_stylist_id(test_stylist.id())).to(eq([test_client]))
    end
  end

  describe('#update') do
    it 'lets the user update some of the attributes of the client' do
      test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => 3})
      test_client.save()
      test_client.update({:email => 'patsycline@yahoo.com'})
      expect(test_client.email()).to(eq('patsycline@yahoo.com'))
      expect(test_client.name()).to(eq('Patsy Cline'))
    end
  end

  describe('#delete') do
    it 'lets the user delete a client' do
      test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
      test_client2 = Client.new({:id => nil, :name => 'Awili Wawili',:phone => '971-554-4455', :email => 'awiliwawili@gmail.com', :stylist_id => nil})
      test_client.save()
      test_client2.save()
      test_client.delete()
      expect(Client.all()).to(eq([test_client2]))
    end
  end

  describe('#assign') do
    it 'lets the user assign the client to a stylist' do
      test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
      test_client.save()
      test_client.assign(4)
      expect(test_client.stylist_id()).to(eq(4))
    end
  end
end
