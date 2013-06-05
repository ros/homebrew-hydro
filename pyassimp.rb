require 'formula'

class Pyassimp < Formula
  homepage 'http://assimp.sourceforge.net/'
  url 'http://sourceforge.net/projects/assimp/files/assimp-2.0/assimp--2.0.863-sdk.zip'
  sha1 'eb6938c134e7110a96243570e52a8b860d15d915'
  version '2.0.863'

  depends_on 'python' => :build

  def install
    temp_site_packages = lib/which_python/'site-packages'
    mkdir_p temp_site_packages
    ENV['PYTHONPATH'] = temp_site_packages

    args = [
      "--verbose",
      "install",
      "--install-scripts=#{bin}",
      "--install-lib=#{temp_site_packages}",
    ]

    # build the pyassimp libraries
    system "python", "-s", "setup.py", *args
  end

  def which_python
    "python" + `python -c 'import sys;print(sys.version[:3])'`.strip
  end

  test do
    system "python", "-c", "'import pyassimp'"
  end
end
