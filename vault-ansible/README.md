# Demo of Ansible gathering secrets from Hashicorp Vault

## Plan

- Launch vault in dev mode with inmem storage and ${VAULT_DEV_TOKEN} (by default 12345)
- Configure objects in Vault
  - auth backend (approle)
  - approle (ansible)
  - Key Value secret's engine `/myorg`
  - Secret in KV `api`

    | Key  | Value                                |
    |------|--------------------------------------|
    | user | apisrv                               |
    | pass | D7F90D4E-C6FA-4883-A0ED-A5F1E21117DB |

- Render file on remote server

## Commands

- `docker-compose build`
- `docker-compose up -d`
- `docker-compose exec -ti ansible bash`
- `cd /src`
- `pip3 install -r requirements.txt`
- `python3 configure_vault.py`
- `echo '12345' > .vault-pass.txt`
- `ansible-vault encrypt environment/dev/group_vars/all/vault.yml`
- `ansible-playbook playbooks/setup.yml -i environment/dev`
- `ssh mysrv cat /etc/api.cfg`
