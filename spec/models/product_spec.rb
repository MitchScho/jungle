require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) {
    Category.create(name: "test")
  }
    subject{
      Product.new(name: "Test tree" , price: 2999, quantity: 1, category: category)
    }
    describe 'Validations' do 

        it 'should be valid if all values are given' do
          expect(subject).to be_valid 
        end

        it 'should be in valid if name is not present' do
          subject.name = nil
          expect(subject).to be_invalid 
          expect(subject.errors.full_messages[0]).to eq("Name can't be blank") 
        end

        it 'should be in valid if price is not present' do
          subject.price_cents = nil
          expect(subject).to be_invalid 
          expect(subject.errors.full_messages[0]).to eq("Price cents is not a number")
          expect(subject.errors.full_messages[1]).to eq("Price is not a number")
          expect(subject.errors.full_messages[2]).to eq("Price can't be blank")
          expect(subject.errors.full_messages[3]).to eq("Price cents can't be blank")
        end

        it 'should be in valid if quantity is not present' do
          subject.quantity = nil
          expect(subject).to be_invalid
          expect(subject.errors.full_messages[0]).to eq("Quantity can't be blank") 
        end

        it 'should be in valid if category is not present' do
          subject.category = nil
          expect(subject).to be_invalid
          expect(subject.errors.full_messages[0]).to eq("Category must exist") 
        end
    end
end


