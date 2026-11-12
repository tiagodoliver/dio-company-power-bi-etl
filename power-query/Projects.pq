let
    Mescla = Table.NestedJoin(raw_project,{"Dnum"},raw_departament,{"Dnumber"},"Dept",JoinKind.LeftOuter),
    Expande = Table.ExpandTableColumn(Mescla,"Dept",{"Dname"},{"Departamento"}),
    Renomeia = Table.RenameColumns(Expande,{{"Pnumber","ProjectId"},{"Pname","Projeto"},{"Plocation","Local"},{"Dnum","DepartmentId"}}),
    Tipos = Table.TransformColumnTypes(Renomeia,{{"ProjectId",Int64.Type},{"DepartmentId",Int64.Type}})
in Tipos