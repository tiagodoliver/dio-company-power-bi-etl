# Transformações e decisões

1. Cabeçalhos: preservados nas consultas raw; nomes claros nas sete tabelas finais. IDs SSN são texto, sem uso como métricas.
2. Salário e horas: Power Query 	ype number e modelo double (decimal de ponto flutuante). Não foi atribuída moeda ou periodicidade que a fonte não fornece.
3. Nulos: Super_ssn de James E Borg foi preservado, pois representa o topo da hierarquia. Não excluir o colaborador nem inventar superior.
4. Os três departamentos possuem gerente válido. Nenhuma lacuna foi preenchida artificialmente.
5. Há 16 alocações, 275 horas e uma alocação de James em Reorganization com zero horas. Zero foi sinalizado para revisão, não tratado como ausência nem substituído por 40.
6. Endereço: extração pela direita separa estado e cidade; número pela esquerda; o trecho central preserva a rua Fire-Oak. Resultado para Ramesh: 975 / Fire-Oak / Humble / TX.
7. Employees é a base do LEFT OUTER JOIN com departament: oito colaboradores antes e depois da expansão. Mescla adicional com employee obtém o nome do superior imediato.
8. Fname, Minit e Lname formam Nome, com espaços. Campos redundantes e dados não usados no relatório foram removidos das tabelas finais. As seis tabelas de origem permanecem em consultas sem carga, inclusive dependent para rastreabilidade.
9. Departamentos e locais: mesclar por Dnumber e concatenar Dname + local cria cinco combinações únicas. Não juntar Locations diretamente a Employees, pois Research possui três locais e multiplicaria colaboradores e salários.
10. Mesclar (Merge) combina colunas de tabelas por uma chave. Acrescentar (Append, referido como “atribuir” no enunciado) empilha linhas; não associa um local ao respectivo departamento. A concatenação é a etapa posterior que cria o rótulo único.
11. Agrupamento por gerente: Franklin T Wong = 3; Jennifer S Wallace = 2; James E Borg = 2. São sete vínculos diretos; o oitavo colaborador é o topo da hierarquia.
12. Relacionamentos: Departments → Employees → Assignments e Projects → Assignments. Departments → Projects está inativo para evitar dois caminhos de filtro até Assignments. As colunas DepartamentoColaborador e DepartamentoProjeto distinguem a lotação da pessoa e a responsabilidade pelo projeto.

## Correções do SQL original

O material alterna azure_company e company_constraints, contém comandos DROP/ALTER de demonstração, consultas com aspas tipográficas e insere empregados antes de seus superiores. O arquivo sql/01-company.sql usa um único banco, cria tabelas sem apagamentos, insere superiores primeiro e adiciona a chave do departamento após popular as tabelas. A versão original permanece disponível no repositório da professora, citado no README.

## Granularidade

Employees: uma linha por pessoa. Departments: uma por departamento. Projects: uma por projeto. Assignments: uma por pessoa/projeto. Locations: uma por departamento/local. ManagerCounts: uma por superior com subordinados. Quality: uma por regra de qualidade.

