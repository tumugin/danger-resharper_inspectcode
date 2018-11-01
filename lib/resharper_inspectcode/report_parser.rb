# frozen_string_literal: true

require "oga"

Issue = Struct.new(:file, :offset, :line, :message)

class ReportParser
  def self.parse_report_xml(filepath)
    xml_file = File.open(filepath)
    document = Oga.parse_xml(xml_file)
    issues = []
    document.xpath("//Report/Issues/Project").each do |project|
      project.children.each do |issue|
        next unless issue.kind_of?(Oga::XML::Element)

        file = issue.get("File").tr("\\", "/")
        offset = issue.get("Offset")
        line = (issue.get("Line") || "1").to_i
        message = issue.get("Message")
        issues << Issue.new(file, offset, line, message)
      end
    end
    return issues
  end
end
