<%@ page import="br.ufscar.sead.loa.lidersim.remar.Projeto" %>



<div class="fieldcontain ${hasErrors(bean: projetoInstance, field: 'informacao', 'error')} required">
	<label for="informacao">
		<g:message code="projeto.informacao.label" default="Informacao" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="informacao" required="" value="${projetoInstance?.informacao}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projetoInstance, field: 'orcamento', 'error')} required">
	<label for="orcamento">
		<g:message code="projeto.orcamento.label" default="Orcamento" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="orcamento" required="" value="${projetoInstance?.orcamento}"/>
</div>

