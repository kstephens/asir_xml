require 'asir/coder/xml'

module ASIR
  class Coder
    class XML
      class Parser
        case (RUBY_PLATFORM rescue "UNKNOWN")
        when /java/i
          include Java
          require File.expand_path('../../../../../jdom/jdom-2.0.5.jar', __FILE__)

          def parse stream
            case stream
            when String
              input_stream = java.io.ByteArrayInputStream.new(stream.to_java_bytes)
              builder = org.jdom2.input.SAXBuilder.new
            when IO
              input_stream = stream.to_io
            else
              raise TypeError, "cannot parse #{stream.class.name}"
            end
            jdom = builder.build(input_stream)
            Document.new(jdom)
          end

          # Make JDOM compatible with libXML DOM.
          class BaseElement
            def initialize j; @j = j; end
          end

          class Document < BaseElement
            def root
              Element.new(@j.getRootElement)
            end
          end

          class Element < BaseElement
            def name
              @j.getName
            end

            def content
              return @content if @content
              @content = @j.getContent.map{ | a | a.getText.to_s } * ''
            end

            def attributes
              return @attributes if @attributes
              h = { }
              @j.getAttributes.each { | a | h[a.getName] = a.getValue }
              h.extend(IndifferentAccess)
              @attributes = h
            end

            def elements
              return @elements if @elements
              @elements = @j.getChildren.map { | a | Element.new(a) }
            end

            def first; elements.first; end

            def each_element &blk
              elements.each &blk
            end
          end

          module IndifferentAccess
            def [] x
              x = x.to_s if Symbol === x
              super(x)
            end
          end

        else
          gem 'libxml-ruby'
          require 'xml'

          def parse stream
            case stream
            when String
              ::XML::Parser.string(stream).parse
            else
              raise TypeError, "cannot parse #{stream.class.name}"
            end
          end
       end
      end
    end
  end
end


