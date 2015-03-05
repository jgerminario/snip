Snip 
====
*Your code, snipped*

Snip is an open source code snippet manager. With a simple command line interface, you can easily tag and save your code for future review.
<p align="center">
<img src="snip.gif" />
</p>

### New in release 0.0.9 (3/4/15)

Language support has been expanded to the following languages:
* JavaScript (existing)
* Ruby (existing)
* ERB (existing)
* HTML
* CSS
* Python
* PHP

Languages can be easily added through the lib/languages/languages.rb file. Submit an issue or pull request to have additional support added.

Search (with snip -s) is now smarter, with no case sensitivity and matching for individual words throughout the body of your snippet.

### New in release 0.0.8 (2/8/15)

Snip now includes a clipboard functionality. Copy the code you want to save to your clipboard, then run `snip -c`. You'll be asked to specify a language type and a title.

Snippet search has been added in 0.0.8. From the commandline, run `snip -a` to see all of your snippets. To see only a certain language (rb, js, erb), specify as follows `snip -s js`. To search within the content of the snippet (for example, for any content with 'angular' in it), `snip -s "angular"`.

Other miscellaneous functionality can be referenced with snip --help.

## How it works

Snip uses simple, easy-to-remember tags that you place inside your code during your normal workflow:
```ruby
# <$> Using a times loop
5 times do |x|
  puts x
end
 # </$>
```

At the end of the day, run `snip <filename/directory>` to update your snippet file with a single file or a whole directory of tagged files:

```ruby
# **** Snippet 1: Using a times loop ****
# Snipped from test.rb:4 on 12/08/2014
5 times do |x|
  puts x
end
```

The original file tags will be modified slightly with `<*$*>` tags so you can rerun `snip` on your directory without duplicating old files.

## Setup
*Installation:*
Snip requires Ruby and Ruby gems on your computer.

To install:
```
gem install snipgem
```

First time use:
```
snip -f ~/desktop/
```
where '~/desktop/' can be the name of any directory you would like to save your `my_snips` file to. Run `snip -f` again to re-set the directory if you move the location of the `my_snips` file.

Future use:
```
snip directory_name/
```
or
```
snip filename.rb
```

Send feedback or bug reports to jgerminario@gmail.com.



