<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match='/'>
    <components version="0.10">
      <xsl:for-each select='/expr/list/attrs'>
        <component type="{attr[@name = 'type']/string/@value}">
          <xsl:if test="attr[@name = 'id']">
            <id><xsl:value-of select="attr[@name = 'id']/string/@value" /></id>
          </xsl:if>
          <xsl:if test="attr[@name = 'pkgname']">
            <pkgname><xsl:value-of select="attr[@name = 'pkgname']/string/@value" /></pkgname>
          </xsl:if>
          <xsl:if test="attr[@name = 'name']">
            <name><xsl:value-of select="attr[@name = 'name']/string/@value" /></name>
          </xsl:if>
          <xsl:if test="attr[@name = 'description']">
            <summary><xsl:value-of select="attr[@name = 'description']/string/@value" /></summary>
          </xsl:if>
          <xsl:if test="attr[@name = 'longDescription']">
            <description><xsl:value-of select="attr[@name = 'longDescription']/string/@value" /></description>
          </xsl:if>
          <xsl:if test="attr[@name = 'spdxId']">
            <project_license><xsl:value-of select="attr[@name = 'spdxId']/string/@value" /></project_license>
          </xsl:if>
          <xsl:if test="attr[@name = 'homepage']">
            <url type="homepage"><xsl:value-of select="attr[@name = 'homepage']/string/@value" /></url>
          </xsl:if>
          <xsl:if test="attr[@name = 'icon']">
            <icon type="stock"><xsl:value-of select="attr[@name = 'icon']/string/@value" /></icon>
          </xsl:if>
          <xsl:if test="attr[@name = 'projectGroup']">
            <project_group><xsl:value-of select="attr[@name = 'projectGroup']/string/@value" /></project_group>
          </xsl:if>
          <xsl:if test="attr[@name = 'developerName']">
            <developer_name><xsl:value-of select="attr[@name = 'developerName']/string/@value" /></developer_name>
          </xsl:if>
          <xsl:if test="attr[@name = 'keywords']">
            <keywords>
              <xsl:for-each select="attr[@name = 'keywords']/list/string">
                <keyword><xsl:value-of select="@value" /></keyword>
              </xsl:for-each>
            </keywords>
          </xsl:if>
          <xsl:if test="attr[@name = 'categories']">
            <categories>
              <xsl:for-each select="attr[@name = 'categories']/list/string">
                <category><xsl:value-of select="@value" /></category>
              </xsl:for-each>
            </categories>
          </xsl:if>
          <xsl:if test="attr[@name = 'mimetypes']">
            <mimetypes>
              <xsl:for-each select="attr[@name = 'mimetypes']/list/string">
                <mimetype><xsl:value-of select="@value" /></mimetype>
              </xsl:for-each>
            </mimetypes>
          </xsl:if>
          <xsl:if test="attr[@name = 'provides']">
            <provides>
              <xsl:for-each select="attr[@name = 'provides_library']/list/string">
                <library><xsl:value-of select="@value" /></library>
              </xsl:for-each>
              <xsl:for-each select="attr[@name = 'provides_binary']/list/string">
                <binary><xsl:value-of select="@value" /></binary>
              </xsl:for-each>
              <xsl:for-each select="attr[@name = 'provides_font']/list/string">
                <font><xsl:value-of select="@value" /></font>
              </xsl:for-each>
            </provides>
          </xsl:if>
          <xsl:if test="attr[@name = 'suggests']">
            <suggests>
              <xsl:for-each select="attr[@name = 'suggests']/list/string">
                <id><xsl:value-of select="@value" /></id>
              </xsl:for-each>
            </suggests>
          </xsl:if>
          <xsl:if test="attr[@name = 'languages']">
            <languages>
              <xsl:for-each select="attr[@name = 'languages']/list/string">
                <id><xsl:value-of select="@value" /></id>
              </xsl:for-each>
            </languages>
          </xsl:if>
        </component>
      </xsl:for-each>
    </components>
  </xsl:template>
</xsl:stylesheet>
