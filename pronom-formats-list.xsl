<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fc="http://www.nationalarchives.gov.uk/pronom/SignatureFile">
    <xsl:output method="text" />	
    
    <xsl:template match="/">
        <xsl:text>PUID,Name,Version&#10;</xsl:text>
        <xsl:for-each select="fc:FFSignatureFile/fc:FileFormatCollection/fc:FileFormat">


                <xsl:value-of select="@PUID" />
                <xsl:text>,</xsl:text>
                <xsl:value-of select="@Name" />
                <xsl:text>,</xsl:text>
                <xsl:value-of select="@Version" />
                <xsl:text>&#10;</xsl:text>

        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
