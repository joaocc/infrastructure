# Infrastructure

This is the configuration for the Brandfolder infrastructure. Built and managed
with [Terraform](github.com/hashicorp/terraform).

## Prerequisites

* Install Terraform
* Sign up for [Atlas](https://atlas.hashicorp.com/) and get invited to the Brandfolder organization.
* Find your Atlas API access key, you will need it next.
* Run the following command:
  `terraform remote config -backend-config="access_token={{Atlas Access Key}}" -backend-config="name=brandfolder/infrastructure"`
* (Optional) Set your environment variables to include
  ```
  export AWS_ACCESS_KEY_ID={{Your AWS Access Key}}
  export AWS_SECRET_ACCESS_KEY={{Your AWS Secret Access Key}}
  ```

## Usage

### Viewing changes

`make plan`

### Applying changes

`make apply`

## Workflow

1. Make changes to terraform files
2. Run `make plan` to view changes and check for errors
3. Commit changes
4. Run `make apply`

## Infrastructure Map

```
___                  _  __     _    _           ___       __             _               _
| _ )_ _ __ _ _ _  __| |/ _|___| |__| |___ _ _  |_ _|_ _  / _|_ _ __ _ __| |_ _ _ _  _ __| |_ _  _ _ _ ___                                               Jason Waldrip
| _ \ '_/ _` | ' \/ _` |  _/ _ \ / _` / -_) '_|  | || ' \|  _| '_/ _` (_-<  _| '_| || / _|  _| || | '_/ -_)                                       CTO, Brandfolder.com
|___/_| \__,_|_||_\__,_|_| \___/_\__,_\___|_|   |___|_||_|_| |_| \__,_/__/\__|_|  \_,_\__|\__|\_,_|_| \___|                              jason.waldrip@brandfolder.com

╔═Legend══════════════════════════════════════════════════════════╗
║ ┌─────────────┐                       ┌──────────────────────┐  ║
║ ▥Talks to ETCD│  ◀═══Networking═══▶   │gggg Server Group gggg│  ║           bastion.brandfolder.host                   *.brandfolder.com  *.brandfolder.ninja
║ └─────────────┘                       └──────────────────────┘  ║                      ║                                     ║      ║        ║    ║     ║
╚═════════════════════════════════════════════════════════════════╝                     SSH                                  HTTP   HTTPS    HTTP HTTPS  GIT
                                                                          ╔═══════════════▼════════════════╗                ╔═══▼══════▼═══╗  ╔═▼════▼═════▼═╗
┌─────────────────────────────────────────────────────────────────────────╣            Bastion             ╠────────────────╣   Site ELB   ╠──╣   Dev ELB    ╠────────┐
│Amazon VPC        ┌─────────┐ ┌─────────────────────────┐                ╚════════════════════════════════╝                ╚══════════════╝  ╚══════════════╝        │
│                  │   RDS   │ │  ElasticCache (Redis)   │                                ║                                        ║              ║      ║            │
│                  └─────────┘ └─────────────────────────┘                        ╔══════SSH═══════╗                             HTTP           HTTP    GIT           │
│                                                                        ╔════════╝       ║        ╚════════╗                      ║              ║      ║            │
│                  ┌─────────────────────────────────────┐      ╔════════╝┌───────────────▼────────────────┐╚════════╗      ┌──────▼──────────────▼──────▼───┐        │
│                  │cccccccccccccc   Core   cccccccccccc◀╬══════╝         │wwwwwwwwwww Workers  wwwwwwwwwww│         ╚══════╬▶rrrrrrrrrr Routers  rrrrrrrrrrr│        │
│    ┌─────────────┴─────────────────────────────────────┴────────────────┴────────────────────────────────┴────────────────┴────────────────────────────────┴───┐    │
│    │             │ccc┌────────┐c┌────────┐c┌────────┐cc│                │┌────────┐w┌────────┐w┌────────┐│                │┌────────┐r┌────────┐r┌────────┐│   │    │
│    │             │ccc│        │c│        │c│        │cc│                ││ Worker │w│ Worker │w│ Worker ││                ││        │r│        │r│        ││   │    │
│    │             │ccc│ Core 1 │c│ Core 3 │c│ Core 5 │cc│                ││ (prod) │w│ (prod) │w│ (prod) ││                ││ Router │r│ Router │r│ Router ││   │    │
│    │             │ccc│        │c│        │c│        │cc│                ││        │w│        │w│        ││                ││        │r│        │r│        ││   │    │
│    │ Servers     │ccc└────────┘c└────────┘c└────────┘cc◀══════VPC═══════▶└────────┘w└────────┘w└────────┘◀══════VPC═══════▶└────────┘r└────────┘r└────────┘│   │    │
│    │             │cccccccc┌────────┐cc┌────────┐ccccccc│   Networking   │┌────────┐wwwwwwwwwwwwwwwwwwwwww│   Networking   │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │             │cccccccc│        │cc│        │ccccccc│                ││ Worker │ww                  ww│                │rrrrrrr                  rrrrrrr│   │    │
│    │             │cccccccc│ Core 2 │cc│ Core 4 │ccccccc│                ││ (feat) │ww  autoscales...   ww│                │rrrrrrr  autoscales...   rrrrrrr│   │    │
│    │             │cccccccc│        │cc│        │ccccccc│                ││        │ww                  ww│                │rrrrrrr                  rrrrrrr│   │    │
│    │             │cccccccc└────────┘cc└────────┘ccccccc│                │└────────┘wwwwwwwwwwwwwwwwwwwwww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    ├───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤    │
│    │              ETCD ◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀ ETCD Proxy ◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀◀ ETCD Proxy     │    │
│    ├───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤    │
│    │             │cccccc┌──────────┐cc┌──────────┐ccccc│                │ww┏━━━━━━━━━━━┓wwwwwwwwwwwwwwwww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │             │cccccc│   Deis   │cc│   Deis   │ccccc│                │ww┃    App    ┃ww┌───────────┐ww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │             │cccccc│ Builder  │cc│Controller│ccccc│                │ww┗━━━━━━━━━━━┛ww▥ Publisher │ww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │             │cccccc└──────────┘cc└──────────┘ccccc│                │ww┏━━━━━━━━━━━┓ww└───────────┘ww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │             │cccccc┌──────────┐cc┌──────────┐ccccc│                │ww┃    App    ┃ww┌───────────┐ww│                │rrrrrrrrrr┌───────────┐rrrrrrrrr│   │    │
│    │             │cccccc▥  SkyDNS  │cc│ Elastic  │ccccc◀════Flannel═════▶ww┗━━━━━━━━━━━┛ww▥Registrator│ww◀════Flannel═════▶rrrrrrrrrr▥deis-router│rrrrrrrrr│   │    │
│    │ Containers  │cccccc│          │cc│  Search  │ccccc│   Networking   │ww┏━━━━━━━━━━━┓ww└───────────┘ww│   Networking   │rrrrrrrrrr└───────────┘rrrrrrrrr│   │    │
│    │             │cccccc└──────────┘cc└──────────┘ccccc│                │ww┃    App    ┃ww┌───────────┐ww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │             │cccccc┌──────────┐cc┌──────────┐ccccc│                │ww┗━━━━━━━━━━━┛ww│ logspout  │ww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │             │cccccc▥   Reg-   │cc│ Logspout │ccccc│                │ww┏━━━━━━━━━━━┓ww└───────────┘ww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │             │cccccc│ istrator │cc│          │ccccc│                │ww┃    App    ┃wwwwwwwwwwwwwwwww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │             │cccccc└──────────┘cc└──────────┘ccccc│                │ww┗━━━━━━━━━━━┛wwwwwwwwwwwwwwwww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │             │ccccccccccccccccccccccccccccccccccccc│                │wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    └─────────────┬─────────────────────────────────────┬────────────────┬────────────────────────────────┬────────────────┬────────────────────────────────┬───┘    │
│    ┌─────────────┴─────────────────────────────────────┴────────────────┴────────────────────────────────┴────────────────┴────────────────────────────────┴───┐    │
│    │             │c┌──────┐┌───────┐┌───────┐┌───────┐c│                │w┌───────┐w┌───────┐w┌───────┐ww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │  Services   │c│ Etcd ││Flannel││ Fleet ││Docker │c│                │w│Flannel│w│Docker │w│ Fleet │ww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    │             │c└──────┘└───────┘└───────┘└───────┘c│                │w└───────┘w└───────┘w└───────┘ww│                │rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr│   │    │
│    └─────────────┬─────────────────────────────────────┬────────────────┬────────────────────────────────┬────────────────┬────────────────────────────────┬───┘    │
│                  └─────────────────────────────────────┘                └────────────────────────────────┘                └────────────────────────────────┘        │
│                                                                                                                                                                     │
│                                                                                                                                                                     │
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```