def commit_callback(commit):
    if commit.author_email == "zachmartin@zachs-macbook-pro.local":
        commit.author_email = "zach@zach-martin.com"
        commit.committer_email = "zach@zach-martin.com"
