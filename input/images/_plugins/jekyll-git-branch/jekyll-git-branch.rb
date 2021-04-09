module Jekyll
  class GitBranch < Generator
    def generate(site)
      site.data['git-branch'] = %x( git rev-parse --abbrev-ref HEAD ).strip
    end
  end
end