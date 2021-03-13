<xsl:transform version="3.0" expand-text="yes"
               xmlns:address="http://schemas.talis.com/2005/address/schema#"
               xmlns:bibo="http://purl.org/ontology/bibo/"
               xmlns:dct="http://purl.org/dc/terms/"
               xmlns:foaf="http://xmlns.com/foaf/0.1/"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Extract metadata from Extreme Markup Conference paper. -->

  <xsl:mode on-no-match="shallow-skip"/>
  <xsl:mode on-no-match="shallow-skip" name="person"/>

  <xsl:output indent="yes"/>

  <xsl:param name="date" as="xs:gYear" required="yes"/>

  <xsl:template match="/">
    <rdf:RDF>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="person"/>
    </rdf:RDF>
  </xsl:template>

  <xsl:template match="paper/front">
    <bibo:Article>
      <bibo:presentedAt>
        <bibo:Conference>
          <dct:title>Extreme Markup Languages®</dct:title>
        </bibo:Conference>
      </bibo:presentedAt>
      <bibo:authorList>
        <rdf:Seq>
          <xsl:apply-templates select="author"/>
        </rdf:Seq>
      </bibo:authorList>
      <xsl:apply-templates select="* except author"/>
      <dct:language>en</dct:language>
      <dct:isPartOf>
        <bibo:Proceedings>
          <dct:publisher>
            <foaf:Organization>
              <address:localityName>Montréal, Canada</address:localityName>
            </foaf:Organization>
          </dct:publisher>
          <dct:date>{$date}</dct:date>
        </bibo:Proceedings>
      </dct:isPartOf>
    </bibo:Article>
  </xsl:template>

  <xsl:template match="front/title">
    <dct:title>{.}</dct:title>
  </xsl:template>

  <xsl:template match="front/author">
    <rdf:li rdf:nodeID="{generate-id()}"/>
  </xsl:template>

  <xsl:template match="author" mode="person">
    <foaf:Person rdf:nodeID="{generate-id()}">
      <xsl:apply-templates mode="#current"/>
    </foaf:Person>
  </xsl:template>

  <xsl:template match="author/fname" mode="person">
    <foaf:givenName>{.}</foaf:givenName>
  </xsl:template>

  <xsl:template match="author/surname" mode="person">
    <foaf:surname>{.}</foaf:surname>
  </xsl:template>

</xsl:transform>
