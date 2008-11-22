class MyControllerGenerator < Rails::Generator::NamedBase
  
  attr_reader :controller_name,
              :controller_class_path,
              :controller_file_path,
              :controller_class_nesting,
              :controller_class_nesting_depth,
              :controller_class_name,
              :controller_singular_name,
              :controller_plural_name,
              :model_columns,
              :full_model_columns
                
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
      m.directory(File.join('app/views', controller_class_path, controller_file_name))
      
      m.directory(File.join('spec/controllers', controller_class_path))
      m.directory(File.join('spec/helpers', controller_class_path))
      
      
      m.template "controller.rb", File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
      m.template "controller_spec.rb", File.join('spec/controllers', controller_class_path, "#{controller_file_name}_controller_spec.rb")
      
      m.template "helper.rb", File.join('app/helpers', controller_class_path, "#{controller_file_name}_helper.rb")
      m.template "helper_spec.rb", File.join('spec/helpers', controller_class_path, "#{controller_file_name}_helper_spec.rb")
      
      if options[:include_views]
        @model_columns = class_name.constantize.column_names - %w(id created_at updated_at)
        @full_model_columns = class_name.constantize.columns.select { |c| !%w(id created_at updated_at).include?(c.name) }
        m.directory(File.join('spec/views', controller_class_path, controller_file_name))
        
        %w(index new edit show _form).each do |view|
          m.template("#{view}.html.erb", File.join('app/views', controller_class_path, controller_file_name, "#{view}.html.erb"))
          m.template("#{view}.html.erb_spec.rb", File.join('spec/views', controller_class_path, controller_file_name, "#{view}.html.erb_spec.rb"))
        end
      end
        
      m.route_resources controller_file_name
    end
  end
    
  protected
    # Override with your own usage banner.
    def banner
      "Usage: #{$0} my_controller controller"
    end
    
    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--include-views", "Generates the views for the CRUD controller") { |v| options[:include_views] = v }
    end
    
    def helper_for_column(column)
      case column.type
      when :integer, :string, :float, :decimal
        "f.text_field :#{column.name}"
      when :datetime, :date, :timestamp, :time
        "f.datetime_select :#{column.name}"
      when :text
        "f.text_area :#{column.name}"
      when :boolean
        "f.check_box :#{column.name}"
      else
        raise "unknown type #{column.type}"
      end
    end
    
    def spec_matcher_for_column(column)
      case column.type
      when :integer, :string, :float, :decimal
        "\"input[type=text][name=?][value=?]\", \"#{file_name}[#{column.name}]\", \"the #{column.name}\""
      when :datetime, :date, :timestamp, :time
        "\"select[name=?]\", \"#{file_name}[#{column.name}]\""
      when :text
        "\"textarea[name=?][value=?]\", \"#{file_name}[#{column.name}]\", \"the #{column.name}\""
      when :boolean
        "\"input[type=checkbox][name=?]\", \"#{file_name}[#{column.name}]\""
      else
        raise "unknown type #{column.type}"
      end
    end
end