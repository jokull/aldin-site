This site is built to be statically output and deployable. It is localized for
English and Icelandic.

Instead of using a web framework to serve the site I wanted to use only Brunch,
which is a great front end assembler that allows you to code in Stylus,
CoffeeScript, configure the joining of files, compression etc. I'm used to
coding sites in Flask however, and block based templating and localization of
content with gettext was missing. To get the best of both worlds I treat the
asset directory in Brunch as a template folder, and create a site tree for each
language. For this I created jinjet; a command line utility that I hope you find
useful.

Quickstart
==========

## 1. Bootstrap Brunch

    git clone git@github.com/jokull/aldin.git && cd aldin
    mkdir node_modules
    npm install
    brunch watch -s

Brunch should now have output the site in `public/`. We still need to compile 
each locale.

## 2. Install jinjet in a Python environment

    mkvirtualenv --distribute jinjet
    pip install git+git://github.com/jokull/jinjet.git

## 3. Compile localized site trees

    jinjet -vv

See [jinjet documentation](https://github.com/jokull/jinjet) for documentation
on updating and compiling translation catalogs, even adding more locales.

`/public` folder is deployable. You will want to configure the server to redirect from the root path `/` to `/<lang>/`, otherwise people will see a bunch of unrendered jinja templates.

This NGiNX config did the trick:

    server {
      listen 80;
      server_name aldin.is;
      rewrite ^(.*) http://www.aldin.is$1 permanent;
    }

    server {
      listen 80;
      server_name www.aldin.is;
      location =/ {
        rewrite ^ /is/ redirect;
      }
      location / {
        root /web/aldin;
        index index.html;
        expires -1d;
      }
    }

