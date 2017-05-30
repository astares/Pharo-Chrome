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

## Installing

Depending on your OS, you will need to install one of the OS<Platform> packages:

* OSLinuxCentOS
* OSLinuxUbuntu
* OSOSX
* OSRaspbian
* OSUnix
* OSWindows

E.g.:

```smalltalk
Metacello new
	configuration: 'OSLinuxUbuntu';
	repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo60/main/';
	load.
```

then the main Pharo-Chrome package:

```smalltalk
Metacello new
	baseline: 'Chrome';
	repository: 'github://akgrant43/Pharo-Chrome:master/repository';
	load.
```

To keep the original Monticello idea of having #stable and #development versions, Pharo-Chrome is mostly using the GitFlow workflow:

* The `master` branch is #stable
* The `development` branch is #development

