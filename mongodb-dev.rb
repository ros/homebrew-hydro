require 'formula'

class MongodbDev < Formula
  homepage 'http://www.mongodb.org/'
  url 'https://github.com/mongodb/mongo/archive/r2.4.4.tar.gz'
  sha1 '8aa03a2a4acd9ba4f0cbc0a9bdb6742409ada14c'
  version '2.4.4'

  depends_on 'scons'
  depends_on 'boost'

  def patches
    DATA
  end

  def install
    system "scons", "--use-system-boost", "--prefix=#{prefix}", "install"
  end

  test do
    system "false"
  end

end

__END__
diff --git a/SConstruct b/SConstruct
index a25c99d..6f7662a 100644
--- a/SConstruct
+++ b/SConstruct
@@ -783,6 +783,8 @@ if not use_system_version_of_library("pcre"):
 if not use_system_version_of_library("boost"):
     env.Prepend(CPPPATH=['$BUILD_DIR/third_party/boost'],
                 CPPDEFINES=['BOOST_ALL_NO_LIB'])
+else:
+    env.Prepend(CPPPATH=['/usr/local/include'])

 env.Prepend(CPPPATH=['$BUILD_DIR/third_party/s2'])
 env.Prepend(CPPPATH=['$BUILD_DIR/third_party/libstemmer_c/include'])
