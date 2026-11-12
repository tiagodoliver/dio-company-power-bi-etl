let
    Fonte = #table({"Dnumber", "Dlocation"}, {
        {1, "Houston"},
        {4, "Stafford"},
        {5, "Bellaire"},
        {5, "Sugarland"},
        {5, "Houston"}
    }),
    Tipos = Table.TransformColumnTypes(Fonte, {{"Dnumber", type number}, {"Dlocation", type text}})
in
    Tipos