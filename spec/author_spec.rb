require_relative '../classes/label'  # Assuming your Label class is in a file named 'label.rb'

RSpec.describe Label do
  describe '#add_item' do
    it 'adds an item to the label' do
      label_title = 'hello'
      label_color = 'red'

      label = Label.new(label_title, label_color)
      item = double('item')  # Creating a double for the item (you can replace this with your actual Item class instance)

      expect(item).to receive(:label=).with(label)  # Expecting the item's label setter to be called with the label object
      expect(label.items).to be_empty  # Initially, the label's items array should be empty

      label.add_item(item)

      expect(label.items).to include(item)  # The item should now be in the label's items array
    end
  end
end
