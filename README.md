# Octopress GithubUser plugin

##Usage

Its pretty straightforward - githubuser is a Liquid block that accepts one variable - variable that is assigned with github username, that should be outputed.
Inside this block you can access github user's data with this format: `githubuser-#{param}`.
Available params is all keys that are returned via github v3 api, more info [here](http://developer.github.com/v3/users/)

##Example

Lets say you want to output github user info in post author sidebar:
```
{% if author %}
  <div class="author">
    {% githubuser author %}
      <img class="githubuser-avatar" src="{githubuser-avatar_url}" />
      <div class="githubuser-name-wrapper"><a href="{githubuser-html_url}" class="githubuser-name">{githubuser-login}</a></div>
      <span class="githubuser-location">{githubuser-location}</span>
      <span class="githubuser-email">{githubuser-email}</span>
    {% endgithubuser %}
  </div>
{% endif %}
```
