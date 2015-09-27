require 'spec_helper'

describe ApiAi do
  it 'has a version number' do
    expect(ApiAi::VERSION).not_to be nil
  end
  it 'has web server domain' do
    expect(ApiAi::WEB_SERVER).to eq('api.ai')
  end
  it 'has api uri' do
    expect(ApiAi::API_SERVER).to eq('api.api.ai')
  end
end
