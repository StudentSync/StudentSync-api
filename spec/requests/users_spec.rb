require 'swagger_helper'

RSpec.describe 'User Tokens API', type: :request do
  let(:user) { { email: FFaker::Internet.email, password: FFaker::Internet.password } }

  path '/users/tokens/sign_up' do
    post 'Sign up with email and password' do
      tags 'Users Tokens'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

      response '201', 'user signed up successfully' do
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:user_existing_email) { create(:user, email: FFaker::Internet.email) }

        context 'email has already been taken' do
          before { user[:email] = user_existing_email.email }
          run_test!
        end

        context 'password is too short' do
          before { user[:password] = FFaker::Lorem.characters(5) }
          run_test!
        end

        context "password can't be blank" do
          before { user[:password] = "" }
          run_test!
        end

        context "email is invalid" do
          before { user[:email] = FFaker::Lorem.characters(10) }
          run_test!
        end

        context "email can't be blank" do
          before { user[:email] = "" }
          run_test!
        end
      end
    end
  end
end
