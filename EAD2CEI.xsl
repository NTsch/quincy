<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cei="http://www.monasterium.net/NS/cei"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <!--<xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>-->
    
    <xsl:strip-space elements="*" />
    
    <!--<xsl:template match="*|@*">
        <xsl:message>WARNING: Unprocessed node: <xsl:value-of select="name()"/></xsl:message>
    </xsl:template>-->
    
    <xsl:variable name="img-file" select="doc('img_list_stutzmann.xml')"/>
    
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
    
    <!--TODO-->
    
    <!--###########################-->
    <xsl:template match="profiledesc"/>
    
    <xsl:template match="physdesc"/>
    
    <xsl:template match="physfacet"/>
    
    <xsl:template match="bioghist"/>
    
    <xsl:template match="odd"/>
    
    <!--###########################-->
    
    <xsl:template match="archdesc">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="archdesc[@level='fonds']">
        <cei:text>
            <cei:group>
                <xsl:apply-templates/>
            </cei:group>
        </cei:text>
    </xsl:template>
    
    <xsl:template match="did[parent::archdesc or parent::c[not(@level='file')]]"/>
    
    <xsl:template match="dsc">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="c[not(@level)]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!--<xsl:template match="unitid">
        <cei:idno>
            <xsl:apply-templates/>
        </cei:idno>
    </xsl:template>-->
    
    <!--<xsl:template match="unittitle">
        <cei:h1>
            <xsl:apply-templates/>
        </cei:h1>
    </xsl:template>-->
    
    <xsl:template match="scopecontent"/>
    
    <xsl:template match='p'>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="head"/>
    
    <xsl:template match='repository'>
        <cei:archIdentifier>
            <cei:arch>
                <xsl:apply-templates/>
            </cei:arch>
        </cei:archIdentifier>
    </xsl:template>
    
    <xsl:template match="bibliography">
        <cei:listBibl>
            <xsl:apply-templates/>
        </cei:listBibl>
    </xsl:template>
    
    <xsl:template match="p[parent::bibliography]">
        <cei:bibl>
            <xsl:apply-templates/>
        </cei:bibl>
    </xsl:template>
    
    <xsl:template match="lb">
        <cei:lb>
            <xsl:apply-templates/>
        </cei:lb>
    </xsl:template>
    
    <xsl:template match="note">
        <cei:note>
            <xsl:apply-templates/>
        </cei:note>
    </xsl:template>
    
    <xsl:template match="controlaccess"/>
    
    <xsl:template match="accessrestrict"/>
    
    <xsl:template match="emph"/>
    
    <xsl:template match="unitdate">
        <!--generally contains either e.g. normal="1101/1800" or e.g. normal="1101"-->
        <cei:issued>
            <xsl:choose>
                <xsl:when test="contains(./@normal/data(), '/')">
                    <cei:dateRange from="{concat(substring-before(./@normal/data(), '/'), '9999')}" to="{concat(substring-after(./@normal/data(), '/'), '9999')}">
                        <xsl:apply-templates/>
                    </cei:dateRange>
                </xsl:when>
                <xsl:when test="matches(./@normal/data(), '^\d{4}$')">
                    <cei:date value="{concat(./@normal/data(), '9999')}">
                        <xsl:apply-templates/>
                    </cei:date>
                </xsl:when>
                <xsl:otherwise>
                    <cei:date value='99999999'>
                        <xsl:apply-templates/>
                    </cei:date>
                </xsl:otherwise>
            </xsl:choose>
        </cei:issued>
    </xsl:template>
    
    <!--######################-->
    
    <xsl:template match="c[@level='file']">
        <xsl:variable name="desc_id" select="did" />
        <xsl:choose>
            <!--scopecontent/p/text() is not always present-->
            <xsl:when test="scopecontent/p/normalize-space()">
                <xsl:for-each select="tokenize(string-join(scopecontent/p/text()), ';')">
                    <xsl:call-template name="charter-content">
                        <xsl:with-param name="abstract-token">
                            <xsl:choose>
                                <xsl:when test="normalize-space(.)">
                                    <xsl:value-of select="normalize-space(.)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$desc_id/unittitle/text()"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="desc_id" select="$desc_id"/>
                        <xsl:with-param name="counter" select="position()"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="charter-content">
                    <xsl:with-param name="abstract-token" select="did/unittitle/text()"></xsl:with-param>
                    <xsl:with-param name="desc_id" select="$desc_id"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="charter-content">
        <xsl:param name="abstract-token"/>
        <xsl:param name="desc_id"/>
        <xsl:param name="counter"/>
        <cei:text type="charter">
            <!--<cei:front>
                <xsl:apply-templates select="$desc_id/unittitle"/>
            </cei:front>-->
            <cei:body>
                <cei:idno>
                    <xsl:choose>
                        <xsl:when test="$counter">
                            <xsl:variable name="id" select="concat($desc_id/unitid, '-', $counter)"/>
                            <xsl:attribute name="id" select="$id"/>
                            <xsl:value-of select="$id"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="id" select="$desc_id/unitid"/>
                            <xsl:value-of select="$desc_id/unitid"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </cei:idno>
                <cei:chDesc>
                    <cei:abstract>
                        <xsl:apply-templates select="$abstract-token"/>
                    </cei:abstract>
                    <cei:witnessOrig>
                        <xsl:for-each select="$img-file//dossier[matches(@id, concat('ADCO ', replace($desc_id/unitid/text(), ' ', ''), '(-\d+)?$'))]/recto">
                            <cei:figure>
                                <cei:graphic url="{concat('https://images.monasterium.net/img/Quincy/ADCO_', replace($desc_id/unitid/text(), ' ', ''), '/', ./text())}"/>
                            </cei:figure>
                        </xsl:for-each>
                    </cei:witnessOrig>
                    <xsl:apply-templates select="$desc_id/unitdate"/>
                    <xsl:apply-templates select="$desc_id/bibliography"/>
                </cei:chDesc>
            </cei:body>
        </cei:text>
    </xsl:template>
    
</xsl:stylesheet>