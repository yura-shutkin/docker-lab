#!/usr/bin/env python3
import os
import hvac

if __name__ == '__main__':
    vault_addr = "http://vault:8200"
    vault_token = os.getenv("VAULT_DEV_ROOT_TOKEN_ID")

    # Authenticate
    client = hvac.Client(url=vault_addr, token=vault_token)
    client.is_authenticated()

    # Mount KV v2
    client.sys.enable_secrets_engine(
        backend_type="kv",
        path="myorg",
        options={"version": 2}
    )

    # Create secret
    res = client.secrets.kv.v2.create_or_update_secret(
        mount_point="myorg",
        path="api",
        secret={
            "user": "apisrv",
            "pass": "D7F90D4E-C6FA-4883-A0ED-A5F1E21117DB"
        },
    )
    print(f"Create or update: {res}")

    # Mount approle auth backend
    res = client.sys.enable_auth_method(
        method_type="approle",
        path="approle",
    )
    print(f"Mount: {res}")

    # Create policy
    policy = '''
path "myorg/data/*" {
  capabilities = ["read"]
}
'''
    res = client.sys.create_or_update_policy(
        name="myorg-ro",
        policy=policy,
    )
    print(f"Mount: {res}")

    # Create approle
    res = client.auth.approle.create_or_update_approle(
        role_name="ansible",
        token_policies=["myorg-ro"],
        token_type="service",
    )
    print(f"Mount: {res}")

    # Get role-id
    res = client.auth.approle.read_role_id(
        role_name="ansible",
    )
    role_id = res['data']['role_id']
    print(f"AppRole role ID for some-role: {role_id}")

    # Get secret-id
    res = client.auth.approle.generate_secret_id(
        role_name="ansible",
    )
    secret_id = res['data']['secret_id']
    print(f"AppRole role ID for some-role: {secret_id}")

    # Save creds to file
    with open("environment/dev/group_vars/all/vault.yml", "w") as vault_yml:
        vault_yml.writelines([
            "---\n",
            f"vault_approle_role_id: {role_id}\n",
            f"vault_approle_secret_id: {secret_id}\n",
        ])
