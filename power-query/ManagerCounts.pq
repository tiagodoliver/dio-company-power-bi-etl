let
    ComGerente = Table.SelectRows(Employees,each [ManagerId] <> null),
    Agrupa = Table.Group(ComGerente,{"ManagerId","Gerente"},{{"ColaboradoresDiretos",each Table.RowCount(_),Int64.Type}})
in Agrupa