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
<h2><strong class="titulo-medio">Como fazer um cadastro?</strong></h2>

	<p>Antes de iniciar o cadastro de uma revista cient??fica ou de um Portal de peri??dicos deve-se verificar se estes j?? n??o possuem
    um cadastro no Miguilim. Para isso, o respons??vel deve usar a barra de busca da p??gina inicial do Diret??rio e pesquisar por 
    t??tulo, institui????o respons??vel ou n??mero de ISSN. Tamb??m ?? poss??vel verificar todos os registros do Diret??rio por meio da aba
    ???Navegar??? > ???Comunidades e cole????es???. Aconselha-se que esta verifica????o seja feita mesmo para a revista cient??fica ou para o 
    Portal de peri??dicos que os respons??veis n??o tenham feito o cadastro no Miguilim, pois v??rios itens foram pr??-cadastrados pela 
    equipe do Diret??rio. Caso localize o registro da revista cient??fica ou do Portal de peri??dicos que desejava cadastrar, n??o 
    realize um novo registro. Neste caso, deve ser feita a <a href="http://200.130.45.73:8080/jspui/como-atualizar-cadastro.jsp" target="_blank">atualiza????o do cadastro</a> existente.</p>
    
    <p>Assegurando-se que a revista cient??fica ou o Portal de peri??dicos n??o se encontram previamente cadastrados no Miguilim, 
    basta fazer o login pela aba ???Entrar em??? e clicar no bot??o ???Iniciar um novo dep??sito??? <a href="http://200.130.45.73:8080/jspui/criacao-login.jsp" target="_blank">(Veja como criar um login aqui)</a>. Em seguida
    deve-se escolher uma das duas cole????es do Miguilim, ???Revistas??? ou ???Portais de peri??dicos???. Escolhida a cole????o o usu??rio ter??
    acesso ao formul??rio de cadastro, momento em que ele deve iniciar a descri????o do registro por meio do preenchimento dos campos de
    acordo com as instru????es indicadas. Ap??s o preenchimento dos campos, o cadastro ficar?? pendente de aceite por parte da equipe 
    gestora do Miguilim, cabendo a ela a verifica????o dos dados e posterior aprova????o. Assim que a equipe gestora realizar o aceite do cadastro, 
    um e-mail com o link do registro finalizado ser?? encaminhado ao respons??vel.</p>
	
	
</div>
</dspace:layout>

