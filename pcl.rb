require 'formula'

class Pcl < Formula
  homepage 'http://www.pointclouds.org'
  url 'https://github.com/PointCloudLibrary/pcl/archive/pcl-1.7.0.tar.gz'
  sha1 'b387f1ab218f545e3fe9f3c59d73b8fa8e2cf5ca'

  head 'https://github.com/PointCloudLibrary/pcl.git'

  depends_on 'cmake' => :build
  depends_on 'boost'
  depends_on 'eigen'
  depends_on 'flann'
  depends_on 'vtk'
  depends_on 'qhull'

  option 'with-debug', "Enable debug symbols"

  bottle do
    root_url 'http://download.ros.org/bottles'
    revision 1
    sha1 'f4547bff71a9cc32737df3f534c8071df605769e' => :mountain_lion
  end

  def install
    args = std_cmake_parameters.split

    if build.with? 'debug'
      args << "-DCMAKE_BUILD_TYPE=Debug"
    end

    system "mkdir build"
    args << ".."
    Dir.chdir 'build' do
      system "cmake", *args
      system "make install"
    end
  end

  def test
    system "bash -c 'echo | plyheader'"
  end
end
