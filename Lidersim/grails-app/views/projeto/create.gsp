<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'projeto.label', default: 'Projeto')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:external dir="css" file="projeto.css"/>
		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<g:javascript src="projeto.js" />

		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	</head>

	<body>
        <g:uploadForm  method="POST" controller="design" action="imagesManager">
            <input type="hidden" id="orientacao" name="orientacao" value="${orientacao}">
            <form class="col s12">
                 <fieldset class="form"  style="border:none"  >
                    <div class="row">
                        <div class="col s12">
                            <ul class="collapsible" data-collapsible="accordion">
                                <li>
                                    <div class="collapsible-header active"><i class="material-icons">info</i>Informação sobre a criação do projeto</div>
                                    <div class="collapsible-body">
                                        <p class="justify-text">O projeto deve ser escrito de modo claro e objetivo.</p>
                                    </div>
                                </li>
                            </ul>
                            <div class="input-field col s12">
                                <span id="anot">Insira o passo a passo* </span>
                             </div>
                            <div class="row">
                                <div class="input-field col s12">
                                    <g:textArea name="informacao" required="" value="${projetoInstance?.informacao}"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s12">
                                    <g:textField name="orcamento" required="" value="${projetoInstance?.orcamento}"/>
                                </div>
                            </div>
                        </div>
                 </fieldset>
            </form>
        </g:uploadForm>
    </body>
</html>
