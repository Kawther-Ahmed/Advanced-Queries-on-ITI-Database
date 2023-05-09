------------------------------------<< XML >>------------------------------------
/*Return the result of this XML data as table (XML shredding(From XML To Table)):*/
/*Create a table according to the returned tabular data and insert the result on it*/
DECLARE @docs XML = 
					'<book genre="VB" publicationdate="2010">
					   <title>Writing VB Code</title>
					   <author>
						  <firstname>ITI</firstname>
						  <lastname>ITI</lastname>
					   </author>
					   <price>44.99</price>
					</book>'

DECLARE @hdocs INT

EXECUTE sp_xml_preparedocument @hdocs OUTPUT, @docs

SELECT * INTO xml_table
FROM OPENXML(@hdocs, '//book')
WITH(
	genre VARCHAR(20) '@genre',
	publicationdate DATE '@publicationdate',
	title VARCHAR(100) 'title',
	firstname VARCHAR(20) 'author/firstname',
	lastname VARCHAR(20) 'author/lastname',
	price MONEY 'price'
)

SELECT * FROM xml_table