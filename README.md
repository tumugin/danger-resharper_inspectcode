# danger-resharper_inspectcode

Danger plugin for JetBrains ReSharper InspectCode.

## Installation

    PS> gem install danger-resharper_inspectcode

## Usage
Before running Danger, you need to setup your CI service to run InspectCode Command-Line Tool to generate report XML file.
```
PS> /PATH/TO/TOOLS/InspectCode.exe YourSolution.sln; -o=report.xml
```

Set your report file path on `Dangerfile` like this.
```Ruby
resharper_inspectcode.base_path = Dir.pwd
resharper_inspectcode.report 'report.xml'
```

#### Attributes

`base_path` - Base path of report file

#### Methods

`report` - Report warnings

## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
