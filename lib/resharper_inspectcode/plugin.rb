# frozen_string_literal: true

require_relative "report_parser"

module Danger
  # This is your plugin class. Any attributes or methods you expose here will
  # be available from within your Dangerfile.
  #
  # To be published on the Danger plugins site, you will need to have
  # the public interface documented. Danger uses [YARD](http://yardoc.org/)
  # for generating documentation from your plugin source, and you can verify
  # by running `danger plugins lint` or `bundle exec rake spec`.
  #
  # You should replace these comments with a public description of your library.
  #
  # @example Ensure people are well warned about merging on Mondays
  #
  #          my_plugin.warn_on_mondays
  #
  # @see  tumugin/danger-resharper_inspectcode
  # @tags monday, weekends, time, rattata
  # s
  class DangerResharperInspectcode < Plugin
    # Base path of report file
    #
    # @return   [String]
    attr_accessor :base_path

    # Report warnings
    # @param file [String] File path of ReSharper InspectCode report file
    def report(file)
      raise "Please specify file name." if file.empty?
      raise "No report file was found at #{file}" if File.exist?(file)

      filepath = @base_path + (@base_path.end_with?("/") ? "" : "/") + file
      issues = ReportParser.parse_report_xml(filepath)
      issues.each do |issue|
        warn(issue.message, file: issue.file, line: issue.line)
      end
    end
  end
end
