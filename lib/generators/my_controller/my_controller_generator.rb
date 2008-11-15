class MyControllerGenerator < Rails::Generator::NamedBase
  
  attr_reader :controller_name,
              :controller_class_path,
              :controller_file_path,
              :controller_class_nesting,
              :controller_class_nesting_depth,
              :controller_class_name,
              :controller_singular_name,
              :controller_plural_name
                
  alias_method :controller_file_name, :controller_singular_name
                
  def initialize(runtime_args, runtime_options = {})
    super
    
    @controller_name = @name.pluralize
    
    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    @controller_class_name_without_nesting, @controller_singular_name, @controller_plural_name = inflect_names(base_name)
    
    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end
  end
  
  def manifest
    record do |m|
      
      # Check for class naming collisions.
      m.class_collisions(controller_class_path, "#{controller_class_name}Controller", "#{controller_class_name}Helper")
      
      m.directory(File.join('app/controllers', controller_class_path))
      m.directory(File.join('app/helpers', controller_class_path))
      
      m.directory(File.join('spec/controllers', controller_class_path))
      m.directory(File.join('spec/helpers', class_path))
      
      
      m.template "controller.rb", File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
      m.template "controller_spec.rb", File.join('spec/controllers', controller_class_path, "#{controller_file_name}_controller_spec.rb")
      
      puts "LEGEND:\n"
      puts "table_name: #{table_name}"
      puts "file_name: #{file_name}"
      puts "class_name: #{class_name}"
      puts "controller_name: #{controller_name}"
      puts "controller_class_path: #{controller_class_path}"
      puts "controller_file_path: #{controller_file_path}"
      puts "controller_class_nesting: #{controller_class_nesting}"
      puts "controller_class_nesting_depth: #{controller_class_nesting_depth}"
      puts "controller_class_name: #{controller_class_name}"
      puts "controller_singular_name: #{controller_singular_name}"
      puts "controller_plural_name: #{controller_plural_name}"
        
      m.route_resources controller_file_name
    end
  end
    
  protected
    # Override with your own usage banner.
    def banner
      "Usage: #{$0} my_controller controller"
    end
end