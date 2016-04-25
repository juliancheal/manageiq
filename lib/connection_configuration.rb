require 'ostruct'
class ConnectionConfiguration
  attr_reader :options, :connections

  def initialize(options = {})
    @options = options
  end

  def self.configure(args)
    config = ConnectionConfiguration.new(args)
    config.configuration
  end

  def configuration
    # create a OpenStruct for each endpoint type
    config = create_struct(@options[:endpoint])
    config.authentication = create_struct(@options[:authentication])
    config
  end

  private

  def create_struct(hash)
    @table = {}
    @hash_table = {}
    if hash
      hash.each do |k, v|
        @table[k.to_sym] = (v.kind_of?(Hash) ? OpenStruct.new(v) : v)
      end
      OpenStruct.new(@table)
    end
  end
end
