require 'rails_helper'

RSpec.describe "gifts/show", type: :view do
  before(:each) do
    @gift = assign(:gift, Gift.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
