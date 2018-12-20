# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/timelocal"

describe LogStash::Filters::Timelocal do
  describe "Don't alter message" do
    let(:config) do <<-CONFIG
      filter {
        timelocal {
          message => "Hello World"
        }
      }
    CONFIG
    end

    sample("message" => "some text") do
      expect(subject).to include("message")
      expect(subject.get('message')).to eq('some text')
    end
  end
end
