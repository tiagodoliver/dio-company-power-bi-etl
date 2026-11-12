// Exemplo de origem para conexão futura; não é a fonte ativa da versão local.
// Criar pServidor como parâmetro de texto no Power Query.
// Substituir a expressão de raw_employee por este exemplo.
// Para as demais consultas raw_*, trocar Item pelo nome correspondente:
// departament, dept_locations, project, works_on e dependent.
let
    Banco = MySQL.Database(pServidor, "azure_company", [ReturnSingleDatabase=true]),
    Employee = Banco{[Schema="azure_company", Item="employee"]}[Data],
    Tipos = Table.TransformColumnTypes(Employee, {
        {"Fname", type text}, {"Minit", type text}, {"Lname", type text},
        {"Ssn", type text}, {"Salary", type number},
        {"Super_ssn", type text}, {"Dno", Int64.Type}, {"Address", type text}
    })
in
    Tipos
