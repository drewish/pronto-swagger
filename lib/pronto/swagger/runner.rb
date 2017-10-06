require 'yaml'

module Pronto
  module Swagger
    class Runner < Pronto::Runner
      DIRTY_WORDS = ['shit', 'piss', 'fuck', 'cunt', 'cocksucker', 'motherfucker', 'tits']

      def run
        return [] if !@patches || @patches.count.zero?

        @patches
          .select { |patch| patch.additions > 0 }
          .select { |patch| swagger_file?(patch.new_file_full_path) }
          .map { |patch| inspect(patch) }
          .flatten.compact
      end

      private

      def swagger_file?(path)
        /\.(yaml|yml|json)$/ =~ path.to_s
      end

      # def git_repo_path
      #   @git_repo_path ||= Rugged::Repository.discover(File.expand_path(Dir.pwd)).workdir
      # end

      def inspect(patch)
        contents = File.read(patch.new_file_full_path)
        # QUESTION: Could be a security risk to parse it. Might be better to regex?
        candidate = YAML.load(contents)
        if candidate["swagger"]
          response = HTTParty.post("http://online.swagger.io/validator/debug", body: contents)
          response.parsed_response
require 'pry'
binding.pry
        end
        # offending_line_numbers(patch).map do |line_number|
        #   patch
        #     .added_lines
        #     .select { |line| line.new_lineno == line_number }
        #     .map { |line| new_message('Avoid using one of the seven dirty words', line) }
        # end
      end

      def new_message(offence, line)
        path = line.patch.delta.new_file[:path]
        level = :warning

        Message.new(path, line, level, offence, nil, self.class)
      end

      def offending_line_numbers(patch)
        line_numbers = []

        Dir.chdir(git_repo_path) do
          escaped_file_path = Shellwords.escape(patch.new_file_full_path.to_s)

          File.foreach(escaped_file_path).with_index do |line, line_num|
            line_numbers << line_num + 1 if DIRTY_WORDS.any? { |word| line.downcase.include?(word) }
          end

          line_numbers
        end
      end
    end
  end
end
