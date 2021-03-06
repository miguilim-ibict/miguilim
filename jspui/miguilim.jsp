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
<h2><strong class="titulo-medio">Miguilim</strong></h2>

    <p>O Diret??rio das revistas cient??ficas eletr??nicas brasileiras - Miguilim ?? uma iniciativa do <a href="http://www.ibict.br/" target="_blank"> Instituto Brasileiro de Informa????o
        em Ci??ncia e Tecnologia (Ibict)</a> criada com o intuito de agregar, em um ??nico local, informa????es sobre as revistas cient??ficas editadas e publicadas no Brasil que se encontravam dispersas em diferentes
    plataformas. O diret??rio re??ne em sua base de dados o cadastro de informa????es essenciais das pol??ticas editoriais  de milhares de revistas cient??ficas brasileiras e tem
    como objetivos b??sicos: </p>
	
    <ol>
        <li>Facilitar o acesso ao conjunto das revistas cient??ficas editadas e publicadas no Brasil;</li>
        <li>Promover a dissemina????o e a visibilidade das revistas cient??ficas brasileiras com intuito de aumentar o impacto da sua produ????o no cen??rio internacional;</li>
        <li>Explicitar aspectos da pol??tica editorial com vistas a transpar??ncia dos processos editoriais empreendidos pelas revistas, assim como instruir os editores a respeito das possibilidades das pr??ticas editoriais a seguir;</li>
        <li>Por meio dos dados informados pelas revistas busca promover, tamb??m, a transpar??ncia necess??ria ?? avalia????o dessas revistas;</li>
        <li>Instruir os editores em rela????o aos crit??rios de avalia????o requeridos por grandes indexadores e bases de dados que disseminam e atribuem credibilidade ??s revistas;</li>
        <li>Incentivar pesquisas no ??mbito da Comunica????o Cient??fica e da Ci??ncia da Informa????o sobre os mais variados temas que possam ser extra??dos dos dados dispon??veis no Miguilim e, de maneira especial, sobre a qualidade editorial das revistas brasileiras;</li>
        <li>Servir como porta de entrada para outros produtos do Ibict que fazem o cadastro de revistas cient??ficas como Diadorim, OasisBr, Latindex  e EmeRI;</li>
        <li>Dar acesso aos dados das revistas brasileiras a bases de dados, reposit??rios diversos e outros diret??rios de revistas nacionais ou internacionais;</li>
        <li>Evitar o retrabalho dos editores respons??veis no preenchimento dos dados das revistas em diversas inst??ncias e promover a padroniza????o e a consist??ncia desses dados nas diversas plataformas;</li>
        <li>Incentivar a????es pr??ticas relacionadas aos movimentos de Ci??ncia Aberta e Acesso Aberto ?? informa????o cient??fica.</li>
    </ol>  

    <p>Em ??ltima an??lise, o Miguilim busca o aumento da qualidade editorial das revistas cient??ficas brasileiras, a internacionaliza????o da Ci??ncia brasileira e a democratiza????o do acesso ao conhecimento cient??fico.</p>
	
</div>
</dspace:layout>

