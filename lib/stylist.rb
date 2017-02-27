require('pry')

class Stylist
  attr_reader(:id, :name, :station)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @station = attributes.fetch(:station)
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      id = stylist.fetch("id").to_i()
      name = stylist.fetch("name")
      station = stylist.fetch("station")
      stylists.push(Stylist.new({:id => id, :name => name, :station => station}))
    end
    stylists
  end

  define_method(:==) do |other|
    self.name.==(other.name).&(self.id.==(other.id))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name, station) VALUES ('#{@name}', #{@station}) RETURNING id;")
    @id = result.first['id'].to_i()
  end

  define_singleton_method(:find_by_name) do |name|
    returned_stylists = DB.exec("SELECT * FROM stylists WHERE name = '#{name}';")
    stylists = []
    returned_stylists.each do |stylist|
      id = stylist['id'].to_i
      name = stylist['name']
      station = stylist['station']
      stylists.push(Stylist.new({:id => id, :name => name, :station => station}))
    end
    stylists
  end

  define_singleton_method(:find_by_id) do |id|
    found_stylist = nil
    Stylist.all().each() do |stylist|
      if stylist.id().==(id)
        found_stylist = stylist
      end
    end
    found_stylist
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @station = attributes.fetch(:station, @station)
    @id = self.id()
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE stylists SET station = #{@station} WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id};")
  end
end
