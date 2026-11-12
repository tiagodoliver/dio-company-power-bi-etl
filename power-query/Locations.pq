let
    Mescla = Table.NestedJoin(raw_dept_locations,{"Dnumber"},raw_departament,{"Dnumber"},"Dept",JoinKind.LeftOuter),
    Expande = Table.ExpandTableColumn(Mescla,"Dept",{"Dname"},{"Departamento"}),
    Combinacao = Table.AddColumn(Expande,"DepartamentoLocal",each [Departamento] & " - " & [Dlocation],type text),
    Renomeia = Table.RenameColumns(Combinacao,{{"Dnumber","DepartmentId"},{"Dlocation","Local"}}),
    Tipos = Table.TransformColumnTypes(Renomeia,{{"DepartmentId",Int64.Type}})
in Tipos