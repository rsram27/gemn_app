<!--#include file="../ssi/parametros.asp" -->
<!--#include file="../ssi/head.asp" -->
<%
paginaArea = "GeMN APP - CLIENTE"
paginaTitulo = "AGENDAMENTOS"
paginaSubtitulo = "Consulte agendamentos realizados pelos clientes"
paginaBloqueiaReturn = true
paginaLinkCaminho = varApp & "menu.asp"
'somente acessa usuário do tipo C
if (session("tipoAcesso") <> "c") then response.redirect "../menu.asp"
%>
<!--#include file="../ssi/cabecalho.asp" -->
<!--#include file="../ssi/caminho.asp" -->
<div class="container">

	<%
	empresaUsuario = fngetstring("select empresa from view_usuarios where registro = " & session("idUsuario"), cn)
	empresaUsuario = "'" & replace(empresaUsuario, ", ", "','") & "'"
	%>

	<!--<h5>Informações</h5>-->
	<form action="agendamentos/inclusaoScript.asp" method="post" >
		<input type="hidden" name="empresaUsuario" id="empresaUsuario" value="">
		<div class="form-group">
			<label>*Embarcação:</label>
			<select class="form-control" name="embarcacao" id="embarcacao" required>
				<option value=""></option>
				<%
				listaSql = "select ID, XEmbarcacao " _
					& "from view_embarcacoes_clientes " _
					& "where empresa in (" & empresaUsuario & ") and registro = " & session("idUsuario") & " " _
					& "order by XEmbarcacao"
				listaRsDados = fngetrows(listaSql, cn)
				if (isarray(listaRsDados)) then
					for lr = 0 to ubound(listaRsDados,2)
						lc = 0
						listaID = listaRsDados(inc(lc), lr)
						listaTitulo = listaRsDados(inc(lc), lr)
						%>
						<option value="<%= listaID %>"><%= listaTitulo %></option>
						<%
					next
				else
					%>
					<option value="">Nenhuma embarcação encontrada.</option>
					<%
				end if
				%>
			</select>
		</div>
		<div class="alert alert-warning" style="padding:15px; display: none; font-weight: bold;" id="divEmpresa"></div>
		<div class="alert alert-warning" style="padding:15px; display: none;" id="divEmpresaSigla"></div>
		<div class="form-group">
			<label>*Data:</label>
			<input type="date" name="data" min="<%= year(date()) %>-<%= completa(month(date()),2,0) %>-<%= completa(day(date()),2,0) %>" class="form-control" required />
		</div>
		<div class="form-group">
			<label>*Horário:</label>
			<input type="time" name="hora" class="form-control" required />
		</div>
		<div class="form-group">
			<label>*Plano de navegação:</label>
			<textarea name="plano" class="form-control" required maxlength="255"></textarea>
		</div>
		<div class="form-group">
			<label>Carregar com:</label>
			<textarea name="carregar" class="form-control" maxlength="255"></textarea>
		</div>
		<div class="text-center">
			<button class="mq-btn w75 mb30">INCLUIR</button>
		</div>
		<div class="text-center">
			<a class="mq-btn w75 mq-bg-vermelho mq-btn-return">CANCELAR</a>
		</div>
	</form>
</div>
<!--#include file="../ssi/rodape.asp" -->
<script>
	$(document).ready(function($){
		$('#embarcacao').change(function () {
			var valor = $(this).val();
			if (valor == '') {
				$('#divEmpresa').hide();
				$("#empresaUsuario").val("");
			} else {
				$('#divEmpresa').load('../ajax/carregaEmpresaDaEmbarcacao.asp?escreve=nome&ID=' + valor);
				$('#divEmpresa').show();
				$('#divEmpresaSigla').load('../ajax/carregaEmpresaDaEmbarcacao.asp?escreve=sigla&ID=' + valor, function(data){
				  	var empresaUsuario = $('#divEmpresaSigla').html();
					$("#empresaUsuario").val(empresaUsuario);
				});
			}
		});
	});
</script>
<!--#include file="../ssi/rodapeBase.asp" -->
