[English](./yazi.keymap.cheatsheet.md) | Español

# Mapa de Teclas de Yazi — GGOS (Amigable para Humanos)
## 🧭 Navegación
- k / Arriba — Mover hacia arriba
- j / Abajo — Mover hacia abajo
- Ctrl+u / Shift+RePág — Media página hacia arriba
- Ctrl+d / Shift+AvPág — Media página hacia abajo
- Ctrl+b / RePág — Página hacia arriba
- Ctrl+f / AvPág — Página hacia abajo
- g g — Ir al principio
- G — Ir al final
- h / Izquierda — Ir al directorio padre
- l / Derecha — Entrar al directorio hijo
- H — Atrás (directorio anterior)
- L — Adelante (siguiente directorio)

## 🧰 Selección y Modo Visual
- Espacio — Alternar actual, luego mover hacia abajo
- Ctrl+a — Seleccionar todo
- Ctrl+r — Invertir selección
- v — Entrar en modo visual (seleccionar)
- V — Salir del modo visual

## 🔎 Búsqueda y Filtro
- s — Buscar por nombre (fd)
- S — Buscar por contenido (ripgrep)
- Ctrl+s — Cancelar búsqueda
- f — Filtrar archivos (inteligente)
- / — Buscar siguiente (inteligente)
- ? — Buscar anterior (inteligente)
- n — Siguiente encontrado
- N — Anterior encontrado

## 📂 Abrir y Vista Previa
- o / Enter — Abrir
- O / Shift+Enter — Abrir interactivamente
- Tab — Resaltar archivo sobre el que se pasa el ratón
- K / J — Desplazarse hacia arriba/abajo en la vista previa (±5)

## 📋 Portapapeles (Copiar/Mover)
- y — Copiar (yank)
- x — Cortar (yank cut)
- p — Pegar
- P — Pegar (sobrescribir)
- - — Enlace simbólico de la ruta absoluta de lo copiado
- _ — Enlace simbólico de la ruta relativa de lo copiado
- Ctrl+- — Enlace duro de lo copiado
- Y / X — Deshacer copia (cancelar yank)

## 🗑️ Eliminar
- d — Enviar a la papelera lo seleccionado
- D — Eliminar permanentemente

## ✏️ Crear y Renombrar
- a — Crear archivo/directorio (usar / al final para carpetas)
- r — Renombrar (cursor antes de la extensión)

## 🖥️ Shell
- ; — Ejecutar comando de shell (interactivo)
- : — Ejecutar comando de shell (bloquear hasta que termine)

## 👀 Archivos Ocultos
- . — Alternar ocultos

## 🧭 Saltos Rápidos
- g h — Ir a $HOME
- g c — Ir a ~/.config
- g d — Ir a ~/Downloads
- g Espacio — Saltar interactivamente
- z — Salto con Zoxide
- Z — Salto con FZF (archivo/directorio)

## 🧾 Modo de Línea (Vista de Metadatos)
- m s — Tamaño
- m p — Permisos
- m b — Fecha de creación
- m m — Fecha de modificación
- m o — Propietario
- m n — Ninguno

## 🔤 Ordenar
- , m / , M — Ordenar por fecha de modificación (asc/desc)
- , b / , B — Ordenar por fecha de creación (asc/desc)
- , e / , E — Ordenar por extensión (asc/desc)
- , a / , A — Ordenar alfabéticamente (asc/desc)
- , n / , N — Ordenar naturalmente (asc/desc)
- , s / , S — Ordenar por tamaño (asc/desc)
- , r — Ordenar aleatoriamente

## 🗂️ Pestañas
- t — Nueva pestaña (directorio actual)
- 1..9 — Cambiar a la pestaña 1..9
- [ / ] — Pestaña anterior / siguiente
- { / } — Intercambiar pestaña a la izquierda / derecha

## 🧮 Tareas y Ayuda
- w — Mostrar tareas (gestor de tareas)
- ~ / F1 — Abrir ayuda

## 🧩 Plugins (Anteponer)
- g i — LazyGit (plugin)
- l — Entrada inteligente (entrar a directorio o abrir archivo)

## 🧰 Modos: Resaltar, Elegir, Entrada, Confirmar, Autocompletar
- Modo Resaltar: Esc/C-[/Ctrl+c/Tab para cerrar; k/j/Arriba/Abajo para navegar; h/l o Izquierda/Derecha para deslizar; c c para copiar celda; ~ / F1 para ayuda
- Modo Elegir: Esc/C-[/Ctrl+c para cancelar; Enter para enviar; k/j/Arriba/Abajo para navegar; ~ / F1 para ayuda
- Modo Entrada: Esc/C-[ para escapar; i/I/a/A para entrar en modo inserción/añadir (con movimientos al principio/final de línea); selecciones visuales (v, V, Ctrl-A/E); movimiento (h/l/Izquierda/Derecha/C-b/C-f/b/B/w/W/e/E/Alt-b/Alt-f); eliminar/retroceder/matar palabras; cortar/copiar/pegar (d/D/c/C/x/y/p/P); deshacer/rehacer (u/C-r); ~ / F1 para ayuda
- Modo Confirmar: Esc/C-[/Ctrl+c/n para cancelar; Enter/y para enviar; k/j/Arriba/Abajo para navegar; ~ / F1 para ayuda
- Modo Autocompletar: Ctrl+c para cancelar; Tab para enviar; Enter para enviar autocompletado + entrada; Alt-k/j o Arriba/Abajo/C-p/C-n para navegar; ~ / F1 para ayuda
