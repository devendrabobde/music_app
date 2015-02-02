require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  context 'GET index' do

    context 'with category name in params' do
      subject { get :index, category: 'csat' }
      it { should be_success }
      it { expect(subject.status).to eq(200) }
      it { expect(JSON.parse(subject.body).class).to eq(Hash) }
      it { expect(JSON.parse(subject.body).keys).to eq(["categories", "books"]) }
    end

    context 'with no params' do
      subject { get :index }
      it { should be_success }
      it { expect(JSON.parse(subject.body).class).to eq(Hash) }
      it { expect(JSON.parse(subject.body).keys).to eq(["categories", "books"]) }
    end

    context 'should return 10 books per page for a category' do
      subject { get :index, category: 'csat', page: 1 }
      it { should be_success }
      it { expect(JSON.parse(subject.body).class).to eq(Hash) }
      it { expect(JSON.parse(subject.body).keys).to eq(["categories", "books"]) }
      it { expect(JSON.parse(subject.body)["books"].count).to eq(10) }
    end

  end
end