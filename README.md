# OpenIdAuthentication

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/gem/v/open_id_authentication.svg)](https://rubygems.org/gems/open_id_authentication)
[![Downloads Today](https://img.shields.io/gem/rd/open_id_authentication.svg)](https://github.com/oauth-xx/open_id_authentication)
[![Depfu](https://badges.depfu.com/badges/0860845c093872a36ee51d1f7e9203db/overview.svg)](https://depfu.com/github/oauth-xx/open_id_authentication?project_id=46542)
[![Test Coverage](https://api.codeclimate.com/v1/badges/f8810737ca8a04d8593b/test_coverage)](https://codeclimate.com/github/oauth-xx/open_id_authentication/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/f8810737ca8a04d8593b/maintainability)](https://codeclimate.com/github/oauth-xx/open_id_authentication/maintainability)[![CI Supported Build][🚎s-wfi]][🚎s-wf]
[![CI Supported Build][🚎s-wfi]][🚎s-wf]
[![CI Unsupported Build][🚎us-wfi]][🚎us-wf]
[![CI Style Build][🚎st-wfi]][🚎st-wf]
[![CI Coverage Build][🚎cov-wfi]][🚎cov-wf]
[![CI Heads Build][🚎hd-wfi]][🚎hd-wf]

-----

[![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]
-----

[🚎s-wf]: https://github.com/oauth-xx/open_id_authentication/actions/workflows/supported.yml
[🚎s-wfi]: https://github.com/oauth-xx/open_id_authentication/actions/workflows/supported.yml/badge.svg
[🚎us-wf]: https://github.com/oauth-xx/open_id_authentication/actions/workflows/unsupported.yml
[🚎us-wfi]: https://github.com/oauth-xx/open_id_authentication/actions/workflows/unsupported.yml/badge.svg
[🚎st-wf]: https://github.com/oauth-xx/open_id_authentication/actions/workflows/style.yml
[🚎st-wfi]: https://github.com/oauth-xx/open_id_authentication/actions/workflows/style.yml/badge.svg
[🚎cov-wf]: https://github.com/oauth-xx/open_id_authentication/actions/workflows/coverage.yml
[🚎cov-wfi]: https://github.com/oauth-xx/open_id_authentication/actions/workflows/coverage.yml/badge.svg
[🚎hd-wf]: https://github.com/oauth-xx/open_id_authentication/actions/workflows/heads.yml
[🚎hd-wfi]: https://github.com/oauth-xx/open_id_authentication/actions/workflows/heads.yml/badge.svg

Provides a thin wrapper around _[rack-openid2](https://github.com/oauth-xx/rack-openid2)_,
which itself is a thin wrapper around _[ruby-openid2](https://github.com/oauth-xx/ruby-openid2)_.
These are modernized forks of the
ancient-and-archived `rack-openid` and `ruby-openid` gems from JanRain,
an [early sponsor](https://en.wikipedia.org/wiki/OpenID#History) of OpenID standards.

To understand what OpenID is about and how it works,
it helps to read the documentation for [lib/openid/consumer.rb](https://github.com/oauth-xx/ruby-openid2/blob/main/lib/openid/consumer.rb)
from the `ruby-openid2` gem.

The specifications used are [OpenID Authentication 2.0](http://openid.net/specs/openid-authentication-2_0.html),
[OpenID Attribute Exchange 1.0](http://openid.net/specs/openid-attribute-exchange-1_0.html), and
[OpenID Simple Registration Extension 1.0](https://openid.net/specs/openid-simple-registration-extension-1_0.html).
These are considered [obsolete standards](https://openid.net/developers/specs/),
having been super-ceded by OpenID Connect.
In general, if you have a choice, a solution based on OpenID Connect,
which is itself based on the modern OAuth 2.0 specification,
will be a **better choice** than OpenID 2.0 and this library.

This library is mature, and used in production.  Maintenance should be expected for security issues and some bugfixes.

In the early days of Rails, this was an official Rails plugin, written by DHH. See [Credits](#credits) for more information.

NOTE: This gem does not implement OpenID Connect, which is effectively version 3.0 of the OpenID standard.
This gem is _not_ based on OAuth 2.0 as OpenID 2.0 was developed before OAuth existed.
OTOH, OpenID Connect is based on OAuth 2.0, but you'll need a different library for that.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add open_id_authentication

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install open_id_authentication

## Setup

OpenID authentication uses the session, so be sure that you haven't turned that off.

Alternatively, you can use the file-based store, which just relies on `tmp/openids` being present in RAILS_ROOT. But be aware that this store only works if you have a single application server. And it's not safe to use across NFS. It's recommended that you use the database store if at all possible. To use the file-based store, you'll also have to add this line to your config/environment.rb:

    OpenIdAuthentication.store = :file

This particular plugin also relies on the fact that the authentication action allows for both POST and GET operations.
If you're using REST-ful authentication, you'll need to explicitly allow for this in your routes.rb.

The plugin also expects to find a root_url method that points to the home page of your site. You can accomplish this by using a root route in config/routes.rb:

    root :to => "articles#index"

This plugin works with any version of Rails you can run on Ruby 2.7 or newer.

## Example

This example is just to meant to demonstrate how you could use OpenID authentication. You might well want to add
salted hash logins instead of plain text passwords and other requirements on top of this. Treat it as a starting point,
not a destination.

Note that the User model referenced in the simple example below has an 'identity_url' attribute. You will want to add the same or similar field to whatever
model you are using for authentication.

Also of note is the following code block used in the example below:

    authenticate_with_open_id do |result, identity_url|
      ...
    end

In the above code block, 'identity_url' will need to match user.identity_url exactly. 'identity_url' will be a string in the form of 'http://example.com' -
If you are storing just 'example.com' with your user, the lookup will fail.

There is a handy method in this plugin called 'normalize_url' that will help with validating OpenID URLs.

    OpenIdAuthentication.normalize_url(user.identity_url)

The above will return a standardized version of the OpenID URL - the above called with 'example.com' will return 'http://example.com/'
It will also raise an InvalidOpenId exception if the URL is determined to not be valid.
Use the above code in your User model and validate OpenID URLs before saving them.

config/routes.rb

    #config/routes.rb
    root :to => "articles#index"
    resource :session

app/views/sessions/new.erb

    #app/views/sessions/new.erb
    <% form_tag(session_url) do %>
      <p>
        <label for="name">Username:</label>
        <%= text_field_tag "name" %>
      </p>

      <p>
        <label for="password">Password:</label>
        <%= password_field_tag %>
      </p>

      <p>
        <!-- ...or use: -->
      </p>

      <p>
        <label for="openid_identifier">OpenID:</label>
        <%= text_field_tag "openid_identifier" %>
      </p>

      <p>
        <%= submit_tag 'Sign in', :disable_with => "Signing in&hellip;" %>
      </p>
    <% end %>


app/controllers/sessions_controller.rb

    #app/controllers/sessions_controller.rb
    class SessionsController < ApplicationController
      def create
        if using_open_id?
          open_id_authentication
        else
          password_authentication(params[:name], params[:password])
        end
      end


      protected
      def password_authentication(name, password)
        if @current_user = @account.users.authenticate(params[:name], params[:password])
          successful_login
        else
          failed_login "Sorry, that username/password doesn't work"
        end
      end

      def open_id_authentication
        authenticate_with_open_id do |result, identity_url|
          if result.successful?
            if @current_user = @account.users.find_by_identity_url(identity_url)
              successful_login
            else
              failed_login "Sorry, no user by that identity URL exists (#{identity_url})"
            end
          else
            failed_login result.message
          end
        end
      end


      private
      def successful_login
        session[:user_id] = @current_user.id
        redirect_to(root_url)
      end

      def failed_login(message)
        flash[:error] = message
        redirect_to(new_session_url)
      end
    end

If you're fine with the result messages above and don't need individual logic on a per-failure basis,
you can collapse the case into a mere boolean:

    def open_id_authentication
      authenticate_with_open_id do |result, identity_url|
        if result.successful? && @current_user = @account.users.find_by_identity_url(identity_url)
          successful_login
        else
          failed_login(result.message || "Sorry, no user by that identity URL exists (#{identity_url})")
        end
      end
    end

## Simple Registration OpenID Extension

Some OpenID Providers support this lightweight profile exchange protocol.  See more: https://openid.net/specs/openid-simple-registration-extension-1_0.html

You can support it in your app by changing #open_id_authentication

      def open_id_authentication(identity_url)
        # Pass optional :required and :optional keys to specify what sreg fields you want.
        # Be sure to yield registration, a third argument in the
        # #authenticate_with_open_id block.
        authenticate_with_open_id(identity_url,
            :required => [ :nickname, :email ],
            :optional => :fullname) do |result, identity_url, registration|
          case result.status
          when :missing
            failed_login "Sorry, the OpenID server couldn't be found"
          when :invalid
            failed_login "Sorry, but this does not appear to be a valid OpenID"
          when :canceled
            failed_login "OpenID verification was canceled"
          when :failed
            failed_login "Sorry, the OpenID verification failed"
          when :successful
            if @current_user = @account.users.find_by_identity_url(identity_url)
              assign_registration_attributes!(registration)

              if current_user.save
                successful_login
              else
                failed_login "Your OpenID profile registration failed: " +
                  @current_user.errors.full_messages.to_sentence
              end
            else
              failed_login "Sorry, no user by that identity URL exists"
            end
          end
        end
      end

      # registration is a hash containing the valid sreg keys given above
      # use this to map them to fields of your user model
      def assign_registration_attributes!(registration)
        model_to_registration_mapping.each do |model_attribute, registration_attribute|
          unless registration[registration_attribute].blank?
            @current_user.send("#{model_attribute}=", registration[registration_attribute])
          end
        end
      end

      def model_to_registration_mapping
        { :login => 'nickname', :email => 'email', :display_name => 'fullname' }
      end

## Attribute Exchange OpenID Extension

Some OpenID providers also support the OpenID AX (attribute exchange) protocol for exchanging identity information between endpoints.  See more: http://openid.net/specs/openid-attribute-exchange-1_0.html

Accessing AX data is very similar to the Simple Registration process, described above -- just add the URI identifier for the AX field to your :optional or :required parameters.  For example:

    authenticate_with_open_id(identity_url,
      :required => [ :email, 'http://schema.openid.net/birthDate' ]) do
        |result, identity_url, registration, ax|

This would provide the sreg data for :email via registration, and the AX data for http://schema.openid.net/birthDate via ax.

## General Info

| Primary Namespace | `OpenIdAuthentication`                                                                                                                                                                                                                                                                                                                                                                                                                                |
|-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| code triage       | [![Open Source Helpers](https://www.codetriage.com/oauth-xx/open_id_authentication/badges/users.svg)](https://www.codetriage.com/oauth-xx/open_id_authentication)                                                                                                                                                                                                                                                                                     |
| documentation     | [on Github.com][homepage],  [on RubyDoc.info][documentation]                                                                                                                                                                                                                                                                                                                                                                                          |
| expert support    | [![Get help on Codementor](https://cdn.codementor.io/badges/get_help_github.svg)](https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github)                                                                                                                                                                                                                                                 |
| `...` 💖          | [![Liberapay Patrons][⛳liberapay-img]][⛳liberapay] [![Sponsor Me][🖇sponsor-img]][🖇sponsor] [![Follow Me on LinkedIn][🖇linkedin-img]][🖇linkedin] [![Find Me on WellFound:][✌️wellfound-img]][✌️wellfound] [![Find Me on CrunchBase][💲crunchbase-img]][💲crunchbase] [![My LinkTree][🌳linktree-img]][🌳linktree] [![Follow Me on Ruby.Social][🐘ruby-mast-img]][🐘ruby-mast] [![Tweet @ Peter][🐦tweet-img]][🐦tweet] [💻][coderme] [🌏][aboutme] |

<!-- 7️⃣ spread 💖 -->
[🐦tweet-img]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow%20%40galtzo
[🐦tweet]: http://twitter.com/galtzo
[🚎blog]: http://www.railsbling.com/tags/open_id_authentication/
[🚎blog-img]: https://img.shields.io/badge/blog-railsbling-brightgreen.svg?style=flat
[🖇linkedin]: http://www.linkedin.com/in/peterboling
[🖇linkedin-img]: https://img.shields.io/badge/PeterBoling-blue?style=plastic&logo=linkedin
[✌️wellfound]: https://angel.co/u/peter-boling
[✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=plastic&logo=wellfound
[💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=plastic&logo=crunchbase
[🐘ruby-mast]: https://ruby.social/@galtzo
[🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https%3A%2F%2Fruby.social&style=plastic&logo=mastodon&label=Ruby%20%40galtzo
[🌳linktree]: https://linktr.ee/galtzo
[🌳linktree-img]: https://img.shields.io/badge/galtzo-purple?style=plastic&logo=linktree
[documentation]: https://rubydoc.info/github/oauth-xx/open_id_authentication
[homepage]: https://github.com/oauth-xx/open_id_authentication

<!-- Maintainer Contact Links -->
[aboutme]: https://about.me/peter.boling
[coderme]: https://coderwall.com/Peter%20Boling

## Credits

### 🌈 Contributors

Current maintainer(s):

- [Peter Boling](https://github.com/pboling)

Special thanks to:

- [David Heinemeier Hansson](https://dhh.dk/)
- [Joshua Peek](https://github.com/josh)

who were the original author and maintainer, respectively, of Rails'
[original `open_id_authentication`](https://github.com/rails/open_id_authentication) plugin,
which eventually became this gem library.

And thanks to the many other contributors!

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/oauth-xx/open_id_authentication/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=oauth-xx/open_id_authentication

## 📄 License

The gem is available as open source under the terms of
the [MIT License][📄license] [![License: MIT][📄license-img]][📄license-ref].

See [LICENSE.txt][📄license] for the official [Copyright Notice][📄copyright-notice-explainer].

[comment]: <> ( 📄 LEGAL LINKS )

[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.txt
[📄license-ref]: https://opensource.org/licenses/MIT
[📄license-img]: https://img.shields.io/badge/License-MIT-green.svg

## 🤑 One more thing

Having arrived at the bottom of the page, please endure a final supplication.
The primary maintainer of this gem, Peter Boling, wants
Ruby to be a great place for people to solve problems, big and small.
Please consider supporting his efforts via the giant yellow link below,
or one of smaller ones, depending on button size preference.

[![Buy me a latte][🖇buyme-img]][🖇buyme]

[![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

P.S. Use the gem => Discord for help

[![Live Chat on Discord][✉️discord-invite-img]][✉️discord-invite]

[⛳liberapay-img]: https://img.shields.io/liberapay/goal/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://img.shields.io/badge/polar-donate-yellow.svg
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/a_more_different_coffee-✓-yellow.svg
[🖇kofi]: https://ko-fi.com/O5O86SNP4
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-yellow.svg
[🖇patreon]: https://patreon.com/galtzo
[🖇buyme-small-img]: https://img.shields.io/badge/buy_me_a_coffee-✓-yellow.svg?style=flat
[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
[✉️discord-invite]: https://discord.gg/3qme4XHNKN
[✉️discord-invite-img]: https://img.shields.io/discord/1373797679469170758?style=for-the-badge
