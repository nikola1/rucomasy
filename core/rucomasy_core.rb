# Add rucomasy core to the load path
libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

# compilers
require 'compilers/compiler'
require 'compilers/basic_native_compiler'
require 'compilers/cpp_compiler'

# executors
require 'executors/runnable'
require 'executors/runner'

# checkers
require 'checkers/checker'
require 'checkers/simple_io_checker'

# graders
require 'graders/grader'
require 'graders/simple_grader'

# tasks
require 'tasks/expr'
require 'tasks/rule'
require 'tasks/rule_parser'
require 'tasks/task'

require 'tasks/basic_rule'
require 'tasks/basic_rule_parser'
require 'tasks/basic_task'

require 'tasks/simple_io_testcase'
