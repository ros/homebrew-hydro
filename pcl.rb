require 'formula'

class Pcl < Formula
  homepage 'http://pointclouds.org/'
  url 'https://github.com/PointCloudLibrary/pcl/archive/pcl-1.7.1.tar.gz'
  sha1 '784bce606141260423ea04f37b093f59d4c94c6a'
  
  head 'https://github.com/PointCloudLibrary/pcl.git', :revision => 'b1edb0d9cad7f33122398f2bea5d6339358bed5a'

  depends_on 'cmake' => :build
  depends_on 'boost'
  depends_on 'eigen'
  depends_on 'flann'
  depends_on 'vtk5' => 'with-qt'
  depends_on 'qhull' => :recommended
  depends_on 'sphinx' => :python
   
  option 'with-debug', "Enable debug symbols."
  option 'with-tests', "Enable tests."
  option 'with-examples', "Enable examples."
  
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
    
    if build.with? 'tests'
      args << "-DBUILD_global_tests=ON"
    end
    
    if build.with? 'examples'
      args << "-DBUILD_examples=ON"
    end


    system "mkdir build"
    args << ".."
    Dir.chdir 'build' do
      system "cmake", *args
      system "make install"
    end
  end

  def test
    system "bash -c 'echo | pcl_plyheader'"
  end
end
