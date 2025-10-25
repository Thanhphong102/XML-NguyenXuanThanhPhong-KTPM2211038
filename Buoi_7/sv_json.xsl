<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Xuất kết quả dạng text -->
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <xsl:text>{&#10;  "students": [&#10;</xsl:text>
        <xsl:for-each select="school/student">
            <xsl:text>    {</xsl:text>
            <xsl:text>"id": "</xsl:text><xsl:value-of select="id"/><xsl:text>", </xsl:text>
            <xsl:text>"name": "</xsl:text><xsl:value-of select="name"/><xsl:text>", </xsl:text>
            <xsl:text>"date": "</xsl:text><xsl:value-of select="date"/><xsl:text>"}</xsl:text>
            <!-- Thêm dấu phẩy giữa các object -->
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
        <xsl:text>  ]&#10;}</xsl:text>
    </xsl:template>
</xsl:stylesheet>
