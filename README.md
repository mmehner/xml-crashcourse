# Crash Course: XML and XSLT for Indologists

## preliminary considerations: text encoding and presentation
- text encoding is not to be confounded with character encoding, cf. [this site](https://scripts.sil.org/IWS-Chapter02) for a short introduction;
- text encoding is mostly done with a concrete form of presentation (a printed book, web page, poster) in mind, the content is structured and differentiated according to the necessities of the processor (e.g. LaTeX commands separate content from presentation), often inside a user interface that displays the encoded information as formatted text in a similar way to the intended result (WYSIWYG, e.g. office suites); the text encoding has to be converted if another form of presentation is desired
- textual content can also be encoded according to its function regardless of presentation, which is especially useful if:
  - various presentations should be generated from the same source file,
  - a subsequent use of the content by yourself or others is foreseeable/desirable,
  - you don't want to deal with formatting details (yet).
- general drawbacks of functional markup:
  - functional markup is usually more intrusive and less intuitive to read,
  - presentation has to be styled separately.

## some acronyms
- XML = Extensible Markup Language
- XSLT = Extensible Stylesheet Language Transformations, 
- DTD = Document Type Definition, a validation scheme type
- TEI = Text Encoding Initiative

## xml I: minimal example of a well-formed xml-file
- [this](mini.xml) file

### structure
1. proloque with xml-declaration,
2. xml-tree, elements must be nesting `<tree><branch><leaf/><leaf/></branch></tree>` in order to be well-formed.

### terminology
- markup and content: `<markup>content</markup>`
- tag:
  - start-tag: `<tag>`;
  - end-tag: `</tag>`;
  - empty-element tag: `<empty/>`, equivalent to `<empty></empty>`
- element: tag with content, may contain child elements
- attribute: `<tag attribute="value">content</tag>`
- entities: characters that are problematic to include directly must be escaped, predefined entities are:
  - `&lt;` represents "<";
  - `&gt;` represents ">";
  - `&amp;` represents "&";
  - `&apos;` represents "'";
  - `&quot;` represents '"'.
- comments: <!-- comment -->
- namespace: 
  - uniquely identifies a set of names so that there is no ambiguity when objects having different origins but the same names are mixed together,
  - example:
  ```xml
  <root>
	<element>
		<subelement>
		</subelement>
	</element>
	<element xmlns="https://www.somepage.com">
  	<!-- set namespace for whole subtree, "element" is only matched if namespace is specified -->
	     <subelement>
	     <!-- inherits namespace -->
	     </subelement>
	</element>
  </root>
  ```

## xslt I: building modifications on identity transformation
- requirement: xslt-processor like [Saxon-HE](http://saxon.sourceforge.net/#F9.9HE)
- [xml identity transformation](xslt-stylesheets/identity.xsl) with xslt2
- apply stylesheet to xml-file, e.g. with Java: `java /path/to/saxon9he.jar -s:source.xml -xsl:stylesheet.xsl`
- elements are matched or selected with XPath expressions, using
  - absolute paths: `/root/path/to/some/element`
  - relative paths with 13 axes:
    1. `ancestor`
    2. `ancestor-or-self`
    3. `attribute` or `@`
    4. `child` or `/`
    5. `descendant` or `//`
    6. `descendant-or-self`
    7. `following`
    8. `following-sibling`
    9. `namespace`
    10. `parent` or `../`
    11. `preceeding`
    12. `preceeding-sibling`
    13. `self` or `.`
  - wildcards:
    - `*` for any string, e.g. `@` matches one attribute, `@attr` only matches the attribute named ‘attr’, `@*` matches all attributes of an element,
    - `node()` matches elements, text, comments, and processing instructions (i.e. everything except attributes),
    - `text()` matches text content.

## xml II: validation and TEI
- validation scheme: different formats (*.dtd, *.rnc, *.rng), same function: 
  - defines the structure of the markup (which elements can nest, which attributes are allowed for certain elements, etc.),
  - can be linked to an xml-file, a suitable editor can validate and auto-complete the markup on-the-fly and thus help to write 
- schemes for xml that is compliant with the proposal of the Text Encoding Initiative (TEI) can be created [here](https://romabeta.tei-c.org/),
- the current Guidelines for encoding can be found and downloaded [here](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/index.html).

## xslt II: outputting plain text
- [plain text](xslt-stylesheets/tei-bsp.xsl) with xslt2 from TEI