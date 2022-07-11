Custom template for this IG.

Note that `includes/fragment-pagebegin.html` is copied verbatim from this file in `ig-template-base` to remove the inline styles around the IG name at the top of the page.

Documentation:

- [HL7/FHIR IG templates documentation](http://build.fhir.org/ig/FHIR/ig-guidance/branches/master/index.html)

## Building [ninja-keys](https://github.com/ssleptsov/ninja-keys) for distribution

```sh
git clone git@github.com:ssleptsov/ninja-keys.git
cd ninja-keys
npm install
npm run bundle
```

Then copy the contents of `dist/ninja-keys.bundled.js` to `custom-template/includes/_append.fragment-css.html` after removing the final line of `export { fi as NinjaKeys };`.

(Note that the CI build server won't allow `.js` files in an "untrusted" custom template -- see https://chat.fhir.org/#narrow/stream/179252-IG-creation/topic/.2Ejs.20file.20in.20custom.20template.)