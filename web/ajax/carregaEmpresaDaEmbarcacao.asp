<!--#include file="../ssi/parametros.asp" -->
<% 
ID = plic(trim(request("ID")))
escreve = plic(trim(request("escreve")))

call cnopen(varDBApp, cn)

if (escreve = "nome") then
	campo = "e.razao"
elseif (escreve = "sigla") then
	campo = "e.empresa"
end if
sql = "select " & campo & " " _
	& "from view_empresa e " _
	& "inner join view_embarcacoes_clientes ec on e.empresa = ec.Empresa " _
	& "where ec.ID = " & ID & " " _
	& "and ec.Registro = " & session("idUsuario")
response.write fngetonevalue(sql, cn)
	
call cnclose(cnC)
%>