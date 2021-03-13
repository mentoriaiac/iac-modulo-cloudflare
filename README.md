# IAC-MODULO-CLOUDFLARE

Modulo terraform para criar um registro dns em um site na [cloudflare.com](cloudflare.com).

## Requerimentos

### [API-TOKEN](https://dash.cloudflare.com/profile/api-tokens)

#### Privilégios para o token

* Recurso: Todas as zonas
  * Zona.Zona = editar
  * Zona.DNS = editar

### Site(Zona) criado

Para testar o modulo é necessário ter uma zona criada.
Está como todo do projeto o modulo cirar a zona para teste, porém o mesmo está com erro.

### [Variaveis de ambiente](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs#argument-reference)

* CLOUDFLARE_API_TOKEN = [API-TOKEN](https://dash.cloudflare.com/profile/api-tokens)

## Como utilizar o modulo

```hcl
module "cloudflare_record_cname" {
  source  = "path_module/"
  zone_id = data.cloudflare_zones.example.zones[0].id
  name    = var.name
  value   = var.value
  type    = "CNAME"
}
```

## Teste do modulo

### Depencias para execução do teste

* Terraform 0.14
* TFsec
* Make

### Variaveis para executar o teste do modulo

* CLOUDFLARE_ZONE_NAME
* CLOUDFLARE_API_TOKEN

Exemplo de CLOUDFLARE_ZONE_NAME = *example.com*

### execução do teste

```sh
make test
```

## TODO

### Implementação do parametro data do resource

O recurso tem o parametro data para outras propriedades. [link](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record#example-usage)

```hcl
# Add a record requiring a data map
resource "cloudflare_record" "_sip_tls" {
  zone_id = var.cloudflare_zone_id
  name    = "_sip._tls"
  type    = "SRV"

  data = {
    service  = "_sip"
    proto    = "_tls"
    name     = "terraform-srv"
    priority = 0
    weight   = 0
    port     = 443
    target   = "example.com"
  }
}
```

### Implementação de peso de registros 

É o item *priority* do resource.

### Casos de teste

### CI

É necessário criar a implementação de CI para testes automatizados.

### Erro ao criar zona de dependencia do modulo

Para realizar o teste do modulo, é interessante o teste criar as suas dependencias, porém ocorre este erro ao criar a zona para realizar o test do modulo.

```hcl
resource "cloudflare_zone" "zone" {
    zone = "afonsorodrigues.info"
}
```

```sh
cloudflare_zone.zone: Creating...

Error: Error finding Zone "12aeb07229bf902dcab6539e735fd833": HTTP status 403: Invalid zone identifier (9109)

  on main.tf line 10, in resource "cloudflare_zone" "zone":
  10: resource "cloudflare_zone" "zone" {
```

Como uma analise superficial a api do terraform está tentando consultar o id logo após enviar a requisição de criação da zona.

É necessário investigar a implementação do provider e abrir uma issue para resolução do problema.

## Links

* [Terraform provider Cloudflare](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs)
* [Resource cloudflare_record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record)