output "repo_name" {
    value = github_repository.this.name
}

output "full_name" {
  value = github_repository.this.full_name
  description = "A string of the form 'orgname/reponame'."
}

output "html_url" {
  value = github_repository.this.html_url
  description = "URL to the repository on the web."
}

output "ssh_clone_url" {
  value = github_repository.this.ssh_clone_url
  description = "URL to clone the repository via SSH."
}

output "http_clone_url" {
  value = github_repository.this.http_clone_url
  description = "URL to clone the repository via HTTPS."
}

output "git_clone_url" {
  value = github_repository.this.git_clone_url
  description = "URL to clone the repository anonymously via the git protocol."
}

output "svn_url" {
  value = github_repository.this.svn_url
  description = "URL to check out the repository via GitHub's Subversion protocol emulation."
}

output "node_id" {
  value = github_repository.this.node_id
  description = "GraphQL global node id for use with v4 API."
}

output "repo_id" {
  value = github_repository.this.id
  description = "GitHub ID for the repository."
}

