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

      request_body_example value: { email: FFaker::Internet.email, password: FFaker::Internet.password }, name: "sign_up_example", summary: "Sign Up example request"

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

  path '/users/tokens/sign_in' do
    let(:new_user) { create(:user) }
    post 'Sign in with email and password' do
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

      request_body_example value: { email: FFaker::Internet.email, password: FFaker::Internet.password }, name: "sign_in_example", summary: "Sign In example request"

      response '200', 'user signed in successfully' do
        
        before do
          user[:email] = new_user.email
          user[:password] = new_user.password
        end

        run_test!
      end

      response '400', 'Email is invalid' do
        before do
          user[:email] = "foo"
          user[:password] = new_user.password
        end

        run_test!
      end

      response '401', 'Unauthorized' do
        context 'invalid email or password' do
          before do
            user[:email] = new_user.email
            user[:password] = "foo"
          end

          run_test!
        end
      end
    end
  end

  path '/users/tokens/info' do
    before do
      post '/users/tokens/sign_up', :params => { email:FFaker::Internet.email, password:FFaker::Internet.password }
      @token = JSON.parse(response.body)["token"]
    end

    get 'Get info with bearer token' do
      tags 'Users Tokens'
      consumes 'application/json'
      security [bearer_auth: []]

      parameter name: :Authorization, in: :header, type: :string, required: true,
                description: 'Bearer Token'
      
      response '200', 'retrieves user info' do
        let(:Authorization) { @token }
        run_test!
      end

      response '401', 'Revoked token' do
        before do
          post '/users/tokens/revoke', :headers => { 'Authorization' => "Bearer #{@token}" }
        end

        let(:Authorization) { @token }
        run_test!
      end
    end
  end
end

