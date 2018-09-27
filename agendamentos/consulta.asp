<!--#include file="../ssi/parametros.asp" -->
<!--#include file="../ssi/head.asp" -->
<%
paginaArea = "GeMN APP"
paginaTitulo = "AGENDAMENTOS"
paginaSubtitulo = "Consulte agendamentos realizados pelos clientes"
paginaBloqueiaReturn = true
paginaLinkCaminho = varApp & "menu.asp"
'somente acessa usuário do tipo F
if (session("tipoAcesso") <> "f") then response.redirect "../menu.asp"
%>
<!--#include file="../ssi/cabecalho.asp" -->
<!--#include file="../ssi/caminho.asp" -->
<div class="container">

	<%
	empresaUsuario = fngetstring("select empresa from view_usuarios where registro = " & session("idUsuario"), cn)
	empresaUsuario = "'" & replace(empresaUsuario, ", ", "','") & "'"
	%>

	<h5>Consulta de agendamentos</h5>
	<div class="mq-texto">
		<ul style="margin-left:12px; padding-left:0;" class="mb30">
			<li>Agendamentos: <b><%= fngetonevalue("select count(ID) from view_agendamentos where Empresa in (" & empresaUsuario & ")", cn) %></b></li>
			<li>Para hoje: <b><%= fngetonevalue("select count(ID) from view_agendamentos where Empresa in (" & empresaUsuario & ") and Data_Agendamento = '" & cnvdt(date()) & "'", cn) %></b></li>
			<li>Para semana: <b><%= fngetonevalue("select count(ID) from view_agendamentos where Empresa in (" & empresaUsuario & ") and WEEKOFYEAR(Data_Agendamento) = " & datepart("ww", date()), cn) %></b></li>
		</ul>
	</div>

	<h5>Próximos</h5>
    <div class="mq-nav-menu">
		<%
		sqlProximos = "select ID, XEmbarcacao, Data_Agendamento, Horario, Observacao, DestinoPrevisto, Nome " _
			& "from view_agendamentos " _
			& "where empresa in (" & empresaUsuario & ") " _
			& "order by Data_Agendamento"
		rsdados = fngetrows(sqlProximos, cn)
		if (isarray(rsdados)) then
			for r = 0 to ubound(rsdados,2)
				c = 0
				id = rsdados(inc(c), r)
				embarcacao = rsdados(inc(c), r)
				data = rsdados(inc(c), r)
				hora = rsdados(inc(c), r)
				carregar = rsdados(inc(c), r)
				plano = rsdados(inc(c), r)
				nome = rsdados(inc(c), r)

				hora = completa(hour(hora),2,0) & ":" & completa(minute(hora),2,0)
				%>
				<a data-menu="#metas_<%= id %>" data-slider="top" data-grupo="menu" data-close="true" data-close-cor="mq-cor-branca">
					<div>
						<div style="float:right; width:30px; text-align:right;"><i class="fa fa-eye fdt-cor-roxo"></i></div>
						<div style="float:left; width:30px;"><span style="border-radius:50%; background-color:#dddddd; text-align:center; display:inline-block; width:20px; height:20px; line-height:20px; font-size:11px;"><%= r + 1 %></span></div>
						<div style="float:left;"><b><%= embarcacao %></b><br /><span style="font-size:0.9em"><%= data %> às <%= hora %></span></div>
						<div style="clear:both;"></div>
					</div>
				</a>
				<%
			next
		else
			%>
			<div class="eof">Nenhum agendamento.</div>
			<%
		end if
		%>
	</div>


	<div class="text-center">
		<button class="mq-btn w100 mq-btn-return">RETORNAR</button>
	</div>
</div>

<%
if (isarray(rsdados)) then
	for r = 0 to ubound(rsdados,2)
		c = 0
		id = rsdados(inc(c), r)
		embarcacao = rsdados(inc(c), r)
		data = rsdados(inc(c), r)
		hora = rsdados(inc(c), r)
		carregar = rsdados(inc(c), r)
		plano = rsdados(inc(c), r)
		nome = rsdados(inc(c), r)

		hora = completa(hour(hora),2,0) & ":" & completa(minute(hora),2,0)
		%>
		<div id="metas_<%= id %>" class="dataslider mq-bg-corPadrao-claro " data-grupo="menu">
			<h4>DETALHES DO AGENDAMENTO</h4>
			<ul style="margin-left:12px; padding-left:0;" class="mb30">
				<li>Embarcação: <b><%= embarcacao %></b></li>
				<li>Data: <b><%= data %></b></li>
				<li>Horário: <b><%= hora %></b></li>
				<li>Nome: <b><%= nome %></b></li>
				<li>Plano de navegação: <b><%= plano %></b></li>
				<% if isvalid(carregar) then %><li>Carregar com: <b><%= carregar %></b></li><% end if %>
			</ul>
			<p><a href="agendamentos/barcoProntoScript.asp?idAgendamento=<%= id %>" class="mq-btn fdt-bg-dourado">Barco pronto!</a></p>
		</div>
		<%
	next
end if
%>

<!--#include file="../ssi/rodape.asp" -->
<!--#include file="../ssi/rodapeBase.asp" -->
