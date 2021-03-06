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

<div class="container" id="TopoPerguntasFrequentes">
    <h2><a href="#PqMiguilim">Por que o nome Miguilim?</a></h2>
    <h2><a href="#ComoCriarLogin">Como criar um login?</a></h2>
    <h2><a href="#ComoCadastroUmaRevista">Como cadastrar uma revista ou portal de peri??dicos?</a></h2>
    <h2><a href="#criteriosBasicos">Quais s??o os crit??rios b??sicos para cadastro?</a></h2>
    <h2><a href="#QualquerRevista">Qualquer revista pode ser cadastrada?</a></h2>
    <h2><a href="#QuemPodeAtualizar">Quem pode atualizar o cadastro de revistas?</a></h2>
    <h2><a href="#ComoSolicitarPermissao">Como solicitar permiss??o para atualizar minha revista?</a></h2>
    <h2><a href="#ComoAtualizarArevista">Como atualizar a minha revista?</a></h2>
    <h2><a href="#ComoAlterarOregistro">Como alterar o registro de um Portal de peri??dicos?</a></h2>
    <h2><a href="#PorqueEimportanteCadastrar">Porque ?? importante cadastrar uma revista no Miguilim?</a></h2>
    <h2><a href="#RevistasQueNaosaoPublicadas">Revistas que n??o s??o publicadas no Brasil tamb??m podem ser cadastradas?</a></h2>
    <h2><a href="#ComoForamDefinidosOsCampos">Como foram definidos os campos de descri????o de revistas do Miguilim?</a></h2>
    <h2><a href="#DeOndeVieramAsInformacoes">De onde vieram as informa????es dos primeiros registros do Miguilim?</a></h2>
    <h2><a href="#EmQualSoftware">Em qual software foi desenvolvido o Miguilim?</a></h2>
    <h2><a href="#ComoFuncionaOformulario">Como funciona o formul??rio de atualiza????o do Miguilim?</a></h2>
    <h2><a href="#OqueEoTermometro">O que ?? o Term??metro de Acesso Aberto?</a></h2>
    <h2><a href="#PorQueUmaColecaoDePortais">Por que existe uma cole????o de portais de peri??dicos?</a></h2>

    <div class="espacamento">

        <h2><a id="PqMiguilim"><strong class="titulo-medio">Por que o nome Miguilim?</strong></a></h2>

            <p id="margem-unica">Miguilim ?? um dos personagens do livro ???Manuelz??o e Miguilim???, um dos cl??ssicos romances da literatura brasileira cujo autor ?? Jo??o Guimar??es Rosa.
            O nome foi escolhido com vistas a acompanhar a tend??ncia internacional de nomear diret??rios e servi??os de informa????o homenageando obras da literatura do pa??s em que o 
            sistema foi desenvolvido.</p>

            <p id="margem-unica">Al??m do mais, a escolha do nome se deu pelo fato do Miguilim ter sido criado em conjunto com outro servi??o do Ibict, o Manuelz??o - Portal brasileiro para as revistas
            cient??ficas. Deste modo, Manuelz??o e Miguilim representam duas importantes a????es do Ibict em prol das revistas cient??ficas brasileiras, cada qual com suas particularidades.</p>

        <h2><a id="ComoCriarLogin"><strong class="titulo-medio">Como criar um login?</strong></a></h2>

            <p id="margem-unica">O primeiro passo para fazer parte do Miguilim ?? criar login da Revista cient??fica ou do Portal de peri??dicos que queira cadastrar. Aconselha-se 
            que o e-mail utilizado para a cria????o do login seja o e-mail institucional da Revista cient??fica ou do Portal de peri??dicos. Deve-se evitar o uso de e-mails pessoais dos gestores, tendo em vista que a mudan??a dos respons??veis pode acarretar a perda do acesso.</p>
            
            <p id="margem-unica">Para criar o login, o respons??vel deve acessar a aba ???Login???, clicar no link ???Usu??rio novo? Clique aqui para se registrar???, informar o e-mail 
            institucional no campo ???Endere??o de e-mail??? e clicar em ???Registrar???. Ao efetuar estes passos, o respons??vel receber?? um e-mail com um link para que fa??a o registro das
            informa????es e crie uma senha para o cadastro. Feito isso, o respons??vel dever?? clicar em ???Completar o registro???. A partir de ent??o o login ter?? sido criado, o que permite 
            acesso interno ao Miguilim via aba ???Login???, onde os cadastros de revistas cient??ficas e portais de peri??dicos podem ser realizados.</p>

        <h2><a id="ComoCadastroUmaRevista"><strong class="titulo-medio">Como cadastrar uma revista ou portal de peri??dicos?</strong></a></h2>
         
            <p id="margem-unica">Assegurando-se que a Revista cient??fica ou o Portal de peri??dicos n??o est??o registrados no Miguilim, basta fazer o login pela aba ???Entrar em???
            e clicar no bot??o ???Iniciar um novo dep??sito???. Em seguida deve-se escolher uma das duas cole????es do Miguilim, ???Revistas??? ou ???Portais de peri??dicos???. Escolhida a 
            cole????o o usu??rio ter?? acesso ao formul??rio de cadastro, momento em que deve iniciar a descri????o do registro por meio do preenchimento dos campos de acordo com as 
            instru????es indicadas. Ap??s o preenchimento dos campos, o cadastro ficar?? pendente de aceite por parte da equipe gestora do Miguilim, cabendo a ela a verifica????o dos 
            dados e posterior aprova????o. Assim que a equipe gestora realizar o aceite do cadastro, um e-mail com o link do registro finalizado ser?? encaminhado ao respons??vel.</p>

        <h2><a id="criteriosBasicos"><strong class="titulo-medio">Quais s??o os crit??rios b??sicos para cadastro?</strong></a></h2>

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
            
        <h2><a id="QualquerRevista"><strong class="titulo-medio">Qualquer revista pode ser cadastrada?</strong></a></h2>   

            <p id="margem-unica">Cumprindo os crit??rios b??sicos para registro, qualquer revista pode ser cadastrada. No entanto, todos os cadastros est??o sujeitos ?? revis??o 
            pela equipe do Diret??rio antes de serem aprovados. Al??m de verificar o cumprimento dos crit??rios b??sicos, a revis??o tem o objetivo de avaliar se os dados foram
            preenchidos de acordo com as instru????es indicadas em cada campo e se as informa????es fornecidas condizem com o que se indica na p??gina da revista.</p>

        <h2><a id="QuemPodeAtualizar"><strong class="titulo-medio">Quem pode atualizar o cadastro de revistas?</strong></a></h2>

            <p id="margem-unica">Para atualizar o cadastro de uma revista cient??fica ?? necess??rio que o usu??rio  tenha o acesso autorizado para realizar tal a????o. As revistas
            que foram cadastradas pelos pr??prios respons??veis j?? possuem essa autoriza????o. Para verificar se possui autoriza????o para atualizar a revista, fa??a o Login no diret??rio, 
            entre em ???Meu espa??o??? e clique na aba ???Ver dep??sito (s) aceito (s)???. As revistas listadas nessa se????o est??o vinculadas a esse login e podem ser atualizadas. As revistas
            que foram pr??-cadastradas no Miguilim precisam solicitar a autoriza????o para a atualiza????o.</p>

        <h2><a id="ComoSolicitarPermissao"><strong class="titulo-medio">Como solicitar permiss??o para atualizar minha revista?</strong></a></h2>

            <p id="margem-unica">Caso o usu??rio localize um registro de revista de sua responsabilidade j?? registrada no Miguilim e deseje fazer altera????es no mesmo, ele deve 
            primeiramente solicitar permiss??o para a atualiza????o do registro. Para esta solicita????o, o usu??rio deve acessar a p??gina do registro da revista e clicar na aba 
            "Solicitar edi????o da revista". Ao clicar nessa aba o usu??rio ter?? acesso ao ???Formul??rio de solicita????o de edi????o de revista no Miguilim??? e dever?? preencher os 
            campos de acordo com as instru????es indicadas e clicar em ???Enviar???. Os dados informados ser??o verificados pela Equipe Miguilim no site da revista, que conceder?? ou
            n??o as permiss??es de atualiza????o. Assim sendo, as informa????es fornecidas no formul??rio dever??o ser as mesmas constantes no site da revista, caso contr??rio n??o ser?? 
            poss??vel conceder as autoriza????es. O endere??o de e-mail informado dever?? ser o mesmo utilizado para realizar o login no Miguilim, j?? que a permiss??o vai ser dada para
            este login. Assim que o formul??rio for enviado a Equipe Miguilim ser?? notificada e ir?? proceder com os ajustes para a concess??o das permiss??es de atualiza????o. Em seguida
            a Equipe Miguilim entrar?? em contato com a revista indicando que esta possui as autoriza????es necess??rias para a atualiza????o do registro.</p>

        <h2><a id="ComoAtualizarArevista"><strong class="titulo-medio">Como atualizar a minha revista?</strong></a></h2>
            
            <p id="margem-unica">Para a atualiza????o dos dados o usu??rio dever?? dirigir-se ao registro da revista, clicar na aba ???Editar dados do registro??? e informar o n??mero
            de ISSN, login e senha. Ao informar estes dados, o usu??rio efetuar?? o login e ter?? acesso ao formul??rio de edi????o, onde poder?? alterar todos os campos que achar 
            necess??rio. Os campos devem ser preenchidos de acordo com as instru????es indicadas. A atualiza????o do registro ser?? disponibilizada automaticamente no diret??rio, cabendo
            ?? equipe gestora do Miguilim a verifica????o e revis??o dos dados indicados.</p>
        
        <h2><a id="ComoAlterarOregistro"><strong class="titulo-medio">Como alterar o registro de um Portal de peri??dicos?</strong></a></h2>

            <p id="margem-unica">Para alterar os dados desses registros, o gestor do Portal dever?? entrar em contato com a Equipe Miguilim solicitando sua atualiza????o. O contato pode ser feito
            por e-mail (revistas@ibict.br). Neste contato ?? importante que o solicitante apresente-se e informe por qual o Portal de peri??dicos ?? respons??vel. Os campos da 
            cole????o Portais de peri??dicos s??o:</p>

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
        
        <h2><a id="PorqueEimportanteCadastrar"><strong class="titulo-medio">Porque ?? importante cadastrar uma revista no Miguilim?</strong></a></h2>

            <p id="margem-unica">O Miguilim foi criado com o intuito de agregar, em um ??nico local, informa????es sobre as revistas cient??ficas editadas e publicadas no Brasil que se encontravam
            dispersas em diferentes plataformas. O diret??rio re??ne em sua base de dados o cadastro de informa????es essenciais das pol??ticas editoriais  de milhares de revistas 
            cient??ficas brasileiras, tendo como objetivos b??sicos:</p>

            <ol>
                <li>Facilitar o acesso ao conjunto das revistas cient??ficas editadas e publicadas no Brasil;</li>
                <li>Promover a dissemina????o e a visibilidade das revistas cient??ficas brasileiras com intuito de aumentar o impacto da sua produ????o no cen??rio internacional;</li>
                <li>Explicitar aspectos da pol??tica editorial com vistas a transpar??ncia dos processos editoriais empreendidos pelas revistas, assim como instruir os editores a respeito das possibilidades das pr??ticas editoriais a seguir;</li>
                <li>Por meio dos dados informados pelas revistas busca promover, tamb??m, a transpar??ncia necess??ria ?? avalia????o dessas revistas; </li>
                <li>Instruir os editores em rela????o aos crit??rios de avalia????o requeridos por grandes indexadores e bases de dados que disseminam e atribuem credibilidade ??s revistas;</li>
                <li>Incentivar pesquisas no ??mbito da Comunica????o Cient??fica e da Ci??ncia da informa????o sobre os mais variados temas que possam ser extra??dos dos dados dispon??veis no Miguilim e, de maneira especial, sobre a qualidade editorial das revistas brasileiras;</li>
                <li>Tem a inten????o de servir como porta de entrada para outros produtos do Ibict que fazem o cadastro de revistas cient??ficas como Diadorim, Oasisbr, Latindex  e Emeri;</li>
                <li>Evitar o retrabalho dos editores respons??veis no preenchimento dos dados das revistas em diversas inst??ncias e promover a padroniza????o e a consist??ncia desses dados nas diversas plataformas;</li>
                <li>Assim como servir de porta de entrada para outros produtos do Ibict, a plataforma busca dar acesso aos dados das revistas brasileiras a bases de dados, reposit??rios diversos e outros diret??rios de revistas nacionais ou internacionais;</li>
                <li>Incentivar a????es pr??ticas relacionadas aos movimentos de Ci??ncia Aberta e Acesso Aberto ?? informa????o cient??fica.</li>
            </ol>

            <p id="margem-unica">Em ??ltima an??lise, o Miguilim busca o aumento da qualidade editorial das revistas cient??ficas brasileiras, a internacionaliza????o da ci??ncia 
            brasileira e a democratiza????o do acesso ao conhecimento cient??fico.</p>
            
        <h2><a id="RevistasQueNaosaoPublicadas"><strong class="titulo-medio">Revistas que n??o s??o publicadas no Brasil tamb??m podem ser cadastradas?</strong></a></h2>

            <p id="margem-unica">N??o, o Miguilim engloba somente as revistas criadas e editadas no Brasil. Revistas estrangeiras podem ser registradas em outros diret??rios, 
            ??ndices e bases de dados com objetivos similares.</p>
        
        <h2><a id="ComoForamDefinidosOsCampos"><strong class="titulo-medio">Como foram definidos os campos de descri????o de revistas do Miguilim?</strong></a></h2>

            <p id="margem-unica">O padr??o de metadados original do Miguilim foi definido a partir de estudos feitos por sua equipe gestora com cerca de oito plataformas de acesso
            aberto que possuem o cadastro de revistas cient??ficas, sendo elas: Diadorim, Latindex, DOAJ, Portal ISSN, Wikidata, Google Scholar Metrics, Sum??rios e a base do antigo
            e j?? desativado Portal de peri??dicos SEER. Desse modo, foi poss??vel verificar quais as informa????es das revistas mais s??o cobradas e reuni-las em um ??nico servi??o.</p>

            <p id="margem-unica">Buscando descrever aspectos essenciais da pol??tica editorial das revistas, campos adicionais foram criados com base em alguns crit??rios de 
            avalia????o de grandes diret??rios e indexadores e avaliadores nacionais e internacionais como Latindex, Scielo, DOAJ,  Redalyc, Web of Science, Scopus e Qualis 
            Capes. Ao final chegou-se ?? rela????o de 65 campos descritivos, que incluem dados cadastrais/de identifica????o e sobre a pol??tica editorial das revistas.</p>
        
        <h2><a id="DeOndeVieramAsInformacoes"><strong class="titulo-medio">De onde vieram as informa????es dos primeiros registros do Miguilim?</strong></a></h2>

            <p id="margem-unica">O Miguilim foi lan??ado com aproximadamente 3000 registros de revistas cient??ficas e portais de peri??dicos brasileiros pr??-cadastrados no 
            diret??rio. Em rela????o ??s revistas cient??ficas, os dados s??o provenientes de informa????es declaradas nas plataformas: Diadorim, Latindex, DOAJ, Portal ISSN, 
            Wikidata, Google Scholar Metrics, Sum??rio e a base do antigo e j?? desativado Portal de peri??dicos SEER. Estes dados foram coletados dessas bases, passaram por
            curadoria e ent??o importados ao Miguilim. Em rela????o aos portais de peri??dicos, estes foram mapeados pela equipe gestora e preenchidos manualmente.</p>
        
        <h2><a id="EmQualSoftware"><strong class="titulo-medio">Em qual software foi desenvolvido o Miguilim?</strong></a></h2>

            <p id="margem-unica">O Miguilim foi desenvolvido na vers??o 6.3 do software DSpace. O Dspace ?? um software de c??digo aberto desenvolvido pela Massachusetts Institute of 
            Technology (MIT).</p>

            <p id="margem-unica">A administra????o dos conte??dos descritos e depositados no Dspace segue estrutura de rela????o hier??rquica. O Dspace se organiza em tr??s 
            inst??ncias. Do mais espec??fico ao mais abrangente, tem-se: os ???Itens??? que s??o subordinados ??s "Cole????es" e que, por sua vez, s??o subordinadas as ???Comunidades???.  
            Por ser de administra????o centralizada o Miguilim possui apenas uma Comunidade, denominada ???Miguilim???. Subordinadas a esta Comunidade figuram as cole????es ???Portais de Peri??dicos??? e ???Revistas???, que abrigam os cadastros dos respectivos Itens de determinados portais de peri??dicos e revistas cient??ficas. </p>
            
            <p id="margem-unica">O DSpace permite um fluxo de dep??sito em que os pr??prios editores das revistas e os administradores dos portais de peri??dicos podem realizar
            o cadastro dos itens pelos quais s??o respons??veis e os administradores do Miguilim, posteriormente, revisam o cadastro antes de aceit??-lo e torn??-lo p??blico.</p>
            
            
        <h2><a id="ComoFuncionaOformulario"><strong class="titulo-medio">Como funciona o formul??rio de atualiza????o do Miguilim?</strong></a></h2>

            <p id="margem-unica">Uma das fun????es priorit??rias do Miguilim ?? manter um cadastro com informa????es atualizadas das revistas que comp??em. A interface para a 
            atualiza????o dos dados dispon??vel no DSpace n??o foi criada para contemplar as necessidades de usabilidade do usu??rio externo. Sendo assim, identificou-se a 
            necessidade de criar um formul??rio em que os pr??prios editores cient??ficos possam atualizar os dados das revistas que editam.</p>

            <p id="margem-unica">O formul??rio de atualiza????o ?? uma aplica????o externa que se comunica com o DSpace. Dessa forma, os dados que s??o atualizados no formul??rio de
            atualiza????o s??o exportados automaticamente para o cadastro da revista no Miguilim. Quando a atualiza????o do cadastro ?? feita a equipe gestora do Miguilim recebe um
            e-mail comunicando da atualiza????o do item, cabendo aos administradores a verifica????o dos dados informados e a realiza????o de corre????es, se necess??rio.</p>
        
        <h2><a id="OqueEoTermometro"><strong class="titulo-medio">O que ?? o Term??metro de Acesso Aberto?</strong></a></h2>

            <p id="margem-unica">O term??metro de Acesso Aberto tem como objetivo identificar o alinhamento das revistas cient??ficas brasileiras cadastradas no Miguilim aos 
            Movimentos de Acesso Aberto e de Ci??ncia Aberta. Para fazer esta medi????o, o term??metro utiliza como par??metro as respostas dadas pelo editor da revista a uma 
            s??rie de metadados, sendo poss??vel criar uma escala que mede o qu??o alinhada a revista est?? a estes Movimentos.	As revistas que cumprirem ao menos 80% dos 
            crit??rios de abertura definidos pela Equipe Miguilim receber??o um selo de publica????o em Acesso Aberto, que comprova os esfor??os realizados pela revista para 
            colocar a Ci??ncia ao alcance de todos.</p>

            <p id="margem-unica">A pontua????o indicada no term??metro leva em considera????o as respostas dadas a 22 campos do registro da revista. Estes campos dizem respeito ?? abertura do
            processo editorial da revista como um todo e relacionam-se ??s quest??es de transpar??ncia, dissemina????o e acesso aos conte??dos, direitos autorais, interoperabilidade,
            ??tica, dentre outros. Para cada um dos 22 campos a revista pode pontuar entre 0 (zero), 1 (um) ou 2 (dois) pontos, sendo 2 (dois) a pontua????o m??xima para cada um. 
            Deste modo, ao pontuar 2 (dois) em cada um dos 22 campos a revista atinge a pontua????o m??xima de 44 pontos. O selo ser?? atribu??do ??quelas revistas que marcarem 36 
            pontos ou mais, que corresponde a 80% da pontua????o m??xima.</p>
        
        <h2><a id="PorQueUmaColecaoDePortais"><strong class="titulo-medio">Por que existe uma cole????o de portais de peri??dicos?</strong></a></h2>

            <p id="margem-unica">Al??m de criar a cole????o de ???Revistas cient??ficas??? notou-se a necessidade de criar uma cole????o para os Portais de peri??dicos que abrigam as 
            revistas. Portais de peri??dicos, mais do que um simples agregador de revistas de uma institui????o, agem, muitas vezes, como uma inst??ncia institucional no 
            gerenciamento de revistas cient??ficas. Possuem equipes especializadas nos processos de gest??o de revistas e trabalham no sentido de gerar pol??ticas editoriais
            b??sicas para as revistas que agregam, treinar os editores cient??ficos no manuseio do software de gest??o de revistas e na implementa????o de ferramentas que aumentem
            a acessibilidade e a interoperabilidade das revistas. De forma geral buscam promover o acesso, a visibilidade, a seguran??a, a qualidade das revistas e o suporte
            aos editores dos peri??dicos cient??ficos. Com base na proximidade de prop??sitos adotados pelo Miguilim e visando o desenvolvimento e valoriza????o do trabalho 
            realizado nos portais de peri??dicos, a cria????o de uma cole????o dessas plataformas se tornou primordial.</p>

            <p id="margem-unica">A cole????o busca relacionar cada revista ao seu portal agregador, tra??ando uma responsabiliza????o pela revista al??m de criar um diret??rio dos
            portais com o intuito de aumentar a visibilidade dessas plataformas. Como tem prop??sitos mais b??sicos, o cadastro de portais de peri??dicos possui apenas quatorze
            campos.</p>

            <button class="btn-customizado"><a href="#TopoPerguntasFrequentes">Voltar</a></button>        
    </div>
</div>


</dspace:layout>

