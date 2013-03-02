require 'spec_helper'

describe 'Rber' do

  it 'should load the index' do
    get '/'
    last_response.should.be.ok
  end
end
