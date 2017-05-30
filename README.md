# Pharo-Chrome

Pharo-Chrome provides a simple API for Google Chrome's DevTools protocol (https://chromedevtools.github.io/devtools-protocol/).

The are three main public classes in the package:

* GoogleChrome is the interface to the Chrome Browser
* ChromeTabPage is the interface to a single tab / page in the browser
* ChromeNode is a single DOM node within a page, with a similar interface to Soup

A ZnEasy like interface is provided for retrieving pages:

```smalltalk
GoogleChrome get: 'http://pharo.org'
```

An example of more detailed operations are available in `GoogleChrome class>>exampleNavigation`.

