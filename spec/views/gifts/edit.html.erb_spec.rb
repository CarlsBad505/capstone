require 'rails_helper'

RSpec.describe "gifts/edit", type: :view do
  before(:each) do
    @gift = assign(:gift, Gift.create!())
  end

  it "renders the edit gift form" do
    render

    assert_select "form[action=?][method=?]", gift_path(@gift), "post" do
    end
  end
end
