<p:declare-step version="3.0" name="main"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <p:option name="in" as="xs:string" required="true"/>
  <p:option name="date" as="xs:gYear" required="true"/>

  <p:output port="result" sequence="true"/>

  <p:directory-list path="{$in}" include-filter="\.*xml$" max-depth="unbounded"/>

  <p:viewport match="c:file">
    <p:load href="{resolve-uri(c:file/@name, base-uri(c:file))}"/>
  </p:viewport>

  <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/xtreme2rdf.xsl"/>
    <p:with-option name="parameters" select="map{'date': $date}"/>
  </p:xslt>

</p:declare-step>
