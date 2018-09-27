<!--#include file="ssi/parametros.asp" -->
<!--#include file="ssi/head.asp" -->
<%
paginaArea = "GeMN APP"
paginaTitulo = "SEUS CLIENTES"
paginaSubtitulo = "Dados dos clientes, estatisticas, valores "
paginaBloqueiaReturn = true
paginaLinkCaminho = varApp & "menu.asp"

'somente acessa usuário do tipo F
if (session("tipoAcesso") <> "f") then response.redirect "menu.asp"
%>
<!--#include file="ssi/cabecalho.asp" -->
<!--#include file="ssi/caminho.asp" -->
<div class="container">

	<h5>Estatísticas dos Clientes</h5>
	<div class="mq-texto">
		<%
		'Seleciona embarcacoes e clientes Ativos e inativos 
		'E joga os dados na estatisticas 
		empresaUsuario = fngetonevalue("select empresa from view_usuarios where registro = " & session("idUsuario"), cn)
		sql = "select totalEmbarcacoesAtivas, totalEmbarcacoes, TotalClientes, TotalClientesAtivos " _
			& "from view_empresa_detalhes " _
			& "where empresa = '" & empresaUsuario & "'"
		rsdados = fngetrows(sql, cn)
		if (isarray(rsdados)) then
			r = 0
			c = 0
			totalEmbarcacoesAtiva = rsdados(inc(c), r)
			totalEmbarcacoes = rsdados(inc(c), r)
			TotalClientes = rsdados(inc(c), r)
			TotalClientesAtivos = rsdados(inc(c), r)

			totalEmbarcacoesInativas = (cint(totalEmbarcacoes) - cint(totalEmbarcacoesAtiva))
			totalClientasInativos = (cint(TotalClientes) - cint(TotalClientesAtivos))
			%>

			<ul style="margin-left:12px; padding-left:0;" class="mb30">
				<li>Clientes Ativos: <b><%= TotalClientesAtivos %></b></li>
				<li>Clientes Inativos: <b><%= totalClientasInativos %></b></li>
				<li>Embarcações Ativas: <b><%= totalEmbarcacoesAtiva %></b></li>
				<li>Embarcações Inativas: <b><%= totalEmbarcacoesInativas %></b></li>
				<!--<% if (isvalid(email)) then %><li>E-mail: <b><%= email %></b></li><% end if %>-->
			</ul>
			
			<%
		else
			%>
			<div class="alert alert-danger">Falha ao obter os dados.</div>
			<%
		end if
		%>
	</div>


	<h5>Clientes</h5>
	<div class="mq-texto">
	<div name="teste" method="post" class="container well center-block">
			<div class="form-group">
				<select id ='mesAno' value='%' name='mesAno' class="form-control" placeholder="Selecione uma data">
				 	<option selected='true' disabled value='%'>Selecione uma data</option>
					<%	
						'Monta o combbox de lista 
						sql = "select distinct  `mes_ano_cliente` " _
						& "from view_clientes " _
						& "where empresa = '" & empresaUsuario & "'"
						rsdados = fngetrows(sql, cn)
					if (isarray(rsdados)) then
						for r = 0 to ubound(rsdados,2)
							c = 0 
							'FORMATA PRA SAIR BONITO NA LISTA
							mes_ano_vencimento = rsdados(inc(c), r)
							mes = retnrmesabr(right(mes_ano_vencimento, len(mes_ano_vencimento) - 5))
							ano = left(mes_ano_vencimento, 4)
							'USA O VALOR NORMAL NA TAG DO HTML PRA EU USAR NA QUERY DEPOIS 
							value_mes_ano = mes_ano_vencimento
							mes_ano_vencimento = ucase(mes)&"/"&ano
						
					%>
						<option value = '<%= value_mes_ano %>' ><%= mes_ano_vencimento %></option>
					<%
						next 
					else
					%>

					<%
					end if 
					%>
				</select>
			</div>
			
			<div class="form-group form-group-lg">
				<input name="nomePesquisa" id="nome" type="text" placeholder="Digite um nome.." class="form-control" id="formGroupInputSmall">
			</div>

	</div>
	
	<%
	if Request.Form("btnSubmit") <> "" then
		'Jooga na sessão "VariavelGlobal" o parametro pra quando der reload usar na query
		session("clienteBuscado") = Request.form("nomePesquisa")
		session("dataBuscada") = Request.form("mesAno")
		if session("dataBuscada") = "" then session("dataBuscada") = "%"
		geraView()
	else
		'Joga no parametro branco pra trazer todos os clientes
		session("clienteBuscado") = ""
		session("dataBuscada") = "%"
		geraView()
	end if 
	
	sub GeraView()
		'made by RV
		'Fiz essa função pra trazer a view com os paremtros dos inputs html
		'Executa um select e preenche uma table com os dados 

			clienteBuscado = session("clienteBuscado") 
			dataBuscada = session("dataBuscada") 
			sql = "select Cod_Cliente,Nome_Cliente,ValorTotal,ValorPendente,mes_ano_cliente " _
				& "from view_clientes " _
				& "where empresa = '" & empresaUsuario & "' "  _
				& " AND Nome_cliente like '%" & clienteBuscado & "%' " _
				& " AND mes_ano_cliente like '" &  dataBuscada &  "'"

			rsdados = fngetrows(sql, cn)
			'VERIFICA SE TEM DADOS NO SELECT  
			if (isarray(rsdados)) then 
				'VERIFICA SE É PRA PEGAR TODOS , SE SIM ESCREVE A DATA NA TELA !
				if dataBuscada <> "%" then
					mes_ano_vencimento = dataBuscada
					mes = retnrmesabr(right(mes_ano_vencimento, len(mes_ano_vencimento) - 5))
					ano = left(mes_ano_vencimento, 4)
					mes_ano_vencimento = ucase(mes)&"/"&ano
				%>
					<h4 class='text-center'> 
						<strong class='col-md-1'>Data: <%=mes_ano_vencimento%></strong>
					</h4>
				<%
				end if 
			%>
				<!-- monta o cabeçalho da tabela -->
				<div class="mq-nav-menu table">
					<table class="table table-striped">
						<thead>
							<th>Cliente</th>
							<th>Data</th>
							<th>Valor</th>
							<th>Pendente</th>
						</thead>
			<%

				for r = 0 to ubound(rsdados,2)
					c = 0
					ID_Cliente = rsdados(inc(c), r)
					nome =  rsdados(inc(c), r)
					valor = formatnumber(rsdados(inc(c), r),2)
					Pendente = formatnumber(rsdados(inc(c), r),2)
					mes_ano_vencimento = rsdados(inc(c), r)
					mes_ano = mes_ano_vencimento
					mes = retnrmesabr(right(mes_ano_vencimento, len(mes_ano_vencimento) - 5))
					ano = left(mes_ano_vencimento, 4)
					mes_ano_vencimento = ucase(mes)&"/"&ano

					%>
						<!-- monta as linhas  da tabela com os dados do recordset -->
						<tr class='d-none visivel' data-opt = "" data-nome="<%= lcase(nome) %>" data-mesano="<%= mes_ano %>"  data-menu="#metas_<%= ID_Cliente %>" data-slider="top" data-grupo="clientes" data-close="true" data-close-cor="mq-cor-branca" style="display: table-row;">
							<td><%= nome %></td>
							<td id="mesAno"><%= mes_ano_vencimento %></td>		
							<td id="valorCli"><%= valor %></td>
							<td id="pendenteCli"><%= Pendente %></td>								
						</tr>
						
					<%
				next

				if c > 2 then
					'SE TIVER MAIS 1 DE DADO , ENTão coloca a soma total , se não nao precisa.
					sql = "Select sum(ValorTotal),sum(ValorPendente) from " &  split(sql,"from")(1)
					rsdados = fngetrows(sql, cn)
					if (isarray(rsdados)) then 
						r = 0
						c = 0 
						valor = formatnumber(rsdados(inc(c), r),2)
						pendente = formatnumber(rsdados(inc(c), r),2)
					%>
						<!-- Escreve o total das colunas no final da tabela  -->
						<tr id='totais' style="display:;" class='d-none'>
							<td><strong>Total</strong></td>
							<td> </td>
							<td id='valorTotal'><strong><%= valor %></strong></td>
							<td id='pendenteTotal'><strong><%= Pendente %></strong></td>
						</tr>
					<%
					else 	
					%>
				<%
					End if
				end if 
				%>
					</table>
				</div>
				<%
			else
				%>
				<!-- Mensagem exibida se não econtrar dados -->
				<div class="alert alert-danger">Falha ao obter os dados.</div>
				<%
			end if
		end sub
		%>
	</div>
	<div class="text-center">
		<button class="mq-btn w100 mq-btn-return">RETORNAR</button>
	</div>
</div>


	<%
	'Aqui eu jogo o valor dos "Alertas" que surgem quando clicas nas linhas da tabela
	'O bootstrap funciona assim , temos todos os dados no final da pagina 
	'Ao clicar ele sobe essa div referente a linha clicada 


	  sql = " SELECT `cod_Cliente`,`TipoPessoa`,date_format(`DataCadastro`,'%m\/%Y') as `DataCadastro`, " _ 
	  & "date_format(`DataNascimento`,'%d\/%m\/%Y') as `DataNascimento`,`Nome`,`Fantasia`, " _ 
	  & "`Cidade`,`Cel1`,`Email`,IF(`AcessoApp` = 1,'SIM','NÃO') as `AcessoApp`,`FormaPagto`  " _ 
	  & "from view_clientes_detalhes  " _ 
	  & "where `empresa` = '" &  empresaUsuario & "'"  

	
	rsdados = fngetrows(sql, cn)

	if (isarray(rsdados)) then
		for r = 0 to ubound(rsdados,2)
			c = 0
			idCliente = rsdados(inc(c), r)
			tipoPessoa =  rsdados(inc(c), r)
			dataCadastro  =  rsdados(inc(c), r)
			dataNascimento =  rsdados(inc(c), r)
			nome =  rsdados(inc(c), r)
			fantasia =  rsdados(inc(c), r)
			idade =  rsdados(inc(c), r)
			cel1 =  rsdados(inc(c), r)
			email =  rsdados(inc(c), r)
			acessoApp =  rsdados(inc(c), r)
			formaPagto =  rsdados(inc(c), r)
			%>

			<div id="metas_<%= idCliente %>" class="dataslider mq-bg-corPadrao-claro " data-grupo="clientes">
				<h4>DETALHES DO CLIENTE</h4>
				<ul style="margin-left:12px; padding-left:0;" class="mb30">
					<li>Pessoa: <b><%= tipoPessoa %></b></li>
					<li>Cadastro: <b><%=  dataCadastro   %></b></li>
					<li>Nascimento: <b><%=  dataNascimento %></b></li>
					<li>Nome: <b><%=  nome %></b></li>
					<li>Nome Fantasia: <b><%=  fantasia %></b></li>
					<li>Idade: <b><%=  idade %></b></li>
					<li>Celular: <b><%=  cel1 %></b></li>
					<li>Email: <b><%=  email %></b></li>
					<li>Acesso App: <b><%=  acessoApp %></b></li>
					<li>Forma Pagamento: <b><%=  formaPagto %></b></li>
				</ul>
			</div>
			<%
		next
	end if
	%>


	<!--#include file="ssi/rodape.asp" -->
	<script type="text/javascript">

	$(function () {
		$.fn.isVisible = function() {
		return this.not(':hidden') &&
			this.css('visibility') !== 'hidden' &&
			this.css('opacity') != 0;
		}

		//declare function 
		$.fn.filtrar = function () {
			$("[data-mesano]").removeClass("visivel");
			$("[data-mesano]").addClass("invisivel").hide();
			$data = $("#mesAno").val();
			$nome = $("#nome").val().toLowerCase();
			findByDate = "[data-mesano='" + $data + "']"
			findByName = "[data-nome*='"+$nome+"']"
			
			//Esta todos escondidos , se a data não for nula
			if ($data !== null)	{
				//Mostro todos da data
				//alert(findByDate);
				$(findByDate).removeClass("invisivel").addClass("visivel").show();
				if ($nome !== "")
					//se o nome for diferente de branco entao
					//escondo todos aqueles que não contem o texto do input
					 $("[data-nome]").not(findByName).removeClass("visivel").addClass("invisivel").hide();
				
			}else{
				//Não tem filtro de data então é só mostrar os nomes 
				if ($nome == "") {
					//Se for nulo , não existe filtros , mostra tudo 
					$("[data-nome]").removeClass("invisivel").addClass("visivel").show();
				}else {
					//Mostra todos que contem o input nome 
					$(findByName).removeClass("invisivel").addClass("visivel").show();
				}
			}


			$valorTotal = 0;
			$pendenteTotal = 0;
			$contador = 0;
			$("[data-nome]").each(function(){
				//Faz a soma total dos que estão visiveis 
				if ($(this).hasClass("invisivel")){
					// se tiver invisivel nao faz nada 
					return;
				}else{
					$valorTotal += parseInt($(this).children("#valorCli").text().replace(".","").replace(",",""));
					$pendenteTotal += parseInt($(this).children("#pendenteCli").text().replace(".","").replace(",",""));		
					$contador ++;
				}
			});
			if ($contador > 0) {
				$("#totais").show();
				$("#totais").attr("style","display: true");
				if ($valorTotal == 0) $valorTotal = "000";
				strValTot = "" + $valorTotal
				$valorTotal = strValTot.substr(0,strValTot.length-2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + "," + strValTot.substr(strValTot.length-2,2)
				if ($pendenteTotal == 0)  $pendenteTotal = "000";
				strValTot ="" +  $pendenteTotal				
				$pendenteTotal = strValTot.substr(0,strValTot.length-2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + "," + strValTot.substr(strValTot.length-2,2)
				$("#valorTotal").find("strong").text($valorTotal);
				$("#pendenteTotal").find("strong").text($pendenteTotal);
				
			}else{
				$("#totais").attr("style","display: none");
			}
		}	
			
	});



	$("#mesAno").change(function(){
		$(this).filtrar();
	});

	$("#nome").keyup(function(){
		$(this).filtrar();
	});



	</script>
<!--#include file="ssi/rodapeBase.asp" -->
