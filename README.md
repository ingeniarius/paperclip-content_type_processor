# Paperclip::ContentTypeProcessor

Allows to add file processing by content type for paperclip attachments.

## Requirements

    libmagic

## Installation

Add this line to your application's Gemfile:

    gem 'paperclip-content_type_processor'

And then execute:

    $ bundle

Or install it by yourself as:

    $ gem install paperclip-content_type_processor

## Usage

1. Specify file processing per content type: 

````ruby
Paperclip::ContentTypeProcessor.add_content_type_processor("content/type", "command", "command arguments")
````

2. Add content type processor for attachment:

````ruby
has_attached_file :avatar,
    styles: { medium: '96x96#' },
    processors: [:thumbnail, :content_type_processor]
end
````

## Example

It can be used for image compression/optimizations.

1. Install image optimizers: 
    * jpegoptim (http://freecode.com/projects/jpegoptim)
    * optipng (http://optipng.sourceforge.net/)

2. Add initializer in your rails app <code>config/initializers/content_type_processor.rb</code>, 
and specify file processing per content type:

````ruby
Paperclip::ContentTypeProcessor.add_content_type_processor("image/jpeg", "jpegoptim", "--strip-all --max=90")
Paperclip::ContentTypeProcessor.add_content_type_processor("image/png", "optipng", "-o6 -strip all")
````

3. Enable content type processing for user avatars:

````ruby
class User < ActiveRecord::Base
  has_attached_file :avatar,
    styles: { medium: '96x96#' },
    processors: [:thumbnail, :content_type_processor]
end
````

So all user avatars will be processed by 'jpegoptim' or 'optipng' according to its content type.

*Note! If you want to generate thumbnails, you should also specify :thumbnails in processor list*


## Contributing

1. Fork it ( http://github.com/ingeniarius/paperclip-content_type_processor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
