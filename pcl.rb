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

  def patches
    # Patch allows PCL to build without pcl_io enabled
    # See: https://github.com/PointCloudLibrary/pcl/issues/235
    DATA
  end

  def install
    args = std_cmake_parameters.split

    if build.with? 'debug'
      args << "-DCMAKE_BUILD_TYPE=Debug"
    end

    args << "-DBUILD_io:BOOL=OFF"

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

__END__
diff --git a/surface/CMakeLists.txt b/surface/CMakeLists.txt
index a5af191..1ed4009 100644
--- a/surface/CMakeLists.txt
+++ b/surface/CMakeLists.txt
@@ -154,7 +154,11 @@ if(build)
     include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include ${VTK_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR})
     link_directories(${VTK_LIBRARY_DIRS})
     PCL_ADD_LIBRARY(${LIB_NAME} ${SUBSYS_NAME} ${srcs} ${incs} ${impl_incs} ${VTK_SMOOTHING_INCLUDES} ${POISSON_INCLUDES} ${OPENNURBS_INCLUDES} ${ON_NURBS_INCLUDES})
-    target_link_libraries(${LIB_NAME} pcl_common pcl_io pcl_search pcl_kdtree pcl_octree ${VTK_SMOOTHING_TARGET_LINK_LIBRARIES} ${ON_NURBS_LIBRARIES})
+    if(${BUILD_io})
+        target_link_libraries(${LIB_NAME} pcl_common pcl_io pcl_search pcl_kdtree pcl_octree ${VTK_SMOOTHING_TARGET_LINK_LIBRARIES} ${ON_NURBS_LIBRARIES})
+    else()
+        target_link_libraries(${LIB_NAME} pcl_common pcl_search pcl_kdtree pcl_octree ${VTK_SMOOTHING_TARGET_LINK_LIBRARIES} ${ON_NURBS_LIBRARIES})
+    endif()
     if(QHULL_FOUND)
       target_link_libraries(${LIB_NAME} ${QHULL_LIBRARIES})
     endif(QHULL_FOUND)
