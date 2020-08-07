require 'rails_helper'

RSpec.describe User, type: :model do
  describe ".digest" do
    let(:test_password) { "test_password" }
    context "when min_cost" do
      before do
        ActiveModel::SecurePassword.min_cost = true
      end
      subject { BCrypt::Password.new(User.digest(test_password)).is_password?(test_password)  }
      it "create digest with min_cost" do
        is_expected.to eq true
      end
    end
    context "when not min_cost" do
      subject { BCrypt::Password.new(User.digest(test_password)).is_password?(test_password)  }
      it "create digest without min_cost" do
        is_expected.to eq true
      end
    end
  end
  describe "#renew_remember_token" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:old_remember_digest) { user.remember_digest }
    before do
      user.renew_remember_token
    end
    subject { user.remember_digest }
    it "renew remember_digest" do
      is_expected.not_to eq old_remember_digest
    end
  end
  describe "#delete_remember_token" do
    let!(:user) { FactoryBot.create(:user) }
    before do
      user.delete_remember_token
    end
    subject { user.remember_digest }
    it "delete remember_digest" do
      is_expected.to eq nil
    end
  end
  describe "#has_authenticated_token?" do
    let(:user) { FactoryBot.create(:user) }
    context "when passes valid token" do
      subject { user.has_authenticated_token?("test_token") }
      it "authenticate token" do
        is_expected.to eq true
      end
    end
    context "when passes invalid token" do
      subject { user.has_authenticated_token?("dummy_token") }
      it "doesn't authenticate token" do
        is_expected.to eq false
      end
    end
    context "when passes nil" do
      subject { user.has_authenticated_token?(nil) }
      it "doesn't authenticate token" do
        is_expected.to eq false
      end
    end
  end
end
