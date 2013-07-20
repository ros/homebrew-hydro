require 'formula'

class Gazebo < Formula
  homepage 'http://gazebosim.org'
  url 'http://bitbucket.org/osrf/gazebo/get/40f72951fb51a982234c457f89b79c7824e4b4b0.tar.bz2'
  sha1 '5c9133646f30c1fbb0d1d27f4291dbeb9116d0ae'
  version '1.9.5'

  depends_on 'boost'
  depends_on 'cmake'  => :build
  depends_on 'doxygen'
  depends_on 'freeimage'
  depends_on 'libtar'
  depends_on 'ogre'
  depends_on 'pkg-config' => :build
  depends_on 'protobuf'
  depends_on 'protobuf-c'
  depends_on 'qt'
  depends_on 'tbb'
  depends_on 'tinyxml'

  depends_on 'bullet' => [:optional, 'shared']

  def install
    ENV.m64

    cmake_args = [
      "-DCMAKE_BUILD_TYPE='Release'",
      "-DCMAKE_INSTALL_PREFIX='#{prefix}'",
      "-DCMAKE_FIND_FRAMEWORK=LAST",
      "-Wno-dev"
    ]
    #cmake_args.concat(std_cmake_args)
    cmake_args << ".."

    mkdir "build" do
      system "cmake", *cmake_args
      system "make install"
    end
  end
end
