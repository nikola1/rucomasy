require 'singleton'

class PersistanceManager
  include Singleton
  attr_reader :saved, :not_staved, :deleted, :not_deleted, :exists, :not_exists

  class DataObject
    attr_reader :object

    def initialize(object, persistance)
      @object = object
      @persistance = persistance
    end

    def save
      if @object.save
        puts @persistance.saved
        print
      else
        puts @persistance.not_saved
      end
    end

    def delete
      @persistance.delete @object.id
    end

    def print
      @persistance.print @object
    end

    def method_missing(name, *arg, &block)
      @object.send name, *arg, &block
    end
  end

  def fetch(id)
    if (object = @object_type.get id)
      DataObject.new object
    else
      nil
    end
  end

  def create(attributes)
    DataObject.new @object_type.new(attributes), self
  end

  def add(attributes)
    create(attributes).save
  end

  def select(attributes)
    @object_type.all(attributes).map { |contest| DataObject.new contest, self }
  end

  def delete(id)
    if @object_type.get(id).destroy
      puts deleted
    else
      puts not_deleted
    end
  end

  def delete_matching(all = false, attributes)
    objects = select attributes

    if objects.count == 0
      puts not_exists
    elsif objects.count == 1
      objects.first.delete
    else
      if all
        objects.each &:delete
      else
        objects.each &:print
        puts "Pick one? (by contest id)"
        delete STDIN.readline.to_i
      end
    end
  end

  def edit(attributes)
    object = fetch attributes[:id]

    if object
      attributes.each { |k, v| object.attribute_set k, v }
      if object.save
        puts saved
        print object
      else
        puts not_saved
      end
    else
      puts not_exists
    end
  end
end
