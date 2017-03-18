<?xml version="1.0" encoding="UTF-8"?>
	<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<xsl:apply-imports/>
	</xsl:template>
	<xsl:output method="xml" indent="yes" standalone="yes" omit-xml-declaration="yes" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="*">
		<html xml:lang="en-gb">
			<head>
<style>

	body
	{font-family:Verdana, Arial, Helvetica, sans-serif;background:#fff;margin:10px 0;color:#444444;font-size:.8em;}
	h1
	{margin:1em 0;font-size:1.5em;}
	h2
	{margin:0px 0;font-size:1.1em;}
	h3
	{margin:0px 0;font-size:1.0em;color:#2885E1}
	img
	{border:none;}
	p
	{margin:10px 0 1em;}
	table
	{width:100%;border:1px solid #DBDCE3;border-bottom:none;margin:20px 0;}
	td, th
	{line-height:1.7;text-align:left;padding:3px 10px;border-bottom:1px solid #DBDCE3;vertical-align:top}
	th
	{background:#E9F9FF;text-align:right;border-top:1px solid #EBECF3;border-left:1px solid #EBECF3;}
	td
	{border-top:1px solid #EBECF3;}
	#mainTable
	{margin:auto;width:550px;background:#fff;}
	#mainLayout
	{padding:20px;40px}

</style>
			</head>
		<body>
		<div id="mainTable">
			<div id="mainLayout">
				<h1>Error message from the website...</h1>
				<h2>A File was selected by the a user, but has been found to be missing</h2>
				<h3>The File details are as follows:</h3>
				<table cellspacing="0" id="emailSummary" summary="Content submitted from website email form">
					<xsl:for-each select="Content/*">
						<tr>
							<th>
								<xsl:value-of select="name()"/></th>
							<td>
								<xsl:choose>
								<xsl:when test="contains(node(),'/')">
									<xsl:call-template name="Replace">
										<xsl:with-param name="string" select="node()"/>
										<xsl:with-param name="from" select="'/'"/>
										<xsl:with-param name="to" select="'\'"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="node()"/>
								</xsl:otherwise>
							</xsl:choose>
							</td>
						</tr>
					</xsl:for-each>
				</table>			
				<h3>More Useful Information:</h3>
				<table cellspacing="0" id="serverVar" summary="Content submitted from website email form">
					<tr>
						<th>Requesting Url</th>
						<td>
							<a href="http://{Request/ServerVariables/Item[@name ='HTTP_HOST']/node()}{Request/ServerVariables/Item[@name ='PREVIOUS_PAGE']/node()}">http://<xsl:value-of select="Request/ServerVariables/Item[@name ='HTTP_HOST']/node()"/><xsl:value-of select="Request/ServerVariables/Item[@name ='PREVIOUS_PAGE']/node()"/></a>
						</td>
					</tr>
					<xsl:if test="/Page/User">
					<tr>
						<th>Requesting User ID</th>
						<td>
							<xsl:value-of select="/Page/User/@name"/> - <xsl:value-of select="/Page/User/FirstName/node()"/> <xsl:value-of select="/Page/User/LastName/node()"/>
						</td>
					</tr>
					</xsl:if>
					<tr>
						<th>Users Web Browser</th>
						<td>
							<xsl:value-of select="Request/ServerVariables/Item[@name ='HTTP_USER_AGENT']/node()"/>
						</td>
					</tr>
				</table>
				<p>For help with this issue, please contact Eonic at support@eonic.co.uk</p>
				<p>Alternatively you are welcome call us on +44 (0)1892 534044 between 9.30am and 5.00pm GMT.</p>
				<p>Eonic also welcome any feedback that helps us improve our service and that of our clients</p>
			</div>
		</div>
	</body>
</html>		
	</xsl:template>

	<xsl:template name="FormatDate">
		<xsl:param name="Date" />
		<xsl:variable name="year">
			<xsl:value-of select ="substring($Date,1,4)"/>
		</xsl:variable>
		<xsl:variable name="mon">
			<xsl:value-of select ="substring($Date,6,2)"/>
		</xsl:variable>
		<xsl:variable name="day">
			<xsl:value-of select ="substring($Date,9,2)"/>
		</xsl:variable>

		<xsl:value-of select="$day"/>
		<xsl:value-of select="'-'"/>
		<xsl:choose>
			<xsl:when test="$mon = '01'">Jan</xsl:when>
			<xsl:when test="$mon = '02'">Feb</xsl:when>
			<xsl:when test="$mon = '03'">Mar</xsl:when>
			<xsl:when test="$mon = '04'">Apr</xsl:when>
			<xsl:when test="$mon = '05'">May</xsl:when>
			<xsl:when test="$mon = '06'">Jun</xsl:when>
			<xsl:when test="$mon = '07'">Jul</xsl:when>
			<xsl:when test="$mon = '08'">Aug</xsl:when>
			<xsl:when test="$mon = '09'">Sep</xsl:when>
			<xsl:when test="$mon = '10'">Oct</xsl:when>
			<xsl:when test="$mon = '11'">Nov</xsl:when>
			<xsl:when test="$mon = '12'">Dec</xsl:when>
			<xsl:otherwise>
					<xsl:value-of select="$mon"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$year"/>
	</xsl:template>

	<xsl:template name="FormatUser">
		<xsl:param name="UserId" />
		<xsl:variable name="wgrp">
			<xsl:value-of select ="substring-before($UserId,'\')"/>
		</xsl:variable>
		<xsl:variable name="user">
			<xsl:value-of select ="substring-after($UserId,'\')"/>
		</xsl:variable>
		<xsl:value-of select="$user"/>
		<xsl:value-of select="' ('"/>
		<xsl:value-of select="$wgrp"/>
		<xsl:value-of select="')'"/>
	</xsl:template>

		<xsl:template name="Replace">
			<xsl:param name="string" />
			<xsl:param name="from" />
			<xsl:param name="to" />
			<xsl:choose>
				<xsl:when test="contains($string,$from)">
					<xsl:value-of select="substring-before($string,$from)"/>
					<xsl:value-of select="$to"/>
					<xsl:call-template name="Replace">
						<xsl:with-param name="string" select="substring-after($string,$from)"/>
						<xsl:with-param name="from" select="$from"/>
						<xsl:with-param name="to" select="$to"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$string"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
</xsl:stylesheet>