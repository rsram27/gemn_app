<!--#include file="../ssi/parametros.asp" -->
<% 
idAgendamento = plic(trim(request("idAgendamento")))

if not isValidnumber(idAgendamento) then avisaerro "Agendamento inválido"

call cnopen(varDBApp, cn)

rsdados = fngetrows("select Data_Agendamento, Horario, Empresa from view_agendamentos where ID = " & idAgendamento, cn)
dataAgendamento = rsdados(inc(c), r)
horario = rsdados(inc(c), r)
empresaUsuario = rsdados(inc(c), r)

horario = completa(hour(horario),2,0) & ":" & completa(minute(horario),2,0) & ":" & completa(second(horario),2,0)

call cnopen(empresaUsuario, cnC)

sql = "update embarcacoes_agendamento set status = 'REALIZADO' where Id = " & idAgendamento & " and Data_Agendamento = '" & cnvdt(dataAgendamento) & "' and Horario = '" & horario & "'"
cnC.execute sql
	
call cnclose(cnC)
call cnclose(cn)

response.redirect "consulta.asp?msg=upd"
%>
