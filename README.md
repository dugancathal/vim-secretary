# Vim::Secretary

I use vim a lot, let me say _a lot_. This helps me keep track of how I use my
time through a simple web interface using just vim on my side, and providing a
nice clean web GUI for my manager to know what I'm doing.

Note: I've written this ahead of time. Consider the README as a kind of BDD
until further notice is given. Feel free to hit me up if you want to help out,
though.

## Installation

Install:

    $ gem install vim-secretary

## Usage

I have this mapped to a simple leader command. When I need to put something in
to my "time sheet", I just type '<Leader>ts', and put something in the sheet. I
keep the web GUI running at all times and just give out the link when my manager
asks for it. There's even a simple Rake task to generate the URL if I don't feel
like 'ifconfig'-ing.

## A word on vocabulary

A _timesheet_ refers to the actual .secretary file that you maintain. My
standard is one of these files per project.

A _secretary database_ is the DB that stores the aggregated _timesheets_. I have
two of these, one for at work (~/.secretary-work.db), and one for personal
projects (~/.secretary-personal.db).

The _location_ specified by a __timesheet__ is the root directory that it's
content will be placed in (largely for SQLite, if you use something else, this
option is basically useless)

## Contributing

Please, let me know what you think, how you're using it, etc.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
