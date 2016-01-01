require 'rails_helper'

RSpec.describe "gifts/index", type: :view do
  before(:each) do
    assign(:gifts, [
      Gift.create!(),
      Gift.create!()
    ])
  end

  it "renders a list of gifts" do
    render
  end
end
