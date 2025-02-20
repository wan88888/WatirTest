require 'watir'
require 'page-object'
require 'page-object/page_factory'
require 'report_builder'

World(PageObject::PageFactory)

Before do |scenario|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  @browser = Watir::Browser.new :chrome, options: options
  @browser.window.maximize
  @start_time = Time.now
end

After do |scenario|
  if scenario.failed?
    time = Time.now.strftime('%Y%m%d%H%M%S')
    @browser.screenshot.save("screenshot_#{time}.png")
  end
  @browser.close
end

at_exit do
  config = ReportBuilder.configure do |config|
    config.input_path = 'reports/cucumber.json'
    config.report_path = 'reports/cucumber_report'
    config.report_types = [:html, :json]
    config.report_title = 'Web Automation Test Results'
    config.include_images = true
    config.additional_info = { 'Project' => 'Web Automation Test' }
    config.publish_enabled = true
    config.color = 'brown'
  end
  report_info = ReportBuilder.build_report
end