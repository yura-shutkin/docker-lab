import json
import requests
import time


def main():
    vault_addr = "http://localhost:8200"

    # vault init
    resp = requests.put(
        url=f"{vault_addr}/v1/sys/init",
        json={
            "secret_shares": 1,
            "secret_threshold": 1
        }
    )

    creds = json.loads(resp.content.decode())
    print(creds)

    print(creds["keys"][0])

    # vault unseal
    resp = requests.put(
        url=f"{vault_addr}/v1/sys/unseal",
        json={
            "key": creds["keys"][0]
        }
    )
    print(resp.content.decode())

    # enable approle auth backend
    headers = {"X-Vault-Token": creds["root_token"]}

    resp = requests.post(
        url=f"{vault_addr}/v1/sys/auth/approle",
        json={
            "type": "approle"
        },
        headers=headers,
    )

    print(resp.content.decode())

    # create approle
    resp = requests.post(
        url=f"{vault_addr}/v1/auth/approle/role/wrapper",
        json={
            "secret_id_ttl": "0",
            "period": "5m",
            "token_ttl": "5m",
            "token_max_ttl": "5m",
            "policies": ["default"]
        },
        headers=headers
    )

    # get role_id
    role_id = json.loads(
        requests.get(
            url=f"{vault_addr}/v1/auth/approle/role/wrapper/role-id",
            headers=headers
        ).content.decode()
    )["data"]["role_id"]

    print(role_id)

    # generate secret_id
    secret_id = json.loads(
        requests.post(
            url=f"{vault_addr}/v1/auth/approle/role/wrapper/secret-id",
            headers=headers
        ).content.decode()
    )["data"]["secret_id"]

    print(secret_id)

    # save creds
    with open("creds/role_id", 'w+') as f:
        f.write(role_id)

    with open("creds/secret_id", 'w+') as f:
        f.write(secret_id)


if __name__ == "__main__":
    main()
