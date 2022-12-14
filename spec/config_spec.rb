# frozen_string_literal: true

require_relative '../lib/config'

RSpec.describe SpecRefLib::Config do
  let(:subject) { SpecRefLib::Config }
  it { expect(subject.version).to eq '1.0.0' }
  it { expect(subject.default_url).to eq 'https://raw.githubusercontent.com/swaff-y/spec-ref-lib/main/lib/specr.json' }
  it { expect(subject.env).to eq 'SPEC_REF_LIB' }
end
