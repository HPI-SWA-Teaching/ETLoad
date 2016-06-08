parsing
parseToPlaceholder
	"Parses the object at the current position of the stream to a new placeholder object."
	| header bodyStream |
	
	header := self parseHeader.
	bodyStream := ReadStream 
		on: self data 
		from: self stream position + 1
		to: self stream position + header objectSizeInWords - 1.
		
	self stream skip: header objectSizeInWords - 1.
	
	^ ETLPlaceholderObject newFrom: header and: bodyStream.
	