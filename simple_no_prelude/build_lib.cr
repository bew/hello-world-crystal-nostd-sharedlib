require "option_parser"

record Config,
  files : Array(String),
  lib_name : String,
  prelude_file : String?,
  cr_build_args : Array(String)

def parse_args(args)
  lib_name = nil
  files = [] of String
  prelude_file = nil
  cr_build_args = [] of String

  OptionParser.parse args do |parser|
    parser.on "-h", "--help", description: "Show this help" { puts parser; exit }

    parser.on "-o OUTPUT_NAME", description: "Specify the lib name" do |output_name|
      lib_name = output_name
    end

    parser.on "--prelude FILE", description: "Use given file as prelude" do |file|
      prelude_file = file
    end

    parser.unknown_args do |before_dash, after_dash|
      before_dash.each do |file|
        files << file if File.file? file
      end

      cr_build_args.concat before_dash.reject { |arg| files.includes? arg }
      cr_build_args.concat after_dash
    end
  end

  if files.empty?
    raise "You must provide at least one file to compile"
  end

  unless lib_name
    first_filename = files.first
    basename_without_extension = File.basename first_filename, File.extname first_filename

    lib_name = basename_without_extension
  end

  Config.new files, lib_name.not_nil!, prelude_file, cr_build_args
end

def build_object_command(conf)
  cmd = %w(crystal build --cross-compile)
  cmd << "--prelude='#{conf.prelude_file}'" if conf.prelude_file
  cmd.concat conf.files

  cmd.concat conf.cr_build_args

  cmd.join ' '
end

def build_lib_command(conf, command_for_target)
  cmd = command_for_target.split ' '

  # Override the previous `-o` option
  cmd << "-o" << conf.lib_name + ".so"

  # Make a shared library
  cmd << "-shared"

  cmd.join ' '
end

begin
  config = parse_args ARGV
rescue ex
  puts ex
  exit 1
end

object_command = build_object_command config
recommended_link_command = `#{object_command}`

unless $?.normal_exit?
  puts "Error: Cannot generate object file."
  exit 1
end

lib_command = build_lib_command config, recommended_link_command.chomp
`#{lib_command}`

unless $?.normal_exit?
  puts "Error: Cannot generate shared library file."
  exit 1
end
