require 'rubygems'

require 'bundler/setup'

require 'shoulda'
require 'rr'
require 'fakeweb'
require "refactorial"


module Kernel
  def ` cmd
    cmd
  end

  def sh cmd
    cmd
  end
end
