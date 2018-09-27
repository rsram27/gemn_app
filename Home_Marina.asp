<!--#include file="ssi/parametros.asp" -->
<!--#include file="ssi/head.asp" -->
<%
paginaArea = "GeMN APP"
paginaTitulo = "SUA EMPRESA"
paginaSubtitulo = "Dados da empresa, embarcações, faturamento, etc..."
paginaBloqueiaReturn = true
paginaLinkCaminho = varApp & "menu.asp"
'somente acessa usuário do tipo F
if (session("tipoAcesso") <> "f") then response.redirect "menu.asp"
%>
<!--#include file="ssi/cabecalho.asp" -->
<!--#include file="ssi/caminho.asp" -->
<div class="container">

	<h5>Dados da empresa</h5>
	<div class="mq-texto">
		<%
		empresaUsuario = fngetonevalue("select empresa from view_usuarios where registro = " & session("idUsuario"), cn)

		sql = "select razao, cnpj, telefone, endereco, numero, complemento, email " _
			& "from view_empresa " _
			& "where empresa = '" & empresaUsuario & "'"
		rsdados = fngetrows(sql, cn)
		if (isarray(rsdados)) then
			r = 0
			c = 0
			razao = rsdados(inc(c), r)
			cnpj = rsdados(inc(c), r)
			telefone = rsdados(inc(c), r)
			endereco = rsdados(inc(c), r)
			numero = rsdados(inc(c), r)
			complemento = rsdados(inc(c), r)
			email = rsdados(inc(c), r)
			%>
			<ul style="margin-left:12px; padding-left:0;" class="mb30">
				<li>Razão Social: <b><%= razao %></b></li>
				<li>CNPJ: <b><%= cnpj %></b></li>
				<% if (isvalid(email)) then %><li>E-mail: <b><%= email %></b></li><% end if %>
				<% if (isvalid(telefone)) then %><li>Telefone: <b><%= telefone %></b></li><% end if %>
				<% if (isvalid(endereco)) then %><li>Endereço: <b><%= endereco %>, <%= numero %>&nbsp;<%= complemento %></b></li><% end if %>
				<% if (isvalid(email)) then %><li>E-mail: <b><%= email %></b></li><% end if %>
			</ul>
			<%
		else
			%>
			<div class="alert alert-danger">Falha ao obter os dados.</div>
			<%
		end if
		%>
	</div>

	<h5>Estatísticas</h5>
	<div class="mq-texto">
		<%
		sql = "select TotalEmbarcacoes, TotalEmbarcacoesAtivas, TotalClientes, TotalClientesAtivos " _
			& "from view_empresa_detalhes " _
			& "where empresa = '" & empresaUsuario & "'"
		rsdados = fngetrows(sql, cn)
		if (isarray(rsdados)) then
			r = 0
			c = 0
			TotalEmbarcacoes = rsdados(inc(c), r)
			TotalEmbarcacoesAtivas = rsdados(inc(c), r)
			TotalClientes = rsdados(inc(c), r)
			TotalClientesAtivos = rsdados(inc(c), r)
			%>
			<ul style="margin-left:12px; padding-left:0;" class="mb30">
				<li>Clientes: <b><%= TotalClientesAtivos %></b></li>
				<li>Embarcações: <b><%= TotalEmbarcacoesAtivas %></b></li>
			</ul>
			<%
		else
			%>
			<div class="alert alert-danger">Falha ao obter os dados.</div>
			<%
		end if
		%>
	</div>

	<h5>Faturamento mensal</h5>
	<div class="mq-texto mb30">
		<%
		dataChart = ""
		sql = "select valor, mes_ano_vencimento " _
			& "from view_receitas " _
			& "where empresa = '" & empresaUsuario & "' " _
			& "order by mes_ano_vencimento"
		rsdados = fngetrows(sql, cn)
		if (isarray(rsdados)) then
			for r = 0 to ubound(rsdados,2)
				c = 0
				valor = formatnumber(rsdados(inc(c), r),2)
				mes_ano_vencimento = rsdados(inc(c), r)
				mes = retnrmesabr(right(mes_ano_vencimento, len(mes_ano_vencimento) - 5))
				ano = left(mes_ano_vencimento, 4)
				mes_ano_vencimento = ucase(mes)&"/"&ano

				dataChart = dataChart & "['" & mes_ano_vencimento & "', " & cnvvl(valor) & "]"
				if (r < ubound(rsdados,2)) then dataChart = dataChart & ","
			next
			%>
			<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
			<script type="text/javascript">
				google.charts.load('current', { 'packages': ['corechart'] });
				google.charts.setOnLoadCallback(drawChart);
				function drawChart() {
					var data = google.visualization.arrayToDataTable([
					['Mes/Ano', 'Receitas'],
					<%= dataChart %>
					]);
					var options = {
						title: '',
						legend: { position: 'none' },
						series: [
						  {color: 'blue', visibleInLegend: false}
						],
						backgroundColor: '#F9F9F9',
						chartArea: {
							left: 70,
							top: 20,
							width: '100%'
						}
					};
					var chart = new google.visualization.LineChart(document.getElementById('curve_chart_receitas'));
					chart.draw(data, options);
				}
			</script>
			<div id="curve_chart_receitas" style="width:100%;"></div>
			<%
		else
			%>
			<div class="alert alert-danger">Falha ao obter os dados.</div>
			<%
		end if
		%>
	</div>

	<h5>Despesas mensais</h5>
	<div class="mq-texto mb30">
		<%
		dataChart = ""
		sql = "select valor, mes_ano_vencimento " _
			& "from view_despesas " _
			& "where empresa = '" & empresaUsuario & "' " _
			& "order by mes_ano_vencimento"
		rsdados = fngetrows(sql, cn)
		if (isarray(rsdados)) then
			for r = 0 to ubound(rsdados,2)
				c = 0
				valor = formatnumber(rsdados(inc(c), r),2)
				mes_ano_vencimento = rsdados(inc(c), r)
				mes = retnrmesabr(right(mes_ano_vencimento, len(mes_ano_vencimento) - 5))
				ano = left(mes_ano_vencimento, 4)
				mes_ano_vencimento = ucase(mes)&"/"&ano

				dataChart = dataChart & "['" & mes_ano_vencimento & "', " & cnvvl(valor) & "]"
				if (r < ubound(rsdados,2)) then dataChart = dataChart & ","
			next
			%>
			<script type="text/javascript">
				google.charts.load('current', { 'packages': ['corechart'] });
				google.charts.setOnLoadCallback(drawChart);
				function drawChart() {
					var data = google.visualization.arrayToDataTable([
					['Mes/Ano', 'Despesas'],
					<%= dataChart %>
					]);
					var options = {
						title: '',
						legend: { position: 'none' },
						series: [
						  {color: 'red', visibleInLegend: false}
						],
						backgroundColor: '#F9F9F9',
						chartArea: {
							left: 70,
							top: 20,
							width: '100%'
						}
					};
					var chart = new google.visualization.LineChart(document.getElementById('curve_chart_despesas'));
					chart.draw(data, options);
				}
			</script>
			<div id="curve_chart_despesas" style="width:100%;"></div>
			<%
		else
			%>
			<div class="alert alert-danger">Falha ao obter os dados.</div>
			<%
		end if
		%>
	</div>
	


	<h5>Número de Descidas</h5>
	<div class="mq-texto mb30">
		<%
	'MADE BY RV
		dataChart = ""
		sql = "select Num_descidas, mes_ano_agenda " _
			& "from view_descidas " _
			& "where empresa = '" & empresaUsuario & "' " _
			& "order by mes_ano_agenda"

		rsdados = fngetrows(sql, cn)
		if (isarray(rsdados)) then
			for r = 0 to ubound(rsdados,2)
				c = 0
				'valor = formatnumber(rsdados(inc(c), r),2)
				descidas = rsdados(inc(c),r)
				mes_ano_agenda = rsdados(inc(c), r)
				mes = retnrmesabr(right(mes_ano_agenda, len(mes_ano_agenda) - 5))
				ano = left(mes_ano_agenda, 4)
				mes_ano_agenda = ucase(mes)&"/"&ano

				dataChart = dataChart & "['" & mes_ano_agenda & "', " & descidas & "]"
				if (r < ubound(rsdados,2)) then dataChart = dataChart & ","
			next
			%>
			
			<script type="text/javascript">
				google.charts.load('current', { 'packages': ['corechart'] });
				google.charts.setOnLoadCallback(drawChart);
				function drawChart() {
					var data = google.visualization.arrayToDataTable([
					['Mes/Ano', 'Descidas'],
					<%= dataChart %>
					]);
					var options = {
						title: '',
						legend: { position: 'none' },
						series: [
						  {color: 'green', visibleInLegend: false}
						],
						backgroundColor: '#F9F9F9',
						chartArea: {
							left: 70,
							top: 20,
							width: '100%'
						}
					};
					var chart = new google.visualization.LineChart(document.getElementById('curve_chart_descidas'));
					chart.draw(data, options);
				}
			</script>
			<div id="curve_chart_descidas" style="width:100%;"></div>
			<%
		else
			%>
			<div class="alert alert-danger">Falha ao obter os dados.</div>
			<%
		end if
		%>
	</div>
	
	<div class="text-center">
		<button class="mq-btn w100 mq-btn-return">RETORNAR</button>
	</div>


</div>
<!--#include file="ssi/rodape.asp" -->
<!--#include file="ssi/rodapeBase.asp" -->
