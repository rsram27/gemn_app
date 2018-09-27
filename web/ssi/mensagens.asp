<%
'vermelhos
if (msg = "dne") then call mensagem("danger", "Dados não encontrados. Tente novamente.")
if (msg = "t") then call mensagem("danger", "Time-out! Faça o login novamente.")
if (msg = "fs") then call mensagem("danger", "Senha incorreta.")

'amarelos
if (msg = "del") then call mensagem("warning", "Registro excluído com sucesso.")


'verdes
if (msg = "se") then call mensagem("success", "Desconectado com sucesso.")
if (msg = "add") then call mensagem("success", "Informação adicionada com sucesso.")
if (msg = "upd") then call mensagem("success", "Informação atualizada com sucesso.")
%>
