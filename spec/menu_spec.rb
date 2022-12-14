# frozen_string_literal: true

require_relative '../lib/menu'

RSpec.describe SpecRefLib::Menu do
  let(:dummy_json) do
    {
      'categories' => [
        {
          'name' => 'Matchers',
          'example' => 'example',
          'keywords' => ['keyword']
        },
        {
          'name' => 'subject',
          'example' => 'example2',
          'keywords' => ['keyword2']
        }
      ]
    }
  end
  let(:menu) { described_class }
  let(:filepath) { instance_double(SpecRefLib::HandleFile, fetch_json: { 'categories' => [ { 'name' => 'Tom' } ]}) }

  before do
    allow(SpecRefLib::Helpers).to receive(:log).and_return('log')
    allow(SpecRefLib::Helpers).to receive(:leave).and_return('exit')
    allow(SpecRefLib::Helpers).to receive(:clear).and_return('clear')
    allow(SpecRefLib::Helpers).to receive(:ret_value).and_return('gets')
  end

  context '.new' do
    before(:each) do
      allow_any_instance_of(menu).to receive(:show_menu).and_return('show_menu')
      allow_any_instance_of(menu).to receive(:get_input).and_return(true)
    end

    it 'initalizes correctly' do
      expect { menu.new(filepath) }.not_to raise_error
    end
  end

  context '.show_menu' do
    before(:each) do
      allow_any_instance_of(menu).to receive(:get_input).and_return(true)
    end

    it 'creates menu' do
      m = menu.new(filepath)
      expect { m.show_menu }.not_to raise_error
    end
  end

  context '.show_sub_menu' do
    let(:arr) { [{ 'name' => 'test' }, { 'name' => 'test2' }] }
    before(:each) do
      allow_any_instance_of(menu).to receive(:show_menu).and_return('show_menu')
      allow_any_instance_of(menu).to receive(:get_input).and_return(true)
    end

    it 'creates a sub menu' do
      m = menu.new(filepath)
      expect { m.show_sub_menu(arr, 'sub_menu') }.not_to raise_error
    end
  end

  context '.show_example' do
    before(:each) do
      allow_any_instance_of(menu).to receive(:show_menu).and_return('show_menu')
      allow_any_instance_of(menu).to receive(:get_input).and_return(true)
    end

    it 'creates an example' do
      m = menu.new(filepath)
      expect { m.show_example('example') }.not_to raise_error
    end
  end

  context '.get_input' do
    let(:arr) { { 'categories' => %w[cat1 cat2] } }
    let(:arr2) { %w[cat1 cat2] }
    before(:each) do
      allow_any_instance_of(menu).to receive(:show_menu).and_return('show_menu')
      allow_any_instance_of(menu).to receive(:list_validator).and_return(1)
      allow_any_instance_of(menu).to receive(:show_sub_menu).and_return(true)
      allow_any_instance_of(menu).to receive(:show_example).and_return(true)
    end

    it 'gets an list_selector input' do
      m = menu.new(filepath)
      expect { m.get_input('list_selector', arr) }.not_to raise_error
      expect(m.get_input('list_selector', arr)).to eq true
    end

    it 'gets an sub_list_selector input' do
      m = menu.new(filepath)
      expect { m.get_input('sub_list_selector', arr2) }.not_to raise_error
      expect(m.get_input('sub_list_selector', arr2)).to eq true
    end

    it 'gets an end_list_selector input' do
      m = menu.new(filepath)
      expect { m.get_input('end_list_selector', arr2) }.not_to raise_error
      expect(m.get_input('end_list_selector', arr2)).to eq 'show_menu'
    end
  end

  context '.list_validator' do
    let(:arr) { %w[cat1 cat2] }
    before(:each) do
      allow_any_instance_of(menu).to receive(:show_menu).and_return(true)
      allow_any_instance_of(menu).to receive(:get_input).and_return('get_input')
    end

    it 'exits if value == q' do
      m = menu.new(filepath)
      expect(m.list_validator('q', arr, nil, nil)).to eq 'exit'
    end

    it 'returns an integar if valid array passed' do
      m = menu.new(filepath)
      expect(m.list_validator('1', arr, nil, nil)).to eq 1
    end

    it 'returns if no array passed' do
      m = menu.new(filepath)
      expect(m.list_validator('1', nil, nil, nil)).to eq false
    end

    it 'returns logs message if non-intager passed' do
      m = menu.new(filepath)
      expect(m.list_validator('s', arr, nil, nil)).to eq 'get_input'
    end
  end
end
