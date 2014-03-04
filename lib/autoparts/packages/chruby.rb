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
    class Chruby < Package
      name 'chruby'
      version '0.3.8'
      description 'Chruby: Changes the current ruby'
      source_url 'https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz'
      source_sha1 '320d13bacafeae72631093dba1cd5526147d03cc'
      source_filetype 'tar.gz'

      def install
	Dir.chdir('chruby-0.3.8') do
	  execute "make", "install", "PREFIX=#{prefix_path}"
	end
      end

      def required_env
	env = ["source #{prefix_path}/share/chruby/chruby.sh"]
	if rubies_dir.entries.length > 2
	  env << "export RUBIES=(#{rubies_dir + "*"})"
	end
	env
      end

      def tips
	<<-EOF.unindent
	You have succesfully installed chruby

	To activate chruby in the current shell:
	  $ eval "$(parts init -)"
	EOF
      end

      def rubies_dir
	p = Path.share + "ruby" + "rubies"
	p.mkpath unless p.exist?
	p
      end
    end
  end
end
