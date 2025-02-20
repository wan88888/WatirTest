# Web自动化测试框架

这是一个基于Watir和Cucumber的Web自动化测试框架，采用Page Object模式设计，支持BDD(行为驱动开发)测试方法。

## 项目概述

本框架主要特点：
- 使用Watir进行Web元素操作
- 采用Cucumber编写BDD场景测试
- 实现Page Object模式管理页面元素
- 支持生成美观的HTML测试报告
- 配置无头浏览器模式执行测试
- 失败场景自动截图

## 环境要求

- Ruby 2.5+
- Chrome浏览器
- ChromeDriver

## 依赖管理

项目使用以下主要gem包：
```ruby
gem 'cucumber'     # BDD测试框架
gem 'watir'        # Web自动化测试工具
gem 'page-object'  # Page Object模式支持
gem 'rspec'        # 测试断言库
gem 'webdrivers'   # 浏览器驱动管理
gem 'report_builder' # 测试报告生成
```

## 项目结构

```
├── features/                # 测试相关文件目录
│   ├── login.feature       # 测试场景描述文件
│   ├── pages/             # 页面对象目录
│   │   └── login_page.rb  # 登录页面对象
│   ├── step_definitions/  # 步骤定义目录
│   │   └── login_steps.rb # 登录步骤定义
│   └── support/          # 支持文件目录
│       └── env.rb        # 环境配置文件
├── reports/              # 测试报告目录
├── Gemfile              # 依赖配置文件
└── README.md            # 项目说明文档
```

## 页面对象示例

```ruby
class LoginPage
  include PageObject
  
  page_url 'http://the-internet.herokuapp.com/login'
  text_field(:username, id: 'username')
  text_field(:password, id: 'password')
  button(:login_button, css: 'button[type="submit"]')
  
  def login_with(username, password)
    self.username = username
    self.password = password
    login_button
  end
end
```

## 测试场景示例

```gherkin
Feature: 登录功能
  Scenario: 使用有效凭据成功登录
    Given 我在登录页面
    When 我输入用户名 "tomsmith"
    And 我输入密码 "SuperSecretPassword!"
    And 我点击登录按钮
    Then 我应该看到成功消息
```

## 运行测试

1. 安装依赖：
```bash
bundle install
```

2. 运行所有测试：
```bash
export CUCUMBER_PUBLISH_ENABLED=true
export CUCUMBER_PUBLISH_TOKEN=7f78e87b-53e0-4dfb-a9f5-42d376e5e839
bundle exec cucumber
```

3. 运行特定场景：
```bash
bundle exec cucumber features/login.feature
```

## 测试报告

### 本地HTML报告
- 测试执行后会在`reports`目录下生成HTML格式的测试报告
- 失败的测试场景会自动截图保存
- 报告包含测试执行时间、成功率等详细信息

### Cucumber Reports平台

#### 配置
1. 在`cucumber.yml`中添加报告配置：
```yaml
default: --format json --out reports/cucumber.json
```

2. 在CI/CD流水线中配置报告发布：
```yaml
- name: Publish Test Results
  uses: cucumber/publish-action@v1.1.0
  with:
    token: ${{ secrets.CUCUMBER_PUBLISH_TOKEN }}
    results: reports/cucumber.json
```

#### 使用说明
1. **查看报告**
   - 访问 [Cucumber Reports](https://reports.cucumber.io) 平台
   - 使用团队账号登录
   - 在项目面板中选择对应的报告集合

2. **报告管理**
   - 支持按时间、标签、执行环境等筛选报告
   - 提供趋势分析和统计图表
   - 可以为重要的报告添加标签和备注

3. **共享和协作**
   - 可以通过URL分享特定的报告
   - 支持添加评论和讨论
   - 可以导出报告数据

## 框架特性

1. **无头浏览器模式**
- 默认使用Chrome无头模式执行测试
- 可通过修改`env.rb`配置其他浏览器或模式

2. **自动化截图**
- 测试失败时自动保存截图
- 截图文件名包含时间戳便于追溯

3. **HTML报告**
- 使用ReportBuilder生成美观的HTML报告
- 支持失败场景截图展示
- 包含详细的测试执行数据

## 最佳实践

1. **Page Object模式**
- 每个页面创建独立的页面对象类
- 在页面类中封装元素定位和操作方法
- 使用语义化的方法名描述业务操作

2. **测试用例编写**
- 使用Gherkin语法编写场景
- 保持场景描述简洁明确
- 一个场景验证一个完整的业务流程

3. **步骤定义**
- 步骤定义要可重用
- 使用正则表达式支持参数化
- 保持步骤粒度适中

## 注意事项

1. 运行测试前确保：
- Chrome浏览器已安装
- 网络连接正常
- 依赖已完整安装

2. 测试执行：
- 建议使用无头模式执行
- 注意测试数据的独立性
- 及时清理测试生成的临时文件

## 常见问题

1. ChromeDriver版本不匹配
- 使用webdrivers gem自动管理驱动版本
- 确保Chrome浏览器版本兼容

2. 元素定位失败
- 检查元素定位器是否正确
- 考虑增加等待时间
- 确认页面是否完全加载

3. 测试报告生成失败
- 确保reports目录存在且有写入权限
- 检查cucumber.json文件是否正确生成

## 维护与更新

1. 定期更新依赖版本
2. 及时处理废弃的API调用
3. 持续优化测试用例结构
4. 保持文档的及时更新