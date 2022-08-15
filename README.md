# PlantUML Identity Icon Sprites

## Getting Started

This work was started with examples from the great script by Anthony in the PlantUML repo at [https://github.com/plantuml/plantuml/blob/master/tools/create_sprites.sh](https://github.com/plantuml/plantuml/blob/master/tools/create_sprites.sh)

```puml
!define ICONURL https://raw.githubusercontent.com/uberether/plantuml-identity-sprites/v1.0.0

Import the sprites that you want

```puml
!include ../identicons-set-v1/icon-api.puml
!include ../identicons-set-v2/icon-browser.puml
!include ../identicons-set-v2/icon-webauthn.puml
```

or via url

```puml
!includeurl ICONURL/common.puml
!includeurl ICONURL/identicons-set-v1/icon-api.puml
!includeurl ICONURL/identicons-set-v2/icon-browser.puml
!includeurl ICONURL/identicons-set-v2/icon-webauthn.puml
```

To use the sprites add one of the macros

```puml
DEV_MYSQL(db)
```

The macros are prefixed with the set and the name of the icon

```puml
<prefix>_<name>(alias)
<prefix>_<name>(alias,label)
<prefix>_<name>(alias,label,shape)
<prefix>_<name>(alias,label,shape,color)
```

Using the icon from devicons for mysql

```puml
DEV_MYSQL(db1)
DEV_MYSQL(db2,label of db2)
DEV_MYSQL(db3,label of db3,database)
DEV_MYSQL(db4,label of db4,database,red) #DeepSkyBlue
```

![overload-example](examples/overload-example.png)

## Icon Sets

The following icon sets are included:

| Name                                                                        | Index                                     |
| --------------------------------------------------------------------------- | ----------------------------------------- |
| [Identicons v1](https://identicons.dev/static/icons/identicons-set-v1.zip)  | [List of macros](identicons-set-v1/index.md)   |
| [Identicons v2](https://github.com/auth0/identicons)                        | [List of macros](identicons-set-v2/index.md) |

## Build
### Mac OSX

```terminal
brew install node yarn librsvg openjdk-11-jre graphviz plantuml
yarn install
yarn build
```

## Note

- All brand icons are trademarks of their respective owners.
- Thanks to tupadr3 for [plantuml-icon-font-sprites](https://github.com/tupadr3/plantuml-icon-font-sprites)
- Thanks to milo-minderbinder for [AWS-PlantUML](https://github.com/milo-minderbinder/AWS-PlantUML)
- Thanks to [yuri-becker](https://github.com/yuri-becker) for the integration of [Devicon 2](https://konpa.github.io/devicon/)

## Contributing

Contributions are welcome. In order to update an existing set of icons or to add a new icon set please fork the repository and use a feature branch.

## Changelog

### v1.0.0

- Initial release

Enjoy!
