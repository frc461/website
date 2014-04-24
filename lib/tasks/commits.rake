desc "compile commits into commit_hashes"

task :compile_hashes do
	`git --no-pager log --pretty=format:'%H' -n 8 > commit_hashes`
	`echo >> commit_hashes`
end
