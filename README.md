# [RecordViewHelper](https://github.com/Narazaka/record_view_helper)

[![Gem](https://img.shields.io/gem/v/record_view_helper.svg)](https://rubygems.org/gems/record_view_helper)
[![Gem](https://img.shields.io/gem/dtv/record_view_helper.svg)](https://rubygems.org/gems/record_view_helper)
[![Inch CI](http://inch-ci.org/github/Narazaka/record_view_helper.svg)](http://inch-ci.org/github/Narazaka/record_view_helper)
[![Ruby](https://github.com/Narazaka/record_view_helper/workflows/Ruby/badge.svg)](https://github.com/Narazaka/record_view_helper/actions?query=workflow:Ruby)

table builder and description list (dl) helper for Rails / ActiveModels

## Usage

```slim
/ on Rails
/ foo.html.slim

= table_for(@bars) do |s|
  - s.only :id, :name, :kind, :foo_id
  - s.link :id, :bar_path
  - s.link :foo_id, :foo_path
  - s.format :foo_id, [:foo_id, [:foo, :name]]
  - s.format :kind do |record|
    = Foo::KIND[record.kind]

= dl_for(@foo, except: [:created_at, :updated_at])
```

see [API Documents](http://www.rubydoc.info/gems/record_view_helper) for details

## Installation
Add this line to your application's Gemfile:

```ruby
gem "record_view_helper"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install record_view_helper
```

## See also

- [table-for](https://github.com/hunterae/table-for)

## License
The gem is available as open source under the terms of the [Zlib License](LICENSE).
