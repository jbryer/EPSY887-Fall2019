


##### Setup the blogdown site
# blogdown::install_hugo() # Install Hugo if not already
blogdown::hugo_version()
# Using this theme: https://themes.gohugo.io/hugo-theme-techdoc/
# blogdown::new_site(theme = 'thingsym/hugo-theme-techdoc')

blogdown::start_server()
blogdown::stop_server()

blogdown::build_site()
