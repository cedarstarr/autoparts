# Copyright (c) 2013-2014, Irrational Industries Inc. (Nitrous.IO)
# All rights reserved.

# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:

# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

module Autoparts
  module Packages
    class Ruby21 < Package
      name 'ruby21'
      version '2.1.1'
      description "Ruby: A prorammer's best friend"
      source_url 'http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.gz'
      source_sha1 '27cbc8ae98863b4607ede8085beca2a20f4c03fd'
      source_filetype 'tar.gz'

      depends_on "chruby"

      def compile
        Dir.chdir(ruby_version) do
          args = [
            "--prefix=#{prefix_path}"
          ]
          execute "./configure", *args
        end
      end

      def install
        Dir.chdir(ruby_version) do
          execute "make install"
        end
      end

      def post_install
        execute "ln", "-sf", prefix_path, chruby_path
      end

      def post_uninstall
        FileUtils.rm_rf chruby_path
      end

      def chruby_path
        get_dependency("chruby").rubies_dir + ruby_version
      end

      def ruby_version
        "ruby-#{version}"
      end

      def tips
        <<-EOF.unindent
        You can switch ruby versions with chruby
        First, reload chruby definitions
          $ eval "$(parts init -)"
        Then, new ruby version should appear in chruby list
          $ chruby
        And you can switch to the new version
          $ chruby new_ruby_version
        More information about chruby here https://github.com/postmodern/chruby
        EOF
      end
    end
  end
end
