#
# startupdev-rails-template
#
# Usage:
#   rails new appname -m /path/to/template.rb
#
# Also see http://textmate.rubyforge.org/thor/Thor/Actions.html
#

%w{colored}.each do |component|
  if Gem::Specification.find_all_by_name(component).empty?
    run "gem install #{component}"
    Gem.refresh
    Gem::Specification.find_by_name(component).activate
  end
end

require "rails"
require "colored"
require "bundler"

# Directories for template partials and static files
@template_root = File.expand_path(File.join(File.dirname(__FILE__)))
@partials     = File.join(@template_root, 'partials')
@static_files = File.join(@template_root, 'files')

# Copy a static file from the template into the new application
def copy_static_file(path)
  # puts "Installing #{path}...".magenta
  remove_file path
  file path, File.read(File.join(@static_files, path))
  # puts "\n"
end

def apply_n(partial)
  apply "#{@partials}/_#{partial}.rb"
end

puts "\n========================================================="
puts " STARTUPDEV RAILS 3 TEMPLATE".yellow.bold
puts "=========================================================\n"

# TODO: timezone, Add rspec extensions

apply_n :git
apply_n :cleanup
apply_n :database   # TODO: create default database, run db:migrate and add schema.rb
apply_n :rspec      # TODO: rspec nao rolou no projeto POL, add simplecov.
apply_n :default    # TODO: add p80, colocar default do fakeweb sem conexao
apply_n :generators
apply_n :gems
apply_n :rvm
apply_n :offbundle
apply_n :onbundle
apply_n :finish
# apply_n :omniauth # TODO: add spec support files
                    # TODO: take care of facebook when user is not logged in on facebook (when app)
# TODO: extrair phone validator to gem
# TODO: colocar .DS_store no gitignore.

puts "\n========================================================="
puts " INSTALLATION COMPLETE!".yellow.bold
puts "=========================================================\n\n\n"
