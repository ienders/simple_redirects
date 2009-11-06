class RedirectGenerator < Rails::Generator::Base
  
  MAX_FILENAME_LENGTH = 230
    
  def initialize(runtime_args, runtime_options={})
    super
    @redirects = []
    runtime_args.each_slice(2) do |arg_set|
      if arg_set.length != 2
        raise Exception.new("Must have an even number of parameters.")
      end
      @redirects << { :from => arg_set[0], :to => arg_set[1] }
    end
  end
  
  def manifest
    record do |m|
      m.migration_template 'redirect_migration.erb', 'db/migrate', {
        :migration_file_name => build_migration_name,
        :assigns => {
          :class_name => build_migration_name.camelcase,
          :redirects  => @redirects
        }
      }
    end
  end

  protected
  def build_migration_name
    returning descriptive_migration_name do |name|
      name.replace short_migration_name if name.length > MAX_FILENAME_LENGTH
    end
  end

  def descriptive_migration_name
    'create_' + @redirects.first[:from].gsub(/[^a-zA-Z0-9_]/, '').downcase + '_redirect'
  end

  def short_migration_name
    'create_new_redirections'
  end
    
end