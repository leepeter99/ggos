[English](zcli.md) | [Español](zcli.es.md)

# Utilidad de Línea de Comandos GGOS (zcli) - Versión 1.0.2

`zcli` es una herramienta práctica para realizar tareas comunes de mantenimiento en tu sistema GGOS con un solo comando. A continuación, una guía de uso y comandos.

## Uso

Ejecuta la utilidad con un comando específico:

`zcli`

Si no se proporciona comando, muestra la ayuda.

## Comandos Disponibles (resumen)

| Comando       | Icono | Descripción                                                                                 | Ejemplo                              |
| ------------- | ----- | ------------------------------------------------------------------------------------------- | ------------------------------------ |
| cleanup       | 🧹    | Elimina generaciones antiguas (todas o manteniendo N últimas)                               | `zcli cleanup`                       |
| diag          | 🛠️    | Genera informe de diagnóstico en `~/diag.txt`                                               | `zcli diag`                          |
| list-gens     | 📋    | Lista generaciones de usuario y sistema                                                      | `zcli list-gens`                     |
| rebuild       | 🔨    | Reconstruye NixOS (con comprobaciones de seguridad previas)                                  | `zcli rebuild -v`                    |
| rebuild-boot  | 🔄    | Reconstruye para el próximo arranque (más seguro para cambios grandes)                       | `zcli rebuild-boot`                  |
| trim          | ✂️    | Ejecuta fstrim del sistema de archivos                                                       | `zcli trim`                          |
| update        | 🔄    | Actualiza el flake y reconstruye                                                             | `zcli update`                        |
| update-host   | 🏠    | Ajusta host y perfil en `flake.nix` (detección de GPU y validación)                          | `zcli update-host`                   |
| add-host      | ➕    | Crea un nuevo host (detección de GPU, `hardware.nix`, integración git)                       | `zcli add-host mi-host amd`          |
| del-host      | ➖    | Elimina un host existente                                                                     | `zcli del-host mi-host`              |
| doom install  | 🔥    | Instala Doom Emacs usando el script `get-doom`                                               | `zcli doom install`                  |
| doom status   | ✅    | Comprueba instalación y muestra versión                                                      | `zcli doom status`                   |
| doom remove   | 🗑️    | Elimina Doom Emacs con confirmación                                                          | `zcli doom remove`                   |
| doom update   | 🔄    | Actualiza paquetes/config de Doom (`doom sync`)                                              | `zcli doom update`                   |

## Opciones Avanzadas (rebuild/update)

- `--dry, -n`: simulación (no ejecuta)
- `--ask, -a`: confirmación interactiva
- `--cores N`: limita CPU usada en compilación
- `--verbose, -v`: salida detallada
- `--no-nom`: deshabilita nix-output-monitor

### Ejemplos
```bash
zcli update --dry
zcli rebuild --ask --verbose
zcli rebuild --cores 2
zcli update --dry --verbose --cores 4
```

## Notas

- Usa `update-host`, `add-host` y `del-host` para gestionar hosts.
- Doom Emacs: `install`, `status`, `remove`, `update` para ciclo de vida.
- Si tienes problemas, genera `zcli diag` y revisa los logs del sistema.
