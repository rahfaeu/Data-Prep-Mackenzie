import os
import pandas as pd
import psycopg2
from psycopg2.extras import execute_values

# Configurações do banco de dados
DB_CONFIG = {
    "dbname": "olist_dbt",
    "user": "postgres",
    "password": "Postgres2024!",
    "host": "localhost",
    "port": 5433
}

# Lista de datasets no formato CSV e o nome correspondente da tabela
datasets = [
    {"file_path": "./src/olist_orders_dataset.csv", "table_name": "olist_orders_dataset"},
    {"file_path": "./src/olist_order_payments_dataset.csv", "table_name": "olist_order_payments_dataset"},
    {"file_path": "./src/olist_customers_dataset.csv", "table_name": "olist_customers_dataset"},
    {"file_path": "./src/olist_order_reviews_dataset.csv", "table_name": "olist_order_reviews_dataset"},
    {"file_path": "./src/olist_products_dataset.csv", "table_name": "olist_products_dataset"},
    {"file_path": "./src/olist_order_items_dataset.csv", "table_name": "olist_order_items_dataset"},
    {"file_path": "./src/olist_sellers_dataset.csv", "table_name": "olist_sellers_dataset"},
    {"file_path": "./src/olist_geolocation_dataset.csv", "table_name": "olist_geolocation_dataset"}
]

def connect_to_db(config):
    """Estabelece conexão com o banco de dados PostgreSQL."""
    try:
        conn = psycopg2.connect(**config)
        print("Conexão com o banco de dados estabelecida.")
        return conn
    except Exception as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

def load_csv_to_db(file_path, table_name, conn):
    """Carrega um arquivo CSV para uma tabela no banco de dados."""
    try:
        df = pd.read_csv(file_path)
        print(f"Lendo dataset: {file_path}")

        if df.empty:
            print(f"O arquivo {file_path} está vazio. Ignorando.")
            return

        rows = [tuple(row) for row in df.itertuples(index=False, name=None)]

        columns = ", ".join(df.columns)
        sql = f"INSERT INTO {table_name} ({columns}) VALUES %s"

        # Usar execute_values para inserir dados em massa
        with conn.cursor() as cur:
            execute_values(cur, sql, rows)
            conn.commit()
            print(f"Dados inseridos na tabela {table_name} com sucesso.")
    except Exception as e:
        print(f"Erro ao carregar o arquivo {file_path} na tabela {table_name}: {e}")

def main():
    """Função principal para carregar datasets em tabelas do banco."""
    conn = connect_to_db(DB_CONFIG)
    if not conn:
        return

    try:
        for dataset in datasets:
            file_path = dataset["file_path"]
            table_name = dataset["table_name"]

            if os.path.exists(file_path):
                load_csv_to_db(file_path, table_name, conn)
            else:
                print(f"Arquivo {file_path} não encontrado. Ignorando.")
    finally:
        conn.close()
        print("Conexão com o banco de dados fechada.")

if __name__ == "__main__":
    main()
