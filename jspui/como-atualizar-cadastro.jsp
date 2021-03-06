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
    <h2><strong class="titulo-medio">Como atualizar um cadastro?</strong></h2>

    <p>Para atualizar o cadastro de uma revista cient??fica ?? necess??rio que o usu??rio  tenha o acesso autorizado para realizar tal 
    a????o. As revistas que foram cadastradas pelos pr??prios respons??veis j?? possuem essa autoriza????o. Para verificar se possui 
    autoriza????o para atualizar a revista, fa??a o Login no diret??rio, entre em ???Meu espa??o??? e clique na aba ???Ver dep??sito(s) aceito(s)???.
    As revistas listadas nessa se????o est??o vinculadas a esse login e podem ser atualizadas. As revistas que foram pr??-cadastradas no
    Miguilim pela equipe administradora do diret??rio precisam solicitar a autoriza????o para a atualiza????o. Segue abaixo o informativo de
    como atualizar os dados da revista em cada situa????o.</p>

    <h2><strong class="titulo-medio">Revistas pr??-cadastradas (N??o possuem login vinculado)</strong></h2>
    
    <p>Caso o usu??rio localize um registro de revista de sua responsabilidade j?? registrada no Miguilim e deseje fazer altera????es no
    mesmo, ele deve primeiramente solicitar permiss??o para a atualiza????o do registro. Para esta solicita????o, o usu??rio deve acessar a
    p??gina do registro da revista e clicar na aba "Solicitar edi????o da revista". Ao clicar nessa aba o usu??rio ter?? acesso ao ???Formul??rio 
    de solicita????o de edi????o de revista no Miguilim??? e dever?? preencher os campos de acordo com as instru????es indicadas e clicar em ???Enviar???. 
    Os dados informados ser??o verificados pela Equipe Miguilim no site da revista, que conceder?? ou n??o as permiss??es de atualiza????o. 
    Assim sendo, as informa????es fornecidas no formul??rio dever??o ser as mesmas constantes no site da revista, caso contr??rio n??o ser?? poss??vel 
    conceder as autoriza????es. O endere??o de e-mail informado dever?? ser o mesmo utilizado para realizar o login no Miguilim, j?? que a permiss??o 
    vai ser dada para este login <a href="http://200.130.45.73:8080/jspui/criacao-login.jsp" target="_blank">(Veja como criar um login aqui)</a>.</p>

    <p>Assim que o formul??rio for enviado a Equipe Miguilim ser?? notificada e ir?? proceder com os ajustes para a concess??o das permiss??es de atualiza????o. Em seguida a Equipe
    Miguilim entrar?? em contato com a revista indicando que esta possui as autoriza????es necess??rias para a atualiza????o do registro.</p>
    
    <p>Com as devidas autoriza????es, o usu??rio dever?? dirigir-se ao registro da revista, clicar na aba ???Editar dados do registro??? e informar o n??mero de ISSN, login e senha
        <a href="http://200.130.45.73:8080/jspui/criacao-login.jsp" target="_blank">(Veja como criar um login aqui)</a>. Ao informar estes dados o usu??rio ter?? acesso ao formul??rio de edi????o, onde poder?? alterar todos os campos que achar necess??rio. Os campos
    devem ser preenchidos de acordo  com as instru????es indicadas. A atualiza????o do registro ser?? disponibilizada automaticamente no diret??rio, cabendo ?? equipe gestora do 
    Miguilim a verifica????o e revis??o dos dados indicados.</p>

    <h2><strong class="titulo-medio">Revistas cadastradas pelos respons??veis (Possuem login vinculado)</strong></h2>
	
    <p>Revistas que foram cadastradas pelos pr??prios respons??veis j?? possuem permiss??o de acesso interno aos registros e podem fazer a atualiza????o dos dados da revista sem 
    solicitar permiss??o para isso. Para a atualiza????o dos dados o usu??rio dever?? dirigir-se ao registro da revista, clicar na aba ???Editar dados do registro??? e informar o 
    n??mero de ISSN, login e senha <a href="http://200.130.45.73:8080/jspui/criacao-login.jsp" target="_blank">(Veja como criar um login aqui)</a>. Ao informar estes dados, o usu??rio efetuar?? o login e ter?? acesso ao formul??rio de edi????o, onde poder?? 
    alterar todos os campos que achar necess??rio. Os campos devem ser preenchidos de acordo com as instru????es indicadas. A atualiza????o do registro ser?? disponibilizada 
    automaticamente no diret??rio, cabendo ?? equipe gestora do Miguilim a verifica????o e revis??o dos dados indicados.</p>
    
    <h2><strong class="titulo-medio">Atualiza????o do cadastro de Portais de peri??dicos</strong></h2>

    <p>As instru????es de altera????o apresentadas anteriormente n??o se aplicam ?? cole????o ???Portal de peri??dicos???. Para alterar os dados desses registros, o gestor do Portal dever??
    entrar em contato com a Equipe Miguilim solicitando sua atualiza????o. O contato pode ser feito por e-mail (revistas@ibict.br). Neste contato ?? importante que o solicitante
    apresente-se e informe por qual o Portal de peri??dicos ele ?? respons??vel. Os campos da cole????o Portais de peri??dicos s??o:</p>

    <dl>
        <dd>Nome do portal de peri??dicos* </dd>
        <dd>URL* </dd>
        <dd>Institui????o respons??vel* </dd>
        <dd>Organismo subordinado </dd>
        <dd>Administrador respons??vel* </dd>
        <dd>E-mail* </dd>
        <dd>C??digo Postal (CEP)* </dd>
        <dd>Estado (UF)* </dd>
        <dd>Cidade* </dd>
        <dd>Bairro/Setor* </dd>
        <dd>Rua/Quadra ou similar</dd>
        <dd>Casa/Pr??dio/ Sala ou similar</dd>
        <dd>Telefone</dd>
        <dd>Revistas do portal*</dd>
    </dl>

</div>
</dspace:layout>

