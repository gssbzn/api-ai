require 'spec_helper'

describe ApiAi::Client do
  it 'Initialize' do
    client = ApiAi::Client.new("", "")
    expect(client).not_to be nil
  end
  it 'Validates token is string' do
    expect{ApiAi::Client.new(1, "")}.to raise_error(ArgumentError)
    expect{ApiAi::Client.new("", 1)}.to raise_error(ArgumentError)
    expect{ApiAi::Client.new(1, 1)}.to raise_error(ArgumentError)
  end

end
