require 'rails_helper'

RSpec.describe Api::V1::VersionsController, type: :controller do
  context 'GET check_version' do

    context 'check status of application' do
      subject { get :index }
      it { should be_success }
      it { expect(subject.status).to eq(200) }
      it { expect(JSON.parse(subject.body).class).to eq(Hash) }
      it { expect(JSON.parse(subject.body)["status"]).to eq("ok") }
      it { expect(JSON.parse(subject.body)["server_instance_name"]).to eq("test") }
    end

  end
end