#!usr/bin/python
"""
Скрипт получает путь до tfstate файла.
Парсит его и на его основе генерирует json для inventory файла
"""
import json
from pprint import pprint


def put_json(data, path):
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(data, f, skipkeys=True, indent=2, sort_keys=True)


def get_json(path):
    with open(path, 'r') as f:
        data = json.load(f)
    return data


def get_inventory(path):
    result = {}
    data = get_json(path)

    for resource in data['resources']:
        res_name = resource['name']
        if res_name not in result:
            result[res_name] = {'hosts': {}}

        for instance in resource['instances']:
            attr = instance['attributes']
            name = attr['name']
            host = attr['network_interface'][0]['nat_ip_address']
            host_data = {name: {"ansible_host": host}}
            result[res_name]['hosts'].update(host_data)

    return result


def generate(tfstate_path, out_path=None):
    result = get_inventory(tfstate_path)

    if out_path is None:
        pprint(result)
    else:
        put_json(result, out_path)


if __name__ == "__main__":
    # пример запуска из каталога ansible
    generate('../terraform/stage/terraform.tfstate', 'inventory.json')
