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

<div>
	<h1><p><strong><font color='#af0714'>Miguilim</font></strong></p></h1>
	
	<p align='center'><h2><strong><font color='RoyalBlue '></font></strong></h2></p>
	
		<p align='justify'><br>
        O Diret??rio das revistas cient??ficas eletr??nicas brasileiras - Miguilim ?? uma iniciativa do <a href="http://www.ibict.br/">Instituto Brasileiro de Informa????o em Ci??ncia e Tecnologia (IBICT)</a> pensada com o intuito de agregar informa????es essenciais das revistas cient??ficas editadas e 
		publicadas no Brasil que se encontravam dispersas em diferentes motores de busca. 
		</p>
		
		<p align='justify'>
		O Miguilim foi desenvolvido com o software Dspace e conta com uma robusta ferramenta de busca avan??ada, possibilitando aos usu??rios a recupera????o das revistas de modo completamente personalizado, uma vez que ?? poss??vel recuper??-las por t??tulo, n??mero 
		de ISSN, tipo de acesso permitido, ??rea do conhecimento em que publica, institui????o editora, periodicidade, cobran??a ou n??o de taxas de publica????o etc., melhorando de forma significativa a experi??ncia do usu??rio em rela????o a busca e recupera????o da 
		informa????o.
		</p>
		
		<h2><p><strong><font color='#af0714'>Como participar?</font></strong></p></h2>
		
		<p align='justify'>
		Para registrar uma revista, o editor respons??vel deve acessar a p??gina principal do Diret??rio, clicar no menu ???Meu espa??o??? e fazer seu cadastro pessoal. Confirmado o cadastro, o editor dever?? voltar ao ???Meu espa??o??? e ir at?? ???Iniciar um novo dep??sito???, 
		onde ser?? apresentado o formul??rio de cadastro. Ap??s o preenchimento dos dados, o cadastro ficar?? pendente de aceite por parte da equipe do Diret??rio, cabendo a ela a verifica????o dos dados e posterior aprova????o. 
		</p>
		
		<h2><p><strong><font color='#af0714'>Crit??rios b??sicos para registro</font></strong></p></h2>
		
		<p align='justify'>
		Para que uma revista possa ser cadastrada no Miguilim, dever?? cumprir os seguintes requisitos m??nimos: 
		</p>
</div>
</dspace:layout>

