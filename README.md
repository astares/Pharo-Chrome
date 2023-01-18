# Pharo-Chrome

Pharo-Chrome provides a simple API for Google Chrome's DevTools protocol (https://chromedevtools.github.io/devtools-protocol/).

## Installation via Script

First load [OSSubprocess](https://github.com/pharo-contributions/OSSubprocess) or [Pharo-OS-Windows](https://github.com/astares/Pharo-OS-Windows) if you are on Windows 

```Smalltalk
Metacello new 
	repository: 'github://astares/Pharo-Chrome:main/src';
	baseline: 'Chrome';
	load
```


The are three main public classes in the package:

* GoogleChrome is the interface to the Chrome Browser
* ChromeTabPage is the interface to a single tab / page in the browser
* ChromeNode is a single DOM node within a page, with a similar interface to Soup

A ZnEasy like interface is provided for retrieving pages:

```smalltalk
GoogleChrome get: 'http://pharo.org'
```

An example of more detailed operations are available in `GoogleChrome class>>exampleNavigation`.

## Features

* A ZnEasy like feature for retrieving pages: #get:
* Extraction of tabular data (html tables): #extractTables, #tableData
* Screenshot capture: #captureScreenshot
* Headless mode

## Installation

Unix platforms (Linux & MacOS) require OSProcess or OSSubprocess to be installed prior to loading Pharo-Chrome.  To load OSSubprocess in 32 bit images:

```smalltalk
Metacello new
 	baseline: 'OSSubprocess';
 	repository: 'github://pharo-contributions/OSSubprocess:v1.3.0/repository';
	load.
```


On Windows the OSWindows package is required:

```smalltalk
Metacello new 
	repository: 'github://astares/Pharo-OS-Windows/src';
	baseline: 'OSWindows' ;
	load
```

Once the platform dependent packages have been loaded, load the main Pharo-Chrome package:

```smalltalk
Metacello new
	baseline: 'Chrome';
	repository: 'github://astares/Pharo-Chrome:master/repository';
	load.
```

To keep the original Monticello idea of having #stable and #development versions, Pharo-Chrome is mostly using the GitFlow workflow:

* The `master` branch is #stable
* The `development` branch is #development


## A Short Demo

### Stock price retrieval

As a demonstration of Pharo-Chrome, we'll retrieve some stock prices from the Australian ASX S&P 200 stock index:

```smalltalk
rootNode := GoogleChrome get: 'https://finance.yahoo.com/quote/%5EAXJO/history?p=%5EAXJO'
```

The messages I use most for navigating the DOM are:

<dl>
  <dt>#children</dt>
  <dd>Answer an array of the child nodes</dd>
  <dt>#parent</dt>
  <dd>Answer the parent node of the receiver</dd>
  <dt>#findAllTags:</dt>
  <dd>Find all tags matching the supplied criteria (see below).</dd>
  <dt>#findAllStrings:</dt>
  <dd>Find all strings matching the supplied criteria.</dd>
  <dt>#allSelect:</dt>
  <dd>Answer all nodes matching the supplied criteria.</dd>
</dl>

Both #findAllTags: and #findAllStrings: can take a string, a collection or a boolean as the parameter.  E.g. to find the h1 and h2 headings:

```smalltalk
headings := rootNode findAllTags: #('h1' 'h2').
```

More interesting is extracting all the data from a table, e.g. historical prices:

```smalltalk
tables := rootNode extractTables.
```

At the time of writing, two tables were returned.  The larger table is the one we're interested in.  Most of the rows will be actual data, smaller rows typically contain comments, so we'll make the data uniform by simply rejecting smaller rows.  It can be nicely inspected using:

```
historicalData := (tables sorted: #size ascending) last.
dataFrame := DataFrame fromRows: (historicalData select: [ :each | each size = 7 ]).
dataFrame asStringTable.

"
     |  1             2         3         4         5         6            7       
-----+-----------------------------------------------------------------------------
1    |  Date          Open      High      Low       Close*    Adj Close**  Volume  
2    |  Nov 14, 2017  6,021.80  6,021.80  5,957.10  5,966.00  5,966.00     -       
3    |  Nov 13, 2017  6,029.40  6,029.40  6,010.70  6,021.80  6,021.80     -       
4    |  Nov 10, 2017  6,049.40  6,049.40  6,020.70  6,029.40  6,029.40     -       
etc.
"
```

Note that the example above assumes that DataFrame has been installed in the image:

```smalltalk
Metacello new
  baseline: 'DataFrame';
  repository: 'github://PolyMathOrg/DataFrame';
  load.
```

### pharo.org screenshot

To retrieve a png image of the pharo.org front page in headless mode:

```smalltalk
| browser page image |

browser := GoogleChrome new.
browser headless: true.
browser open.
page := browser firstTab.
page get: 'http://pharo.org'.
image := page captureScreenshot.
browser closeAndExit.
image
```
