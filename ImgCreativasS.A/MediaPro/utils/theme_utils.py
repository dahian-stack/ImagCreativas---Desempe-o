"""
utils/theme_utils.py
────────────────────
Temas visuales de MediaPro.
"""

from tkinter import ttk


TEMAS = {

    "claro": {
        "fondo": "#F5F5F5",
        "fondo_secundario": "#FFFFFF",
        "texto": "#222222",
        "entrada": "#FFFFFF",
        "texto_entrada": "#222222",

        "boton": "#457B9D",
        "boton_texto": "#FFFFFF",
        "boton_activo": "#35627D",

        "seleccion": "#BFD7EA",
        "texto_seleccion": "#000000",

        "tabla": "#FFFFFF",
        "tabla_texto": "#222222",
        "tabla_encabezado": "#457B9D",
        "tabla_encabezado_texto": "#FFFFFF",

        "borde": "#CCCCCC"
    },

    "oscuro": {
        "fondo": "#111111",
        "fondo_secundario": "#1C1C1C",
        "texto": "#FFFFFF",
        "entrada": "#2A2A2A",
        "texto_entrada": "#FFFFFF",

        "boton": "#6A4C93",
        "boton_texto": "#FFFFFF",
        "boton_activo": "#845FB5",

        "seleccion": "#444444",
        "texto_seleccion": "#FFFFFF",

        "tabla": "#1E1E1E",
        "tabla_texto": "#FFFFFF",
        "tabla_encabezado": "#333333",
        "tabla_encabezado_texto": "#FFFFFF",

        "borde": "#555555"
    }
}


def aplicar_tema(ventana, nombre_tema):
    """
    Aplica el tema general a la ventana y a los widgets ttk.
    """

    tema = TEMAS[nombre_tema]

    estilo = ttk.Style()

    # Intentamos usar un tema base que permita personalización
    try:
        estilo.theme_use("clam")
    except Exception:
        pass

    # Frames
    estilo.configure(
        "TFrame",
        background=tema["fondo"]
    )

    # Labels
    estilo.configure(
        "TLabel",
        background=tema["fondo"],
        foreground=tema["texto"]
    )

    # Notebook
    estilo.configure(
        "TNotebook",
        background=tema["fondo"],
        borderwidth=0
    )

    estilo.configure(
        "TNotebook.Tab",
        background=tema["fondo_secundario"],
        foreground=tema["texto"],
        padding=[18, 8]
    )

    estilo.map(
        "TNotebook.Tab",
        background=[
            ("selected", tema["boton"]),
            ("active", tema["seleccion"])
        ],
        foreground=[
            ("selected", tema["boton_texto"]),
            ("active", tema["texto"])
        ]
    )

    # Treeview
    estilo.configure(
        "Treeview",
        background=tema["tabla"],
        foreground=tema["tabla_texto"],
        fieldbackground=tema["tabla"],
        bordercolor=tema["borde"],
        rowheight=28
    )

    estilo.configure(
        "Treeview.Heading",
        background=tema["tabla_encabezado"],
        foreground=tema["tabla_encabezado_texto"],
        relief="flat"
    )

    estilo.map(
        "Treeview",
        background=[
            ("selected", tema["seleccion"])
        ],
        foreground=[
            ("selected", tema["texto_seleccion"])
        ]
    )

    # Combobox
    estilo.configure(
        "TCombobox",
        fieldbackground=tema["entrada"],
        background=tema["entrada"],
        foreground=tema["texto_entrada"]
    )

    # Ventana principal
    ventana.configure(
        bg=tema["fondo"]
    )


def obtener_tema(nombre_tema):
    """
    Devuelve los colores del tema seleccionado.
    """

    return TEMAS[nombre_tema]