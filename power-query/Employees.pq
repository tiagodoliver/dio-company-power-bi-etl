let
    Fonte = raw_employee,
    Tipos = Table.TransformColumnTypes(Fonte, {{"Salary", type number}, {"Dno", Int64.Type}}),
    Nome = Table.AddColumn(Tipos, "Nome", each Text.Combine({[Fname], [Minit], [Lname]}, " "), type text),
    PartesEndereco = Table.AddColumn(Nome, "Partes", each Text.Split([Address], "-")),
    Estado = Table.AddColumn(PartesEndereco, "Estado", each List.Last([Partes]), type text),
    Cidade = Table.AddColumn(Estado, "Cidade", each List.Last(List.RemoveLastN([Partes], 1)), type text),
    Rua = Table.AddColumn(Cidade, "Rua", each Text.Combine(List.RemoveLastN(List.Skip([Partes],1),2), "-"), type text),
    Numero = Table.AddColumn(Rua, "Numero", each List.First([Partes]), type text),
    MesclaDepartamento = Table.NestedJoin(Numero, {"Dno"}, raw_departament, {"Dnumber"}, "Dept", JoinKind.LeftOuter),
    ExpandeDepartamento = Table.ExpandTableColumn(MesclaDepartamento, "Dept", {"Dname"}, {"Departamento"}),
    MesclaGerente = Table.NestedJoin(ExpandeDepartamento, {"Super_ssn"}, Nome, {"Ssn"}, "Gestor", JoinKind.LeftOuter),
    ExpandeGerente = Table.ExpandTableColumn(MesclaGerente, "Gestor", {"Nome"}, {"Gerente"}),
    Nivel = Table.AddColumn(ExpandeGerente, "SituacaoGerencia", each if [Super_ssn] = null then "Topo da hierarquia" else if [Gerente] = null then "Gerente nao localizado" else "Com gerente", type text),
    Renomeia = Table.RenameColumns(Nivel, {{"Ssn","EmployeeId"},{"Super_ssn","ManagerId"},{"Dno","DepartmentId"},{"Salary","Salario"}}),
    Seleciona = Table.SelectColumns(Renomeia, {"EmployeeId","Nome","DepartmentId","Departamento","ManagerId","Gerente","SituacaoGerencia","Salario","Numero","Rua","Cidade","Estado"})
in Seleciona