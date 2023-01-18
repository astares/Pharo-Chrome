"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestChromeCore,
	#superclass : #PackageManifest,
	#category : 'Chrome-Core-Manifest'
}

{ #category : #'code-critics' }
ManifestChromeCore class >> ruleSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'Win32ChromePlatform class' #defaultExecutableLocation #true)) #'2023-01-11T17:45:57.97814+01:00') )
]
