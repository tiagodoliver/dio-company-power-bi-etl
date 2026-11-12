let
    Resultado = #table(type table [Verificacao=text, Ocorrencias=Int64.Type, Interpretacao=text], {
        {"Colaboradores sem superior",Table.RowCount(Table.SelectRows(Employees,each [ManagerId]=null)),"James E Borg: topo da hierarquia; preservar nulo"},
        {"Superior nao localizado",Table.RowCount(Table.SelectRows(Employees,each [ManagerId]<>null and [Gerente]=null)),"Zero esperado: referencias validas"},
        {"Departamento sem gerente",Table.RowCount(Table.SelectRows(Departments,each [ManagerId]=null or [Gerente]=null)),"Nenhuma imputacao necessaria"},
        {"Alocacoes com zero horas",Table.RowCount(Table.SelectRows(Assignments,each [Horas]=0)),"Preservar e sinalizar; nao inventar horas"},
        {"Horas nulas ou negativas",Table.RowCount(Table.SelectRows(Assignments,each [Horas]=null or [Horas]<0)),"Zero esperado"},
        {"IDs de colaborador duplicados",Table.RowCount(Employees)-Table.RowCount(Table.Distinct(Employees,{"EmployeeId"})),"Zero esperado"}
    })
in Resultado