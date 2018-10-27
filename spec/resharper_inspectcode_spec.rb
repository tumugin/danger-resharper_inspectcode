# frozen_string_literal: true

require File.expand_path("spec_helper", __dir__)

module Danger
  describe Danger::DangerResharperInspectcode do
    it "should be a plugin" do
      expect(Danger::DangerResharperInspectcode.new(nil)).to be_a Danger::Plugin
    end

    describe "Report Parser Test" do
      before do
        require_relative "../lib/resharper_inspectcode/report_parser"
      end

      it "Parse report.xml" do
        report = ReportParser.parse_report_xml("spec/fixtures/report.xml")
        expect(report.first).to(
          eq Issue.new("MatsuriHime/Ho.cs", "14-47", 2, "Matsuri Hime is very cute.")
        )
        expect(report.select { |item| item.file == "Tsumugi/Nanyaine.cs" }.first).to(
          eq Issue.new("Tsumugi/Nanyaine.cs", "18-47", 1, "Nanyaine, is this!?")
        )
      end
    end

    describe "with Dangerfile" do
      before do
        @dangerfile = testing_dangerfile
        @my_plugin = @dangerfile.resharper_inspectcode
      end

      it "Parse XML report file with plugin" do
        @my_plugin.base_path = __dir__
        @my_plugin.report("fixtures/report.xml")
        expect(@my_plugin.violation_report[:warnings][0]).to(
          eq Violation.new("Matsuri Hime is very cute.", false, "MatsuriHime/Ho.cs", 2)
        )
        expect(@my_plugin.violation_report[:warnings][2]).to(
          eq Violation.new("Nanyaine, is this!?", false, "Tsumugi/Nanyaine.cs", 1)
        )
      end
    end
  end
end
