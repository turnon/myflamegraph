require "myflamegraph/version"
require 'flamegraph'
require 'tmpdir'

module Myflamegraph
  class << self
    def tmp
      Dir.tmpdir
    end
  end

  class Railtie < Rails::Railtie
    initializer 'myflamegraph.controller_additions' do
      ActiveSupport.on_load :action_controller do
        include ::Myflamegraph::Wrapper
      end
    end
  end

  module Wrapper
    extend ActiveSupport::Concern

    module ClassMethods
      def ffff *methods
        around_action :wrap_myflamegraph, only: methods
      end
    end

    def wrap_myflamegraph
      html = Flamegraph.generate do
        yield
      end

      file_name = [
        Time.current.to_s.gsub(/[^\w]/, '-'),
        params[:controller].gsub(/[^\w]/, '-'),
        params[:action],
        'html'
      ].join('.')

      file_path = File.join(Dir.tmpdir, file_name)

      File.open file_path, 'a' do |f|
        f.puts html
      end
    end
  end

end
