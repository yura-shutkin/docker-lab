# Vault PKI

```
cat /etc/hosts

192.168.9.11      vault.pki.infra blog.pki.infra
```

## Required soft

* Vault client
* jq
* curl
* openssl
* Docker
* docker-compose

## How to use

### Start vault

```
make up
make vault-unseal
```

### Setup CA

```
make openssl-generate-root
make vault-enable-pki
make vault-ca-set-custom
make vault-enable-pki-int
make vault-intermediate-setup
```

### Create role
```
make vault-create-role-subdomain SUBDOMAIN=blog
make vault-intermediate-generate-cert SUBDOMAIN=blog
```

### List issued certs Serial Numbers
```
make vault-intermediate-list-certificates
```

### Read cert by it's SN
```
make vault-intermediate-read-certificate SERIAL=65-83-7c-b0-c7-0f-33-77-4b-a6-a5-7b-a5-f1-e3-7b-da-cf-b0-b7
```
If you would like to decode cert
```
make vault-intermediate-read-certificate SERIAL=65-83-7c-b0-c7-0f-33-77-4b-a6-a5-7b-a5-f1-e3-7b-da-cf-b0-b7 | openssl x509 -text -noout
```

### Revoke intermediate cert
```
make vault-intermediate-revoke-certificate SERIAL=65-83-7c-b0-c7-0f-33-77-4b-a6-a5-7b-a5-f1-e3-7b-da-cf-b0-b7 
```

### Remove revoked certs
```
make vault-intermediate-tidy
```

## Openssl tips and tricks

* Decode cert
```
openssl x509 -in <cert>.pem -text -noout
```

* Decode CSR
```
openssl req -in <req>.csr -text -noout
```

## Useful docs
* Openssl request config description: [Req.conf](https://jamielinux.com/docs/openssl-certificate-authority/appendix/root-configuration-file.html)
* Vault intermediate role creation arguments: [create-update-role](https://www.vaultproject.io/api-docs/secret/pki#create-update-role)
