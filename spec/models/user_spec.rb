require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should be valid if name, email and a password are present and password confirmation match' do
      user = User.new( name: "John", email: "test@test.com", password: "1234", password_confirmation: "1234")
      expect(user).to be_valid 
    end

    it 'should not be valid if name is not present' do
      user = User.new( {name: nil, email: "test@test.com", password: "1234", password_confirmation: "1234"})
      user.save
      expect(user).to_not be_valid 
      
      # puts user.errors.full_messages
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not be valid if email is not present' do
      user = User.new( name: "John", email: nil, password: "1234", password_confirmation: "1234")
      user.save
      expect(user).to_not be_valid 
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not be valid if password is not present' do
      user = User.new( name: "John", email: "test@test.com", password: nil, password_confirmation: "1234")
      user.save
      expect(user).to_not be_valid 
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not be valid if password confirmation is not present' do
      user = User.new( name: "John", email: "test@test.com", password: "1234", password_confirmation: nil)
      user.save
      expect(user).to_not be_valid 
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
     end

    it 'should not be valid when a password and password confirmation does not match' do
      user = User.new( name: "John", email: "test@test.com", password: "1234", password_confirmation: "4321")
      expect(user).to_not be_valid 
      expect(user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end        
    
    it 'should have a password with a minimum length of 4' do
      user = User.new(name: "John", email: "test@test.com", password: "12", password_confirmation: "12")
      expect(user).to_not be_valid   
      expect(user.errors.full_messages[0]).to eq("Password is too short (minimum is 4 characters)")
    end
    
    it 'email should be unique' do
      user = User.new(name: "John", email: "test@test.com", password: "1234", password_confirmation: "1234")
      user.save
      userTwo = User.new(name: "Doe", email: "test@test.com", password: "4321", password_confirmation: "4321")
      expect(userTwo).to_not be_valid
      expect(userTwo.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not be valid if new user email is the same as existing in db but in different case' do
      user = User.new( name: "John", email: "test@test.com", password: "1234", password_confirmation: "1234")
      user.save
      userTwo = User.new( name: "John", email: "TesT@TesT.com", password: "1234", password_confirmation: "1234")
      expect(userTwo).to_not be_valid 
      expect(userTwo.errors.full_messages).to include "Email has already been taken"
    end 
  end

  describe '.authenticate_with_credentials' do

    it 'should be valid if all credentials are correct' do
      user = User.new( name: "John", email: "test@test.com", password: "1234", password_confirmation: "1234")
      user.save
      auth_user = user.authenticate_with_credentials("test@test.com", "1234")
      expect(user.email).to eq(auth_user.email) 
      
    end
    
    it 'should be created if email that has white space either side' do
      user = User.new( name: "John", email: "test@test.com", password: "1234", password_confirmation: "1234")
      user.save
      auth_user = user.authenticate_with_credentials(" test@test.com ", "1234")
      expect(user.email).to eq(auth_user.email) 
      
    end

    it 'should fail authentication if email is incorrect' do
      user = User.new( name: "John", email: "test@test.com", password: "1234", password_confirmation: "1234")
      user.save
      auth_user = user.authenticate_with_credentials(" Boom@Box.com ", "1234")
      expect(auth_user).to be_nil 
      
    end

    it 'should fail authentication if password is incorrect' do
      user = User.new( name: "John", email: "test@test.com", password: "1234", password_confirmation: "1234")
      user.save
      auth_user = user.authenticate_with_credentials("test@test.com", "4321")
      expect(auth_user).to be_nil 
    end

    it 'should allow email of any case' do
      user = User.new( name: "John", email: "test@test.com", password: "1234", password_confirmation: "1234")
      user.save
      userTwo = User.new( name: "John", email: "TesT@TesT.com", password: "1234", password_confirmation: "1234")
      expect(user).to be_valid 
    end
  end

end
