require 'spec_helper'

describe ApiAi do
  it 'has a version number' do
    expect(ApiAi::VERSION).not_to be nil
  end

  it 'has web server domain' do
    expect(ApiAi::WEB_SERVER).to eq('api.ai')
  end

  it 'has api uri' do
    expect(ApiAi::API_SERVER).to eq('api.api.ai/v1')
  end

  describe '::clean_params' do
    let(:params){ {"test_1"=>"test", "test_2" => nil} }
    it 'removes nil params' do
      expect(ApiAi::clean_params(params)).to eq({"test_1"=>"test"})
    end
  end

  describe '::make_query_string' do
    let(:params){ {"test_1"=>"test", "test_2"=>"test"} }
    it 'transform params to query string' do
      expect(ApiAi::make_query_string(params)).to eq("test_1=test&test_2=test")
    end
  end

end
