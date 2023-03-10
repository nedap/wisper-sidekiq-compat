# Wisper::Sidekiq

Provides [Wisper-Compat](https://github.com/nedap/wisper-compat) with asynchronous event
publishing using [Sidekiq](https://github.com/mperham/sidekiq).

[![Gem Version](https://badge.fury.io/rb/wisper-sidekiq-compat.png)](http://badge.fury.io/rb/wisper-sidekiq-compat)

## Installation

```ruby
gem 'wisper-sidekiq-compat'
```

## Usage

```ruby
publisher.subscribe(MyListener, async: true)
```

The listener must be a class (or module), not an object. This is because Sidekiq
can not reconstruct the state of an object. However a class is easily reconstructed.

Additionally, you should also ensure that your methods used to handle events under `MyListener` are all declared as class methods:

```ruby
class MyListener
  def self.event_name
  end
end
```

When publishing events the arguments must be simple as they need to be
serialized. For example instead of sending an `ActiveRecord` model as an argument
use its id instead.

See the [Sidekiq best practices](https://github.com/mperham/sidekiq/wiki/Best-Practices)
for more information.

### Passing down sidekiq options

In order to define custom [sidekiq_options](https://github.com/mperham/sidekiq/wiki/Advanced-Options#workers) you can add `sidekiq_options` class method in your subscriber definition - those options will be passed to Sidekiq's `set` method just before scheduling the asynchronous worker.

### Passing down schedule options

In order be able to schedule jobs to be run in the future following [Scheduled Jobs](https://github.com/mperham/sidekiq/wiki/Scheduled-Jobs) you can add `sidekiq_schedule_options` class method in your subscriber definition - those options will be passed to Sidekiq's `perform_in` method when the worker is called.

This feature is not as powerful as Sidekiq's API that allows you to set this on every job enqueue, in this case you're able to set this for the hole listener class like:
```ruby
class MyListener
  #...

  def self.sidekiq_schedule_options
    { perform_in: 5 }
  end

  #...
end
```
Or you can set this per event (method called on the listener), like so:
```ruby
class MyListener
  #...

  def self.sidekiq_schedule_options
    { event_name: { perform_in: 5 } }
  end

  def self.event_name
    #...
  end

  #...
end
```
In both cases there is also available the `perform_at` option.

## Running Specs

Redis needs to be running. If you don't have an instance of redis on your machine, you can use the provided `docker-compose.yml`:

```
docker compose up -d
```

You also need to be running sidekiq via `scripts/sidekiq`:

```
scripts/sidekiq
```

Finally:

```
bundle exec rspec
```
