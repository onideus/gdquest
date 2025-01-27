from git_filter_repo import RepoFilter

def rewrite_email(commit):
	if commit.author_email == "zachmartin@zachs-macbook-pro.local":
		commit.author_email = "zach@zach-martin.com"
		commit.committer_email = "zach@zach-martin.com"

RepoFilter(rewrite_email).run()
