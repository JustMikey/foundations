# UpservFoundations

## Installation & Updating
Installation assumes rails 7 with hotwire / stimulus, importmaps and tailwind
 
Gemfile (replace X.X.X with latest version)
```
# A bunch of shared / default code
gem 'upserv_foundations', ref: 'vX.X.X', git: 'https://github.com/upserv-io/foundations'

# icons
gem 'font-awesome-sass', '~> 6.4.0'
```
install: `$ bundle`

update app/assets/stylesheets/application.scss

```
/*   
 * Priority is lowest (first) to highest (last)
 * priority basically goes like this: defaults (lowest priority) >> components >> utilities (highest priority)
 * within each group, it goes like this: Tailwind (lowest priority), Upserv Foundations, Local (highest priority)
 * also we link the lib files (but we do not require them). See mapp/assets/config/manifest.js
 *
 * = require upserv_foundations/defaults
 * = require_tree ./defaults
 * = require upserv_foundations/components
 * = require_tree ./components
 * NOTE: builds is basically tailwind which is basically utilities
 * = require_tree ../builds
 * = require upserv_foundations/utilities
 * = require_tree ./utilities
 * NOTE: Controller action template stylesheets (added automatically -
 *   see app/views/layouts/application.html.erb for implementation)
 * manually added css (from lib directory) take highest priority and are added in
 *   actual view files with <%= add_stylesheet ... %> method
 */
```

create app/assets/stylesheets/defaults/imports.scss (or add to it if it already exists)
```
@import "font-awesome";
```
generate js files (do this every time you update the app) 
```
$ rails g upserv_foundations:javascript
```
Accept confilicts (select 'Y') if there any. The generated files should always take precedence
## Updates
1. Make updates (see below for specific instructions for various file types)
2. update version in lib/upserv_foundations/version.rb: `VERSION = "X.X.X"` (or `VERSION = "X.X.X.X"` for test versions) 
3. commit / push changes as usual
4. create new tag (note the "v"): `$ git tag vX.X.X` (or `X.X.X.X` for test versiosn)
5. push to new tag (note the "v"): `$ git push origin vX.X.X` (or `X.X.X.X` for test versiosn)
6. update versions in apps using this gem: `gem 'upserv_foundations', ref: 'vX.X.X', git: 'https://github.com/upserv-io/foundations'`
7. install update: `$ bundle`

### File Structure
- asset: vendor/assets
- channels: lib/upserv_foundations/channels
- controller: lib/upserv_foundations/controllers
- helpers: lib/upserv_foundations/helpers
- javascript - lib/upserv_foundations/javascript
  - looks like you cannot add js at this point because your hack doesn't work on production...
- jobs: lib/upserv_foundations/jobs
- mailers: lib/upserv_foundations/mailers
- models: lib/upserv_foundations/models
- views - don't add views. Use helpers and content_tag if you want to make component esc things

### Ruby Classes
Namespace all ruby classes under UpservFoundations
- ex. bad:  lib/upserv_foundations/controllers/example_controller.rb -> ExampleController
- ex. good:  lib/upserv_foundations/controllers/example_controller.rb -> UpservFoundations::ExampleController
use same convention for helpers, jobs, mailers, models, etc. (all ruby classes)

#### Helpers
1. create helper file 
1. require file in lib/upserv_foundations.rb
1. include helper class in lib/upserv_foundations.rb
1. create css file if it's a component (1 css file per helper file)

#### Other Ruby Classes / Autoloading
...??? idk

check out cancancan and devise as examples

### CSS
- Components: create one scss file per helper file for components
- After creating css file, add import statment in: `vendor/assets/stylesheets/upserv_foundations.scss`
- You cannot use tailwind classes because tailwind only includes classes as they are used withing your rails app. So if your rails app never uses the tailwind class "hidden" for example, but this gem does use the tailwind css class "hidden", then the "hidden" class here will have no effect because tailwind never added it in the rails app.

### JS
1. Add js template to `lib/generators/upserv_foundations/templates/` with standard DO NOT EDIT disclaimer: `// DO NOT EDIT THIS FILE. This file is autogenerated by Upserv Foundations.`
1. In `lib/generators/upserv_foundations/javascript_generator.rb`, update `copy_js_files` method to include new js template 

NOTE: I tried to get JS to autoload from the gem but I couldnt not figure it out. Generators work great though so using that for now. Here are some noes from failing miserably to autoload:
- I think what's happening is that there are 3 ways js files get loaded (depending on how you set up application.html.erb but assuming the standard way).
  - stimulus controllers - stimulus checks all files in app/javascript/controllers and adds those files.
  - global - application.html.erb adds these files
  - lib - these are added with javascript_include_tag as needed
- in all 3 scenarios analogous files in this gem (in lib/upserv_foundations/javascript/) get added to the rails project. However, if there is not a file in the actual rails project, then the 3 above don't know to actually include the js
- so you have to make a stub file with no real contents (just a single comment, ex `// placeholder`) and then it works
- also... stimulus expects there to be a controller file in your rails app for every stimulus controller so I think even if you load a controller class from this gem, stimulus will complain about there not being a file. Looks like this:
```
function loadController(name, under, application) {
  if (!(name in registeredControllers)) {
    import(controllerFilename(name, under))
      .then(module => registerController(name, module, application))
      .catch(error => console.error(`Failed to autoload controller: ${name}`, error))
  }
}
```
- so frustrating but I couldn't figure it out.
  

## Usage

Many files are simply additions to other manifest files (ex. additions to applicaiton controller)

Other items (ex. view components) are best accessed via VIM mappings

update page_max_width by adding this to your application helper:
```
def page_max_width_default
  # insert valid css width value, ex: '100%' or '1200px', etc.
end
```

# TODO / WIP

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/upserv_foundations. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/upserv_foundations/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UpservFoundations project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/upserv_foundations/blob/master/CODE_OF_CONDUCT.md).
