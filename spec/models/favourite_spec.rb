require 'rails_helper'

RSpec.describe Favourite, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:provider_id) }
  it { should belong_to(:user) }
end
