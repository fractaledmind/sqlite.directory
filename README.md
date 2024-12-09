# sqlite.directory

`sqlite.directory` is a directory of web applications that use the SQLite database engine in some meaningful capacity in production.

Made by [@fractaledmind](https://twitter.com/fractaledmind) and [friends](https://github.com/fractaledmind/sqlite.directory/graphs/contributors)!

## Codebase

The codebase is vanilla [Rails](https://rubyonrails.org/), [Puma](http://puma.io/), and—of course—[SQLite](https://sqlite.org/). Basically the simplest possible setup.

## Development

You will need Ruby `3.3.6` installed to run this application. Once installed, run `bin/setup` to install dependencies and prepare the database(s). This is a simple app with no additional system dependencies.

You can then run the rails web server:
```shell
bin/dev
```

And visit [http://localhost:3000](http://localhost:3000/)

To run the test suite, run the standard `bin/rails test` command. In addition, you should run `bin/rubocop` to check for lint issues.

## Contributing

It's still very early days for this so your mileage will vary here and lots of things will break.

But almost any contribution will be beneficial at this point. Check the [current Issues](https://github.com/fractaledmind/sqlite.directory/issues) to see where you can jump in!

If you've got an improvement, just send in a pull request!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

If you've got feature ideas, simply [open a new issues](https://github.com/fractaledmind/sqlite.directory/issues/new)!

## License & Copyright

Released under the MIT license, see the [LICENSE](https://github.com/fractaledmind/sqlite.directory/blob/main/LICENSE) file. Copyright (c) Sabotage Media LLC.