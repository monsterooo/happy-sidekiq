# happy-sidekiq

## 安装 sidekiq

1. 安装依赖到项目中

`bundle add sidekiq`

2. 运行命令行生成一个 job

`rails g sidekiq:job hard`

它会在 `app/sidekiq` 目录下生成 `hard_job.rb` 文件

```ruby
class HardJob
  include Sidekiq::Job

  def perform(name, count)
    # do something
  end
end
```

## 启动 sidekiq 服务

在项目根路径下使用控制台执行 `sidekiq` 让程序启动准备执行异步作业

## 配置 rails 以使用 sidekiq

编辑文件 `config/application.rb` 添加如下配置项

```ruby
module SidekiqBasic
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
  end
end
```

## 创建作业

* 创建异步作业

`HardJob.perform_async(Time.now)`

这会创建一个异步立刻执行的作业

* 创建异步稍后执行作业

`HardJob.perform_at(1.day.from_now) # 1天后执行` 

这会创建一个在一天后执行的作业

## 创建异步作业的方式

要创建异步作业有如下两种方式

```ruby
MyWorker.perform_async(1, 2, 3)
Sidekiq::Client.push('class' => MyWorker, 'args' => [1, 2, 3])  # 低级通用的 api
```

上面两种方式都是一样的，创建作业的参数会序列化为JSON字符串，所以参数必须是简单的JSON数据类型(数字、字符串、布尔值、数字、哈希)。复杂的Ruby对象比如AR模型将无法正确序列化
。

这些数据都存放在 redis `schedule` 中，`value` 数据结构为 `{"retry":true,"queue":"default","class":"HardJob","args":[],"jid":"5ee11c48813959c15f3f7e21","created_at":1652356961.715998}`







