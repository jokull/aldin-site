This site is built to be statically output and deployable. It is localized for 
English and Icelandic. 

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