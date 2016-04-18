class ManageIQ::Providers::SoftLayer::CloudManager::Vm < ManageIQ::Providers::CloudManager::Vm
  include_concern 'Operations'

  def provider_object(connection = nil)
    connection ||= ext_management_system.connect
    connection.servers.get(name, availability_zone.name)
  end

  #
  # Relationship methods
  #

  def disconnect_inv
    super

    # Mark all instances no longer found as unknown
    self.raw_power_state = "unknown"
    save
  end

  def disconnected
    false
  end

  def disconnected?
    false
  end

  def self.calculate_power_state(raw_power_state)
    case raw_power_state.downcase
    when /on/, /starting/
      "on"
    when /halted/, /stopping/
      "off"
    else
      "unknown"
    end
  end

  def validate_smartstate_analysis
    validate_unsupported("Smartstate Analysis")
  end
end
