require "paperclip"
require "paperclip/content_type_processor/version"
require "filemagic"

module Paperclip
  class ContentTypeProcessor < Processor

    Processor = Struct.new(:command, :argumments)

    def self.add_content_type_processor(content_type, command, argumments)
      @processors ||= {}
      @processors[content_type] = Processor.new(command, argumments)
    end

    def self.content_type_processor_for(content_type)
      @processors ||= {}
      @processors[content_type]
    end

    def make
      content_type_processor = ContentTypeProcessor.content_type_processor_for(file_content_type)

      if content_type_processor
        exec(content_type_processor)
      else
        file
      end
    end

    private

      def exec(content_type_processor)
        whiny    = options.has_key?(:whiny) ? options[:whiny] : true
        src_path = File.expand_path(file.path)

        begin
          Paperclip.run(content_type_processor.command, "#{content_type_processor.argumments} :src_path", src_path: src_path)
          file
        rescue Cocaine::ExitStatusError => e
          raise Paperclip::Error, "#{content_type_processor.command} : There was an error processing the thumbnail for #{src_path}" if whiny
        rescue Cocaine::CommandNotFoundError => e
          raise Paperclip::Errors::CommandNotFoundError.new("Could not run '#{content_type_processor.command}'. Please install #{content_type_processor.command}.")
        end
      end

      def file_content_type
        file.is_a?(Paperclip::AbstractAdapter) ? file.content_type : FileMagic.fm(FileMagic::MAGIC_MIME_TYPE).file(file.respond_to?(:path) ? file.path : file)
      end

  end
end
