require_relative '../classes/label'

RSpec.describe Label do
  describe '#add_item' do
    it 'adds an item to the label' do
      label_title = 'hello'
      label_color = 'red'

      label = Label.new(label_title, label_color)
      item = double('item')
      expect(item).to receive(:label=).with(label)
      expect(label.items).to be_empty

      label.add_item(item)

      expect(label.items).to include(item)
    end
  end
end
