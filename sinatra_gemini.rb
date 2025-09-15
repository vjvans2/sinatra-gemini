# frozen_string_literal: true
require 'sinatra'
require 'gemini-ai'
require 'pdf-reader'
require "dotenv/load"

class SinatraGemini
  def run(task)
    gemini = Gemini.new(
      credentials: {
        # service: 'vertex-ai-api',
        service: 'generative-language-api',
        api_key: ENV['GEMINI_API_KEY'],
        region: 'us-central1'
      },
      options: {
        model: 'gemini-1.5-flash-002'
        # model: 'gemini-pro'
      }
    )

    text_files = Dir.glob('files/*.txt')
    text_brain = text_files.map { |file| File.read(file) }

    pdf_files = Dir.glob('files/*.pdf')
    pdf_brain = ''
    pdf_files.each do |file|
      PDF::Reader.open(file) do |reader|
        reader.pages.each { |page| pdf_brain += page.text }
      end
    end

    prompt = <<~PROMPT
      Use the following data only.  Use no external knowledge, even things that may sound common.

      #{text_brain}
      #{pdf_brain}

      #{task}

    PROMPT

    gemini.generate_content(
      { contents: { role: 'user', parts: { text: prompt } } }
    )
  end
end