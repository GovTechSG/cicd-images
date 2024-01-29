require 'json'
Dir.chdir(ARGV[0]) do
  print __dir__ + "\n"
  raw_commit_data = `git --no-pager log --pretty=oneline --since=30.days`
  commit_data = raw_commit_data.split(/\r?\n/)

  git_json = {}

  commit_data.each do |line|
    sha = line.split(" ").first
    story_ids = line.match /(#[0-9]+)/

    if story_ids && story_ids.length
      for i in 0..(story_ids.length-1)
        story_id = story_ids[i].gsub('#', '')
        git_json[story_id] ||= []
        git_json[story_id] << sha
      end
    end
  end
  print git_json
  path = "./static/commits.json"
  File.open(path, 'w') {|f| f.write(git_json.to_json) }
end