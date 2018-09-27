<div class="mq-caminho">
	<div class="mq-caminho-item">
		<a<% if (isvalid(paginaLinkCaminho)) then %> href="<%= paginaLinkCaminho %>"<% end if %> class="mq-iconeCaminho <% if (not paginaBloqueiaReturn) then %>mq-return<% end if %>"><i class="fa fa-<% if (isvalid(paginaIconeTitulo)) then %><%= paginaIconeTitulo %><% else %>chevron-left<% end if %>"></i></a>
		<h1><%= paginaTitulo %>
			<span><%= paginaSubtitulo %></span>
		</h1>
	</div>
	<div class="mq-caminho-item">
		<a data-filtro="true" data-item="#filtro"><i class="fa fa-filter mq-cor-vermelho"></i></a>
		<a data-filtro="true" data-item="#filtro2"><i class="fa fa-plus mq-cor-vermelho"></i></a>
	</div>
	<div id="filtro" class="filtro">
		<form>
			<div class="row">
				<div class="col-xs-6">
					<div class="checkbox">
						<label>
							<input type="checkbox">
							Opção
						</label>
					</div>
					<div class="checkbox">
						<label>
							<input type="checkbox">
							Opção
						</label>
					</div>
				</div>
				<div class="col-xs-6">	
					<div class="form-group">
						<label>Envolvidos</label>
						<select class="form-control">
							<option value=""></option>
							<option value="">Opção 1</option>
							<option value="">Opção 2</option>
						</select>
					</div>
				</div>
			</div>
			<button class="mq-btn mq-btn-sm w100">filtrar</button>
		</form>
	</div>
	<div id="filtro2" class="filtro">
		<form>
			<div class="row">
				<div class="col-xs-6">	
					<div class="form-group">
						<label>Envolvidos</label>
						<select class="form-control">
							<option value=""></option>
							<option value="">Opção 1</option>
							<option value="">Opção 2</option>
						</select>
					</div>
				</div>
			</div>
			<button class="mq-btn mq-btn-sm w100">filtrar</button>
		</form>
	</div>
</div>