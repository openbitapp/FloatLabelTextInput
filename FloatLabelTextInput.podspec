#
# Be sure to run `pod lib lint FloatLabelTextInput.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FloatLabelTextInput'
  s.version          = '1.1'
  s.summary          = 'An Eureka row that shows a float label, using expandable text view or standard text field. Inspired by FloatLabelRow'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/openbitapp/FloatLabelTextInput'

  s.license          = { :type => 'Apache License 2.0', :file => 'LICENSE' }
  s.author           = { 'Roberto Casula @ bitapp' => 'roberto.casula@bitapp.it' }
  s.source           = { :git => 'https://github.com/openbitapp/FloatLabelTextInput.git', :tag => s.version.to_s }

  s.swift_version = '4.2'
  s.ios.deployment_target = '10.0'

  s.source_files = 'FloatLabelTextInput/Classes/**/*'

  s.dependency 'Eureka', '~> 5.0'
end
