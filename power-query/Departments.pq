let
    Fonte = raw_departament,
    Mescla = Table.NestedJoin(Fonte, {"Mgr_ssn"}, Employees, {"EmployeeId"}, "Gestor", JoinKind.LeftOuter),
    Expande = Table.ExpandTableColumn(Mescla, "Gestor", {"Nome"}, {"Gerente"}),
    Tipos = Table.TransformColumnTypes(Expande, {{"Dnumber",Int64.Type},{"Mgr_start_date",type date}}, "en-US"),
    Renomeia = Table.RenameColumns(Tipos, {{"Dnumber","DepartmentId"},{"Dname","Departamento"},{"Mgr_ssn","ManagerId"},{"Mgr_start_date","InicioGestao"}}),
    Resultado = Table.SelectColumns(Renomeia,{"DepartmentId","Departamento","ManagerId","Gerente","InicioGestao"})
in Resultado