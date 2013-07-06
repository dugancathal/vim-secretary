# Vim::Secretary

I use vim a lot, let me say _a lot_. This helps me keep track of how I use my
time through a simple web interface using just vim on my side, and providing a
nice clean web GUI for my manager to know what I'm doing.

## Installation

Install:

    $ gem install vim-secretary

## Usage

I have this mapped to a simple leader command. When I need to put something in
to my "time sheet", I just type '<Leader>ts', and put something in the sheet. I
keep the web GUI running at all times and just give out the link when my manager
asks for it. There's even a simple Rake task to generate the URL if I don't feel
like 'ifconfig'-ing.

## Contributing

Please, let me know what you think, how you're using it, etc.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
