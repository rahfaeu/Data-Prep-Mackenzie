import os
import zipfile

def download_dataset(dataset_name):
    command = f"kaggle datasets download -d {dataset_name}"
    try:
        os.system(command)
    except Exception as e:
        print(f"Falha ao tentar realizar o download: {e}")
    print('dowload zip realizado!')

def delete_zip_file(z_file):
    command = f"rm {z_file}"
    try:
        os.system(command)
    except Exception as e:
        print(f"Falha ao tentar deletar o arquivo!: {e}")
    print('Arquivo deletado com sucesso!')

def unzip_file(dataset_name, z_file, extract_to='./src'):
    download_dataset(dataset_name)
    try:
        with zipfile.ZipFile(z_file, 'r') as zip_ref:
            zip_ref.extractall(extract_to)
    except FileNotFoundError as e:
        print(f"Erro ao extrair o csv: {e}")
    print('csv extraido')

    delete_zip_file(z_file)



dataset_name = "olistbr/brazilian-ecommerce"
z_file = 'brazilian-ecommerce.zip'
csv_file = 'brazilian-ecommerce.csv'

unzip_file(dataset_name, z_file)