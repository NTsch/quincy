<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cei="http://www.monasterium.net/NS/cei"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="*|@*">
        <xsl:message>WARNING: Unprocessed node: <xsl:value-of select="name()"/></xsl:message>
    </xsl:template>
    
    <xsl:template match='ead'>
        <cei:cei>
            <xsl:apply-templates/>
        </cei:cei>
    </xsl:template>
    
    <xsl:template match='eadheader'>
        <cei:teiHeader>
            <xsl:apply-templates/>
        </cei:teiHeader>
    </xsl:template>
    
    <xsl:template match='eadid'/>
    
    <xsl:template match='filedesc'>
        <cei:fileDesc>
            <xsl:apply-templates/>
        </cei:fileDesc>
    </xsl:template>
    
    <xsl:template match='titlestmt'>
        <cei:titleStmt>
            <xsl:apply-templates/>
        </cei:titleStmt>
    </xsl:template>
    
    <xsl:template match="titleproper">
        <cei:title>
            <xsl:apply-templates/>
        </cei:title>
    </xsl:template>
    
    <xsl:template match="subtitle">
        <cei:p>
            <xsl:apply-templates/>
        </cei:p>
    </xsl:template>
    
    <xsl:template match="publicationstmt">
        <cei:publicationStmt>
            <xsl:apply-templates/>
        </cei:publicationStmt>
    </xsl:template>
    
    <xsl:template match="publisher">
        <cei:publisher>
            <xsl:apply-templates/>
        </cei:publisher>
    </xsl:template>
    
    <xsl:template match="address">
        <cei:pubPlace>
            <xsl:apply-templates/>
        </cei:pubPlace>
    </xsl:template>
    
    <xsl:template match="addressline">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="archdesc">
        <cei:body>
            <xsl:apply-templates/>
        </cei:body>
    </xsl:template>
    
    <xsl:template match="did">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="dsc">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="c[not(@level)]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="did[parent::c[@level = 'file']]">
        <cei:body>
            <xsl:apply-templates/>
        </cei:body>
    </xsl:template>
    
    <xsl:template match="unitid">
        <cei:idno>
            <xsl:apply-templates/>
        </cei:idno>
    </xsl:template>
    
    <!--######################-->
    
    <xsl:template match="c[@level='file']">
        <xsl:variable name="file" select=".//node()" />
        <xsl:choose>
            <xsl:when test="scopecontent/p/text()[contains(., ',')]">
                <xsl:for-each select="tokenize(string-join(scopecontent/p/text()), ';')">
                    <xsl:call-template name="charter-content">
                        <xsl:with-param name="abstract-token" select="."/>
                        <xsl:with-param name="file" select="$file"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="charter-content"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="charter-content">
        <xsl:param name="abstract-token"/>
        <xsl:param name="file"/>
        <cei:text type='charter'>
            <xsl:apply-templates select="$file"/>
        </cei:text>
    </xsl:template>
    
</xsl:stylesheet>