<%@ page import="br.ufscar.sead.loa.lidersim.remar.Projeto" %>
<!DOCTYPE html>
<html>
	<head>
		<g:external dir="css" file="projeto.css"/>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'projeto.label', default: 'Projeto')}" />
		<title>LabTeca</title>
		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<g:javascript src="projeto.js" />
		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	</head>
	<body>
		<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				Customização - Projeto
			</p>
		</div>
            <div class="row">
                <div style=" margin-bottom: 10px; color:#333333">
                    Aqui você pode gerar, alterar e deletar projetos.
                </div>

                <div id="chooseProjeto" class="col s12 m12 l12">
                    <br>
                    <div class="row">
                         <div class="col s6 m3 l3 offset-s6 offset-m9 offset-l9">
                             <input  type="text" id="SearchLabel" placeholder="Buscar projeto"/>
                         </div>
                         </div>
                     </div>
                    <div class="row">
                        <div class="col s12 m12 l12">
                            <table class="highlight" id="table" style="margin-top: -30px;">
                                <thead>
                                <tr>
                                    <th>Selecionar
                                        <div class="row" style="margin-bottom: -10px;">
                                            <button style="margin-left: 3px; background-color: #795548" class="btn-floating tooltipped" id="BtnCheckAll" onclick="check_all()"
                                                    data-position="right" data-delay="50" data-tooltip="Selecionar Todos">
                                                <i class="material-icons">check_box_outline_blank</i>
                                            </button>
                                            <button style="margin-left: 3px; background-color: #795548" class="btn-floating " id="BtnUnCheckAll" onclick="uncheck_all()"
                                                    data-position="right" data-delay="50" data-tooltip="Desmarcar Todos">
                                                <i class="material-icons">done</i>
                                            </button>
                                        </div>
                                    </th>
                                    <th id="titleLabel">Projeto <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
                                    <th>Ação <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${projetoInstanceList}" status="i" var="projetoInstance">
                                    <tr id="tr${projetoInstance.id}" class="selectable_tr" style="cursor: pointer;"
                                        data-id="${fieldValue(bean: projetoInstance, field: "id")}" data-owner-id="${fieldValue(bean: projetoInstance, field: "ownerId")}"
                                        data-checked="false">
                                        <td class="_not_editable">
                                            <input style="background-color: #727272" id="checkbox-${projetoInstance.id}" class="filled-in" type="checkbox">
                                            <label for="checkbox-${projetoInstance.id}"></label>
                                        </td>
                                        <td>${fieldValue(bean: projetoInstance, field: "informacao")}</td>
                                        <td> <i style="color: #5D4037 !important; margin-right:10px;" class="fa fa-pencil" onclick="_modal_edit($(this.closest('tr')))" ></i>
                                        </td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s1 m1 l1 offset-s4 offset-m8 offset-l8">
                            <a data-target="createModal" name="create" class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped" data-tooltip="Criar projeto"><i class="material-icons">add</i></a>
                        </div>
                        <div class="col s1 offset-s1 m1 l1">
                            <a name="delete" class="btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exluir projeto" ><i class="material-icons" onclick="_open_modal_delete()">delete</i></a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s2">
                            <button class="btn waves-effect waves-light remar-orange" name="save" id="submitButton" onclick="_submit()">Enviar</button>
                        </div>
                    </div>
                    <div id="editModal" class="modal remar-modal">
                        <g:form name="edit-projeto" method="PUT" url="[resource:projetoInstance, action:'update']">
                            <div class="modal-content">
                                <h4>Edição de Projeto</h4>
                                <div class="row">
                                    <div class="content scaffold-create" role="main">
                                        <div class="row">
                                            <div class="input-field col s12">
                                                <textarea required id="editProjeto" class="materialize-textarea validate"
                                                          name="projeto" class="validate" length="1000" maxlength="1000"
                                                          placeholder="Insira o Passo a Passo..."></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" id="ProjetoID" name="ProjetoID">
                            </div>
                            <div class="modal-footer">
                                <g:submitButton name="update" class="btn btn-success btn-lg my-orange" value="Salvar" />
                                <a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">Fechar</a>
                            </div>
                        </g:form>
                    </div>
                    <div id="createModal" class="modal remar-modal">
                        <g:form name="create-projeto" url="[resource:projetoInstance, action:'save']" >
                            <div class="modal-content">
                                <h4>Criar Projeto</h4>
                                <div class="row">
                                    <div class="content scaffold-create" role="main">
                                        <div class="row">
                                            <div class="input-field col s12">
                                                <textarea required id="informacao" class="materialize-textarea"
                                                          name="informacao" class="validate" length="1000" maxlength="1000"
                                                          placeholder="Insira o Passo a Passo..."></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <a class="btn waves-effect waves-light remar-orange" onclick="document.getElementById('create-projeto').submit()">Criar</a>
                                <a class="btn waves-effect waves-light modal-close remar-orange" href="#!">Cancelar</a>
                            </div>
                        </g:form>
                    </div>
                    <div id="deleteModal" class="modal">
                        <div class="modal-content">
                            <div id="delete-one-question">
                                Você tem certeza que deseja excluir esse projeto?
                            </div>
                            <div id="delete-several-questions">
                                Você tem certeza que deseja excluir esses projetos?
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn waves-effect waves-light modal-close my-orange" onclick="_delete()" style="margin-right: 10px;">Sim</button>
                            <button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Não</button>
                        </div>
                    </div>
                    <div id="erroDeleteModal" class="modal">
                        <div class="modal-content">
                            Você deve selecionar ao menos um projeto para excluir.
                        </div>
                        <div class="modal-footer">
                            <button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
                        </div>
                    </div>
                    <div id="errorSaveModal" class="modal">
                        <div class="modal-content">
                            Você deve selecionar pelo menos um projeto para enviar.
                        </div>
                        <div class="modal-footer">
                            <button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
                        </div>
                    </div>
                </div>
	</body>
</html>