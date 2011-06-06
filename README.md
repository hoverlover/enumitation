# Enumitation

<img src="http://upload.wikimedia.org/wikipedia/commons/c/c7/Kanikama.jpg" width="400" height="300"/>

## What is it?

**enum + imitation = Enumitation**

## Why?

Ever wanted to restrict an ActiveRecord attribute to specific values, but thought a
join table to contain the values and a foreign key constraint were overkill?  Well, you
could opt for an enum field, but maybe your DBMS doesn't support enums.  Or maybe it does,
but you just aren't in the mood for an enum field today.

Also, do you need to provide these values as options in a select form field?

Enumitation exists to allow restrictions on ActiveRecord attribute values without
the need for a join table or enum field, while also providing those values for
the purpose of options in a select field in a form.

## Example

    class Publisher < ActiveRecord::Base
      enumitation :location, %w[US CA]
    end

Here we've specified that we want the `location` attribute to be an enum
with the values *US* and *CA*.  The `enumitation` method does two
important things:

* it adds a `validates_inclusion_of` validation to the model, using the
  values specified when declaring the enumitation
* it provides a `select_options_for` method that can be used to provide
  a select tag with options

In the console:

    publisher = Publisher.new location: 'MX'
    publisher.valid?   #=> false
    publisher.errors   #=> {:location=>["is not included in the list"]}
    publisher.location = 'US'   #=> "US"
    publisher.valid?   #=> true

    Publisher.select_options_for :location   #=> [["US", "US"], ["CA", "CA"]]

## Custom Labels (i18n)

You can provide alternate labels for your values in your locale files.
These labels will be returned from the `select_options_for` method.

In *config/locales/en.yml*:

    en:
      enumitation:
        models:
          publisher:
            location:
              US: 'United States'
              CA: 'Canada'

Now when calling the `select_options_for` method:

    Publisher.select_options_for :location   #=> [["United States", "US"], ["Canada", "CA"]]

So, from your view:

    = form_for :publisher do |f|
      = f.select :location, Publisher.select_options_for(:location)

### But this is no big deal!

I know.  It really isn't that big of a deal, and it wouldn't take that
much effort to reproduce by hand what Enumitation provides.  But why do
all that work when you can get it from a one-liner?


### There are other gems that practically do the same thing.

True, but the ones I found either didn't fit my needs or they did so much more than I needed.
I wanted something that fit my needs exactly and nothing more.

## Testing

    bundle exec rspec spec

## Contributing

If you think Enumitation could be better, fork away and send a pull
request!  Please make sure to include specs for your changes.
