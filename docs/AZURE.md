# Conectar as transformações ao MySQL na Azure

## Estado desta entrega

A versão local funciona com uma cópia incorporada da base didática. Criar uma conta Microsoft e entrar no portal Azure não provisiona automaticamente uma assinatura ou servidor MySQL. Esta entrega não apresenta essas etapas como concluídas.

## Preparação

1. Confirmar uma assinatura Azure ativa e as condições da oferta. Não confundir avaliação gratuita com pagamento conforme o uso.
2. Usar o serviço **Azure Database for MySQL — Flexible Server**. Conferir região, camada, armazenamento, backups e estimativa de custo antes de confirmar a criação.
3. Para contas elegíveis, a documentação cita uma franquia de 750 horas mensais de B1ms e 32 GB de armazenamento/backup nos primeiros 12 meses. Confirmar a oferta efetivamente aplicada à assinatura; configurações e excedentes podem ser cobrados.
4. Criar um grupo de recursos exclusivo do laboratório. O usuário deve cadastrar a própria senha do administrador; não publicar senha ou arquivos de credenciais.
5. Manter TLS ativo e restringir o acesso de rede ao cliente necessário. Não liberar indiscriminadamente todos os endereços.

## Banco

Conectar ao servidor com um cliente MySQL compatível e executar `sql/01-company.sql`. Esse arquivo cria `azure_company` e popula as seis tabelas, sem comandos para apagar bancos existentes. Executar uma vez em um banco novo; a execução repetida falha nas tabelas/IDs já existentes.

Validar com `sql/02-transformacoes-e-auditoria.sql`: 8 pessoas, 3 departamentos, 6 projetos, 16 alocações, 275 horas e soma salarial 281000.

## Power Query

1. Criar um parâmetro de texto chamado `pServidor` com o endereço do servidor, no formato `nome.mysql.database.azure.com`.
2. Substituir apenas as consultas de origem `raw_*` pelas fontes MySQL; manter os mesmos nomes e cabeçalhos. O exemplo está em `FONTE-MYSQL.pq` nesta pasta.
3. Informar as credenciais no diálogo seguro do Power BI. Se o aplicativo indicar ausência do provedor MySQL, instalar somente o provedor oficial compatível indicado pelo próprio conector/documentação.
4. Atualizar as sete consultas finais e repetir as reconciliações documentadas em `VALIDACAO.md`.
5. Salvar uma nova versão do PBIX e registrar a evidência real da conexão antes de alterar o status do README para concluído.

Os dados armazenados em um PBIX são uma cópia importada; abrir o arquivo não comprova uma nova consulta ao servidor. A evidência deve incluir atualização bem-sucedida da fonte MySQL, com os totais reconciliados e sem exibir credenciais.

## Encerramento

Depois de capturar as evidências e salvar o relatório, revisar os recursos do laboratório para evitar custos contínuos. A exclusão de um grupo de recursos remove tudo que ele contém; conferir o conteúdo e manter os arquivos necessários antes dessa ação.

## Referências oficiais

- [MySQL Flexible Server — visão geral e oferta gratuita](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/overview)
- [Implantar MySQL com uma conta Azure gratuita](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/how-to-deploy-on-azure-free-account)
- [Conector MySQL no Power Query](https://learn.microsoft.com/power-query/connectors/mysql-database)
- [Conta Azure e condições de cadastro](https://azure.microsoft.com/pt-br/pricing/purchase-options/azure-account)
