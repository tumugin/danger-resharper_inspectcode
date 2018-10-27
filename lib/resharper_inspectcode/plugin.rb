# frozen_string_literal: true

require_relative "report_parser"

module Danger
  # Danger plugin for JetBrains ReSharper InspectCode.
  # @example Parse the report XML file and do reporting
  #          resharper_inspectcode.base_path = Dir.pwd
  #          resharper_inspectcode.report 'report.xml'
  # @see tumugin/danger-resharper_inspectcode
  # @tags C#, InspectCode, lint
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
