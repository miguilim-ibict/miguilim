<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Home page JSP
  -
  - Attributes:
  -    communities - Community[] all communities in DSpace
  -    recent.submissions - RecetSubmissions
  --%>

<%@page import="org.dspace.core.factory.CoreServiceFactory"%>
<%@page import="org.dspace.core.service.NewsService"%>
<%@page import="org.dspace.content.service.CommunityService"%>
<%@page import="org.dspace.content.factory.ContentServiceFactory"%>
<%@page import="org.dspace.content.service.ItemService"%>
<%@page import="org.dspace.core.Utils"%>
<%@page import="org.dspace.content.Bitstream"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.jsp.jstl.core.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.dspace.core.I18nUtil" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.app.webui.components.RecentSubmissions" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.browse.ItemCounter" %>
<%@ page import="org.dspace.content.Item" %>
<%@ page import="org.dspace.services.ConfigurationService" %>
<%@ page import="org.dspace.services.factory.DSpaceServicesFactory" %>

<%
    List<Community> communities = (List<Community>) request.getAttribute("communities");

    Locale sessionLocale = UIUtil.getSessionLocale(request);
    Config.set(request.getSession(), Config.FMT_LOCALE, sessionLocale);
	
    NewsService newsService = CoreServiceFactory.getInstance().getNewsService();
 /* String topNews = newsService.readNewsFile(LocaleSupport.getLocalizedMessage(pageContext, "news-top.html")); */
 /* String sideNews = newsService.readNewsFile(LocaleSupport.getLocalizedMessage(pageContext, "news-side.html")); */

    ConfigurationService configurationService = DSpaceServicesFactory.getInstance().getConfigurationService();
    
    boolean feedEnabled = configurationService.getBooleanProperty("webui.feed.enable");
    String feedData = "NONE";
    if (feedEnabled)
    {
        // FeedData is expected to be a comma separated list
        String[] formats = configurationService.getArrayProperty("webui.feed.formats");
        String allFormats = StringUtils.join(formats, ",");
        feedData = "ALL:" + allFormats;
    }
    
    ItemCounter ic = new ItemCounter(UIUtil.obtainContext(request));

    RecentSubmissions submissions = (RecentSubmissions) request.getAttribute("recent.submissions");
    ItemService itemService = ContentServiceFactory.getInstance().getItemService();
    CommunityService communityService = ContentServiceFactory.getInstance().getCommunityService();
%>

<dspace:layout locbar="nolink" titlekey="jsp.home.title" feedData="<%= feedData %>">

<div class="espacamento"> 
<h2><strong class="titulo-medio">Crit??rios b??sicos para cadastro</strong></h2>
		<p id="margem-unica">Para que uma revista seja aceita no Miguilim ela dever?? cumprir os seguintes requisitos m??nimos:</p>

		<ul>
			<li>Ter registro de ISSN para o suporte eletr??nico;</li>
			<li>Ter o Brasil como pa??s de publica????o na rede ISSN;</li>  
            <li>Ser eletr??nica e estar dispon??vel online;</li>
            <li>Manter conex??o permanente e est??vel com a internet;</li>
            <li>N??o ser publicada por uma <a href="https://predatoryjournals.com/publishers/" target="_blank">editora listada como 
            possivelmente predat??ria</a> no site <a href="https://predatoryjournals.com/" target="_blank">Stop Predatory Journals</a>, n??o 
            integrar a <a href="https://predatoryjournals.com/journals/" target="_blank">lista de revistas possivelmente predat??rias</a> e 
            n??o apresentar comportamentos predat??rios conforme os <a href="https://predatoryjournals.com/about/" target="_blank">
            crit??rios listados</a> pelo referido site (a avalia????o ser?? realizada pela equipe do Miguilim);</li>
            <li>Ser de car??ter acad??mico-cient??fico, levando em considera????o os seguintes requisitos:</li> 
			<ul>
				<li>Publicar artigos originais e in??ditos e que tenham sido previamente submetidos ?? revis??o por pares;</li>
                <li>Ter corpo editorial composto por pesquisadores especialistas na ??rea de atua????o da revista.</li>
			</ul>
		</ul>
		
		<p id="margem-unica">O Miguilim tamb??m aceita o cadastro de Portais de peri??dicos, os quais devem ser integrados por revistas cient??ficas que cumpram os requisitos indicados acima.</p>
</div>
</dspace:layout>

