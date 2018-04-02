<%@ page import="br.ufscar.sead.loa.lidersim.remar.Anotacao" %>



<div class="fieldcontain ${hasErrors(bean: anotacaoInstance, field: 'informacao', 'error')} required">
	<label for="informacao">
		<g:message code="anotacao.informacao.label" default="Informacao" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="informacao" required="" value="${anotacaoInstance?.informacao}"/>

</div>

