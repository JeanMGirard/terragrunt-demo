# Encryption

Powered by Mozilla's [sops](https://github.com/mozilla/sops)


## Good to kwow

* Versioned secrets are the _**statically**_ fastest, but also safest
  way to store secrets. **It does not mean however that it is the best option for everything**

## Features

### Supported keys

* PGP keys
* GCP KMS
* AWS KMS
* Azure Key Vault
* Hashicorp Vault

### Other

* age

## Example

### Use or create GPG Key
```bash
gpg --import demo-key.asc
# gpg --list-secret-keys

export SOPS_PGP_FP="7BC406BAFA125A9357AF29991934F5B53CA30A2E"
```

### Start example

```bash
terragrunt apply -auto-approve
```

### Encrypt or decrypt secret

This is not required by terragrunt, just to update the secrets

```bash
# encrypt
sops -e config/secrets.yaml > config/secrets.enc.yaml
# decrypt
sops -d config/secrets.enc.yaml > config/secrets.yaml
````

### Clean it up

```bash
gpg --delete-secret-key DemoKey
unset SOPS_PGP_FP
```
