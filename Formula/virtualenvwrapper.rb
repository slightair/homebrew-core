class Virtualenvwrapper < Formula
  include Language::Python::Virtualenv

  desc "Python virtualenv extensions"
  homepage "https://virtualenvwrapper.readthedocs.io/"
  url "https://files.pythonhosted.org/packages/c1/6b/2f05d73b2d2f2410b48b90d3783a0034c26afa534a4a95ad5f1178d61191/virtualenvwrapper-4.8.4.tar.gz"
  sha256 "51a1a934e7ed0ff221bdd91bf9d3b604d875afbb3aa2367133503fee168f5bfa"
  license "MIT"
  revision 1

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9c5ab941c4451aa23660251d19b45aab691f19bd1c07cf86bd3c6ca6c1b88c47"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "74a96e10f2942fe7d13f2a6762646b31e08cea1f66c0c53636d8d98561eeefec"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "74a96e10f2942fe7d13f2a6762646b31e08cea1f66c0c53636d8d98561eeefec"
    sha256 cellar: :any_skip_relocation, ventura:        "a66e21235b0b0fae7aa9aa6a64fa303d6cc4d37af66bf547254bb85a46a0463f"
    sha256 cellar: :any_skip_relocation, monterey:       "08e4e00e81eae339868ecc2b59f87a23c4e93484112c502c708be95ffd8cea1a"
    sha256 cellar: :any_skip_relocation, big_sur:        "08e4e00e81eae339868ecc2b59f87a23c4e93484112c502c708be95ffd8cea1a"
    sha256 cellar: :any_skip_relocation, catalina:       "08e4e00e81eae339868ecc2b59f87a23c4e93484112c502c708be95ffd8cea1a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6f6de08b9ad1797786a4383706e8c5f99e6c53f98ea8a6a1d83238568612fa71"
  end

  depends_on "python@3.10"
  depends_on "six"
  depends_on "virtualenv"

  resource "appdirs" do
    url "https://files.pythonhosted.org/packages/d7/d8/05696357e0311f5b5c316d7b95f46c669dd9c15aaeecbb48c7d0aeb88c40/appdirs-1.4.4.tar.gz"
    sha256 "7d5d0167b2b1ba821647616af46a749d1c653740dd0d2415100fe26e27afdf41"
  end

  resource "pbr" do
    url "https://files.pythonhosted.org/packages/65/e2/8cb5e718a3a63e8c22677fde5e3d8d18d12a551a1bbd4557217e38a97ad0/pbr-5.5.1.tar.gz"
    sha256 "5fad80b613c402d5b7df7bd84812548b2a61e9977387a80a5fc5c396492b13c9"
  end

  resource "stevedore" do
    url "https://files.pythonhosted.org/packages/95/bc/dc386a920942dbdfe480c8a4d953ff77ed3dec99ce736634b6ec4f2d97c1/stevedore-3.3.0.tar.gz"
    sha256 "3a5bbd0652bf552748871eaa73a4a8dc2899786bc497a2aa1fcb4dcdb0debeee"
  end

  resource "virtualenv-clone" do
    url "https://files.pythonhosted.org/packages/1d/51/076f3a72af6c874e560be8a6145d6ea5be70387f21e65d42ddd771cbd93a/virtualenv-clone-0.5.4.tar.gz"
    sha256 "665e48dd54c84b98b71a657acb49104c54e7652bce9c1c4f6c6976ed4c827a29"
  end

  def install
    python3 = "python3.10"
    venv = virtualenv_create(libexec, python3)
    venv.pip_install resources
    venv.pip_install buildpath

    bin.install_symlink libexec/"bin/virtualenvwrapper_lazy.sh"
    (bin/"virtualenvwrapper.sh").write <<~SH
      #!/bin/sh
      export VIRTUALENVWRAPPER_PYTHON="#{libexec}/bin/#{python3}"
      source "#{libexec}/bin/virtualenvwrapper.sh"
    SH
  end

  def caveats
    <<~EOS
      To activate virtualenvwrapper, add the following at the end of your #{shell_profile}:
        source virtualenvwrapper.sh
    EOS
  end

  test do
    assert_match "created virtual environment",
                 shell_output("bash -c 'source virtualenvwrapper.sh; mktmpenv'")
  end
end
