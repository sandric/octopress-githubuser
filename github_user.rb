require 'net/https'

module Jekyll
  class GithubUserBlock < Liquid::Block

    def get_user_data_from_github(username, query_login, query_pass)
      uri = URI("https://api.github.com/users/#{username}")
      req = Net::HTTP::Get.new(uri.to_s)
      req.basic_auth(query_login, query_pass)
      Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        response = http.request(req)
        if response.code == "200"
          JSON.parse(response.body)
        end
      end
    end

    def initialize(tag_name, markup, tokens)
      @username_variable = markup.strip
      super
    end

    def render(context)
      output = super
      username = context["page"][@username_variable] || context["post"][@username_variable]
      @userdata = get_user_data_from_github(username, "your_github_account_login", "your_github_account_password")
      @userdata.each do |key, value|
        output.gsub!(/{githubuser-#{key}}/, value.to_s)
      end
      output
    end
  end
end

Liquid::Template.register_tag('githubuser', Jekyll::GithubUserBlock)
