require "ice_cube_ex/version"

unless defined?(IceCube)
  raise 'gem ice_cube must be require before requiring ice_cube_ex'
end

module IceCubeEx
end

require 'ice_cube_ex/ice_cube/rule'