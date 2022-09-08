<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fc="http://www.nationalarchives.gov.uk/pronom/SignatureFile">
	<xsl:output method="text"/>
	<xsl:template match="/">
		<xsl:text>PUID,SigID,Location,MinOffset,MaxOffset,Sequence,&#10;</xsl:text>
		<xsl:apply-templates select="fc:FFSignatureFile/fc:InternalSignatureCollection/fc:InternalSignature/fc:ByteSequence"/>
	</xsl:template>
	<xsl:template match="fc:ByteSequence">
		<xsl:call-template name="getPUID">
			<xsl:with-param name="sigID" select="../@ID"/>
		</xsl:call-template>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="../@ID"/>
		<xsl:text>,</xsl:text>
		<xsl:choose>
			<xsl:when test="@Reference">
				<xsl:value-of select="@Reference"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Variable</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="fc:SubSequence/@SubSeqMinOffset"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="fc:SubSequence/@SubSeqMaxOffset"/>
		<xsl:text>,</xsl:text>
		<xsl:for-each select="fc:SubSequence">
			<xsl:apply-templates select="." mode="allSequences"/>
		</xsl:for-each>
		<xsl:text>&#10;</xsl:text>
	</xsl:template>
	<xsl:template match="fc:SubSequence" mode="allSequences">
		<xsl:choose>
			<xsl:when test="../@Reference = 'EOFoffset'">
				<xsl:apply-templates select="." mode="allLeftFragments"/>
				<xsl:value-of select="fc:Sequence"/>
				<xsl:apply-templates select="." mode="allRightFragments"/>
				<xsl:if test="@Position &gt; 1">
					<xsl:choose>
						<xsl:when test="@SubSeqMinOffset &gt; 0">
							<xsl:text>{</xsl:text>
							<xsl:value-of select="@SubSeqMinOffset"/>
							<xsl:text>-*}</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>*</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="@Position &gt; 1">
					<xsl:choose>
						<xsl:when test="@SubSeqMinOffset &gt; 0">
							<xsl:text>{</xsl:text>
							<xsl:value-of select="@SubSeqMinOffset"/>
							<xsl:text>-*}</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>*</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:apply-templates select="." mode="allLeftFragments"/>
				<xsl:value-of select="fc:Sequence"/>
				<xsl:apply-templates select="." mode="allRightFragments"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="fc:SubSequence" mode="allLeftFragments">
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">15</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">14</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">13</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">12</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">11</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">10</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">9</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">8</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">7</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">6</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">5</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">4</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">3</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">2</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="leftFragment">
			<xsl:with-param name="position">1</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="fc:SubSequence" mode="leftFragment">
		<xsl:param name="position"/>
		<xsl:if test="count(fc:LeftFragment[@Position=$position]) = 1">
			<xsl:value-of select="fc:LeftFragment[@Position=$position]"/>
		</xsl:if>
		<xsl:if test="count(fc:LeftFragment[@Position=$position]) &gt; 1">
			<xsl:text>(</xsl:text>
			<xsl:for-each select="fc:LeftFragment[@Position=$position]">
				<xsl:if test="position() &gt; 1">
					<xsl:text>|</xsl:text>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:for-each>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:for-each select="fc:LeftFragment[@Position=$position]">
			<xsl:if test="position()= 1">
				<xsl:if test="@MaxOffset &gt; 0">
					<xsl:choose>
						<xsl:when test="@MaxOffset != @MinOffset">
							<xsl:text>{</xsl:text>
							<xsl:value-of select="@MinOffset"/>
							<xsl:text>-</xsl:text>
							<xsl:value-of select="@MaxOffset"/>
							<xsl:text>}</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>{</xsl:text>
							<xsl:value-of select="@MaxOffset"/>
							<xsl:text>}</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="fc:SubSequence" mode="allRightFragments">
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">1</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">2</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">3</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">4</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">5</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">6</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">7</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">8</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">9</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">10</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">11</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">12</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">13</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">14</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="rightFragment">
			<xsl:with-param name="position">15</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="fc:SubSequence" mode="rightFragment">
		<xsl:param name="position"/>
		<xsl:for-each select="fc:RightFragment[@Position=$position]">
			<xsl:if test="position()= 1">
				<xsl:if test="@MaxOffset &gt; 0">
					<xsl:choose>
						<xsl:when test="@MaxOffset != @MinOffset">
							<xsl:text>{</xsl:text>
							<xsl:value-of select="@MinOffset"/>
							<xsl:text>-</xsl:text>
							<xsl:value-of select="@MaxOffset"/>
							<xsl:text>}</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>{</xsl:text>
							<xsl:value-of select="@MaxOffset"/>
							<xsl:text>}</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<xsl:if test="count(fc:RightFragment[@Position=$position]) = 1">
			<xsl:value-of select="fc:RightFragment[@Position=$position]"/>
		</xsl:if>
		<xsl:if test="count(fc:RightFragment[@Position=$position]) &gt; 1">
			<xsl:text>(</xsl:text>
			<xsl:for-each select="fc:RightFragment[@Position=$position]">
				<xsl:if test="position() &gt; 1">
					<xsl:text>|</xsl:text>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:for-each>
			<xsl:text>)</xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template name="getPUID">
		<xsl:param name="sigID"/>
		<xsl:for-each select="/fc:FFSignatureFile/fc:FileFormatCollection/fc:FileFormat[fc:InternalSignatureID = $sigID]">
			<xsl:value-of select="@PUID"/>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
