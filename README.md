# MBA Engenharia de Dados - Mackenzie


### Integrantes:
| Nome                           |
|--------------------------------|
| Neoaquison Conceição Medeiros  |
| Rafael Medeiros dos Santos     |
| Samuel Silva Perumalswamy      |
| Gustavo Bido                   |

### 1 - Preparar o ambiente de execução
Clonar o repositório do projeto
``` bash
git clone https://github.com/rahfaeu/Data-Prep-Mackenzie.git
```

Entrar no diretório do projeto
``` bash
cd Data-Prep-Mackenzie
```

No diretório principal rodar os seguintes comando para criar o ambiente virtual

``` bash
python3 -m venv .venv
```

Para ativar o ambiente virtual, execute

``` bash
source .venv/bin/activate
```

Instale as bibliotecas do arquivo requirements.txt

``` bash
pip install -r requirements.txt
```

### 2 - Extrair dados do kaggle. 
Executar o comando abaixo para extrair as bases do kaggle e salvar local
``` bash
python3 script/get_kaggle_datasources.py 
```

### 3 - Criar o banco de dados 
Executar o comando abaixo para subir a imagem do postgres no docker
``` bash
docker compose up -d
```

### 4 - Inserir dados nas tabelas transacionais
``` bash
python3 script/df_to_database.py
```

### 5 - Modelagem dimensional (Star Schema)

Abaixo temos o diagrama da modelagem dimensional, consideramos o modelo de Ralph Kimball (Star Schema)

![Diagrama Dimensional](./diagrams/star_schema_model.png)

### 6 - Criação do fluxo de Transformação

Utilizamos o DBT como ferramenta de trasformação dos dados na camada analítica.

Criamos 6 modelos

- 2 Stagings
    - stg_olist_order_items_dataset
    - stg_olist_orders_dataset
- 3 Dimensões
    - dim_customers
    - dim_products
    - dim_sellers
- 1 Fato
    - fact_orders

![Modelos](./diagrams/models-dbt.png)

Para materializar os modelos através do DBT, basta executar o seguinte comando:

``` bash
dbt run
```