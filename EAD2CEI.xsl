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
    
</xsl:stylesheet>