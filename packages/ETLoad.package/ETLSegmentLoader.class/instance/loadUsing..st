loading
loadUsing: outPointers
	"Loads the segment content and returns the root object."	
	| placeholderMap oopMap |

	placeholderMap := self
		skipVersion;
		parseAllToPlaceholders.

	oopMap := ETLOopMap
		newFromInternalObjects: placeholderMap
		andOutPointers: outPointers.

	self loadFromPlaceholders: placeholderMap values usingMap: oopMap.

	"4 = oop to the first object in an image segment (bytes 0-3 = header)"
	{ 8 . 12 . 16 } do: [ :oop |
		placeholderMap at: oop ifPresent: [ :object | ^ object. ]. ].

	"An image segment always contains an array of root objects, even if it is empty."
	ETLIncompatibleObjectError signal: 'Corrupt image segment'.