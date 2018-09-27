<!--#include file="../ssi/parametros.asp" -->
<% 
empresaUsuario = plic(trim(request("empresaUsuario")))
embarcacao = plic(trim(request("embarcacao")))
data = plic(trim(request("data")))
hora = plic(trim(request("hora")))
plano = plic(trim(request("plano")))
carregar = plic(trim(request("carregar")))

if not isValid(empresaUsuario) then avisaerro "Informação obrigatória: Empresa da embarcação"
if not isValidnumber(embarcacao) then avisaerro "Informação obrigatória: Embarcação"
if not isValiddate(data) then avisaerro "Informação obrigatória: Data"
if not isValid(hora) then avisaerro "Informação obrigatória: Horário"
if not isValid(plano) then avisaerro "Informação obrigatória: Plano de navegação"
if len(plano) > 255 then avisaerro "Informe no máximo 50 caracteres no campo: Login"
if len(carregar) > 255 then avisaerro "Informe no máximo 50 caracteres no campo: Senha"

tipoAgendamento = "DESCIDA"
usuario = session("nomeUsuario")
solicitante = session("nomeUsuario")

call cnopen(empresaUsuario, cnC)

sql = "insert into embarcacoes_agendamento(Id_Embarcacoes, Usuario, Data_Agendamento, Horario, " _
	& "Solicitante, Observacao, TipoAgendamento, DestinoPrevisto) " _
	& "values(" & embarcacao & ", '" & usuario & "', '" & cnvdt(data) & "', '" & hora & "', " _
	& "'" & solicitante & "', '" & carregar & "', '" & tipoAgendamento & "', '" & plano & "')"
cnC.execute sql
	
call cnclose(cnC)

response.redirect "../menu.asp?msg=add"
%>
