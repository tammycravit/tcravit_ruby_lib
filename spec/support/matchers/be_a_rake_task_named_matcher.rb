############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : be_a_rake_task_named_matcher.rb
# Description : RSpec custom matcher to ensure the subject is a Rake task
#
# This matcher tests the following aspects of the supplied subject:
#
# - it is of type Rake::Taskj
# - it responds to the :name method
# - its name matches the expected  value
#
# If the matcher fails, it returns a list of which test conditions were not
# successful.
############################################################################
#  Copyright 2011-2018, Tammy Cravit.
# 
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
############################################################################

require 'rspec/expectations'
require File.join(File.dirname(__FILE__), "matcher_helpers.rb")

RSpec::Matchers.define :be_a_rake_task_named do |expected|
  match do |actual|
    @errors = []
    @errors.push("expected a Rake task, but got a \"#{actual.class.name}\" instead") unless (actual.class.name == "Rake::Task")
    begin
      @errors.push("expected the task to be named \"#{expected}\", but got name \"#{actual.name}\" instead") unless (actual.name == expected)
    rescue
      @errors.push("expected the task to respond to \"name\"")
    end
    @errors.empty?
  end

  failure_message do |actual|
    @errors.join("\n")
  end
end
