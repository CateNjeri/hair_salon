require('spec_helper')

describe(Stylist) do

describe('#name') do
    it "returns the name of the stylist" do
      test_stylist = Stylist.new({:id => nil, :name => 'Mary Marry',:station => '4'})
      expect(test_stylist.name()).to(eq('Mary Marry'))
    end
  end

  describe('#id') do
    it "returns the id of the stylist" do
      test_stylist = Stylist.new({:id => nil, :name => 'Mary Marry',:station => '4'})
      test_stylist.save()
      expect(test_stylist.id().class()).to(eq(Fixnum))
    end
  end

  describe('.all') do
    it 'is an array of stylists that is empty at first' do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('#==') do
      it 'compares two stylists by name and id to see if they are the same' do
        test_stylist = Stylist.new({:id => nil, :name => 'Mary Marry',:station => '4'})
        test_stylist2 = Stylist.new({:id => nil, :name => 'Mary Marry',:station => '4'})
        test_stylist.eql?(test_stylist2)
      end
    end

  describe('#save') do
    it 'saves a stylist' do
      test_stylist = Stylist.new({:id => nil, :name => 'Mary Marry',:station => '4'})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe('.find_by_name') do
    it 'locates stylists with a given name' do
      test_stylist = Stylist.new({:id => nil, :name => 'Mary Marry',:station => '4'})
      test_stylist2 = Stylist.new({:id => nil, :name => 'Sun Sanchez',:station => '5'})
      test_stylist.save()
      test_stylist2.save()
      expect(Stylist.find_by_name(test_stylist.name())).to(eq([test_stylist]))
    end
  end

  describe('.find_by_id') do
    it 'locates a stylist with a given id' do
      test_stylist = Stylist.new({:id => nil, :name => 'Mary Marry',:station => '4'})
      test_stylist2 = Stylist.new({:id => nil, :name => 'Sun Sanchez',:station => '5'})
      test_stylist.save()
      test_stylist2.save()
      expect(Stylist.find_by_id(test_stylist.id())).to(eq(test_stylist))
    end
  end

  describe('#update') do
    it 'lets the user update some of the attributes of the stylist' do
      test_stylist = Stylist.new({:id => nil, :name => 'Mary Marry',:station => '4'})
      test_stylist.save()
      test_stylist.update({:station => '2'})
      expect(test_stylist.station()).to(eq('2'))
      expect(test_stylist.name()).to(eq('Mary Marry'))
    end
  end

  describe('#delete') do
    it 'lets the user delete a stylist' do
      test_stylist = Stylist.new({:id => nil, :name => 'Mary Marry',:station => '4'})
      test_stylist2 = Stylist.new({:id => nil, :name => 'Sun Sanchez',:station => '5'})
      test_stylist.save()
      test_stylist2.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([test_stylist2]))
    end
  end
end
