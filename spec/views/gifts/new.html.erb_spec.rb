require 'rails_helper'

RSpec.describe "gifts/new", type: :view do
  before(:each) do
    assign(:gift, Gift.new())
  end

  it "renders new gift form" do
    render

    assert_select "form[action=?][method=?]", gifts_path, "post" do
    end
  end
end
