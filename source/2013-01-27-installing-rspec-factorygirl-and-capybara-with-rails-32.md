---

layout: post
title: "Installing RSpec, FactoryGirl and Capybara with Rails 3.2"
description: "Instructions to install RSpec, FactoryGirl and Capybara as the default testing mechanism in Rails 3"

---

### Generating a new Rails app without Test::Unit

Let's get started. Begin by starting a new Rails project in the directory of your choice.

    rails new my_app -T

This will generate a new app without the `Test::Unit` directories as usually would accompany a new Rails project

### The Gemfile

The first step to installing Rspec with Rails is to have a look at the [documentation](https://github.com/rspec/rspec-rails), which states you install it in both the test and development group.

In your Gemfile, put the following to install [rspec-rails](https://github.com/rspec/rspec-rails), [Capybara](https://github.com/jnicklas/capybara), and [FactoryGirl](https://github.com/thoughtbot/factory_girl).

<script src="https://gist.github.com/4650812.js"></script>

To install these gems, run:

    bundle

### Install RSpec

To install `rspec-rails` and tell Rails to use RSpec as the default testing framework instead of `Test::Unit`, run:

    rails generate rspec:install

### Configure the generators

In `config/application.rb`, add the following code between the ellipses (surrounding code provided for context)

<script src="https://gist.github.com/4650819.js"></script>

This will ensure that when you run the Rails generators, (such as `rails g controller home`) the appropriate spec files will be generated as well.

### Using Capybara

To use Capybara in your feature specs, all you need to do is require it from `spec/spec_helper.rb` (see line 5):

<script src="https://gist.github.com/4650825.js"></script>

As of Capybara 2.0, there is no configuration necessary to get access to the Capybara DSL (visit/page), given they are placed in the right location. See [this page](http://rubydoc.info/gems/rspec-rails/file/Capybara.md#Upgrading_to_Capybara-2_0) for (slightly) more information. When you generate new feature tests, place them in `spec/features` to use Capybara DSL. Simple enough.

### FactoryGirl Definitions

In addition to requiring Capybara, you will want to add an additional line to `spec/spec_helper.rb`:

<script src="https://gist.github.com/4651845.js"></script>

This ensures that the factories in `spec/factories` will be detected correctly and you can begin to use them without any further configuration.
