let
    Tipos = Table.TransformColumnTypes(raw_works_on,{{"Pno",Int64.Type},{"Hours",type number}}),
    Emp = Table.NestedJoin(Tipos,{"Essn"},Employees,{"EmployeeId"},"Emp",JoinKind.LeftOuter),
    Nomes = Table.ExpandTableColumn(Emp,"Emp",{"Nome","Departamento","Gerente"},{"Colaborador","DepartamentoColaborador","Gerente"}),
    Proj = Table.NestedJoin(Nomes,{"Pno"},Projects,{"ProjectId"},"Proj",JoinKind.LeftOuter),
    Projetos = Table.ExpandTableColumn(Proj,"Proj",{"Projeto","Departamento"},{"Projeto","DepartamentoProjeto"}),
    Status = Table.AddColumn(Projetos,"SituacaoHoras",each if [Hours] = null then "Horas ausentes" else if [Hours] < 0 then "Horas negativas" else if [Hours] = 0 then "Zero - revisar" else "Informadas",type text),
    Renomeia = Table.RenameColumns(Status,{{"Essn","EmployeeId"},{"Pno","ProjectId"},{"Hours","Horas"}})
in Renomeia