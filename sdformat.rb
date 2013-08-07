require 'formula'

class Sdformat < Formula
  homepage 'http://gazebosim.org'
  url 'http://bitbucket.org/osrf/sdformat/get/52862f6b1db3663fd25c702b9a2226a50572b261.tar.bz2'
  sha1 '7a05afa9e53ca4299ecfb4162ded2d533d04ef72'
  version '1.4.5'

  depends_on 'boost'
  depends_on 'cmake'  => :build
  depends_on 'tinyxml'

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
