"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestSimplePersistenceCore,
	#superclass : #PackageManifest,
	#category : 'SimplePersistence-Core-Manifest'
}

{ #category : #'code-critics' }
ManifestSimplePersistenceCore class >> ruleGRAnsiCollectionsRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'SimplePersistence-Core')) #'2019-09-14T11:51:54.627318-04:00') )
]

{ #category : #'code-critics' }
ManifestSimplePersistenceCore class >> ruleGRAnsiConvertorRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SpBackupBrowser #compose #false)) #'2019-09-14T11:51:34.945128-04:00') )
]

{ #category : #'code-critics' }
ManifestSimplePersistenceCore class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SpBackupBrowser #compose #false)) #'2019-09-14T11:51:19.240384-04:00') )
]

{ #category : #'code-critics' }
ManifestSimplePersistenceCore class >> ruleRBMissingTranslationsInMenusRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'SimplePersistence-Core')) #'2019-09-14T11:52:00.129135-04:00') )
]
