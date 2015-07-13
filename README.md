# A guide to using BOSH

This is source for BOSH guide - http://mariash.github.io/learn-bosh.

All section files are in `sections` folder.

This guide is using [fullPage.js](https://github.com/alvarotrigo/fullPage.js) because it is fancy.

To add new section:

* add new section HTML file to sections.
* add section to [sections.json](sections.json)
  The first key is the group of sections - used in CSS for styling. Next key is section anchor that will apear during scrolling. And value is section Title that apears in right navigation.

This guide consists of one static page. To regenerate page:

```
./generate.rb
```

Result is `index.html`.

When constantly updating, the following command will watch files for updates to re-generate new page:

```
fswatch -o sections -o css/* -o templates/*| xargs -n1 ./generate.rb
```

Don't forget to merge to `gh-pages` branch to update github pages.

Helpers available in sections:

* `circled_title(number, title)` - generates HTML with circled number and title.