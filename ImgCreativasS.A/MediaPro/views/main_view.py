"""
views/main_view.py
──────────────────
VISTA PRINCIPAL:
Crea la ventana principal y las pestañas del sistema.
"""

import os
import tkinter as tk
from tkinter import ttk
from utils.theme_utils import aplicar_tema


class MainView(tk.Tk):

    def __init__(self):
        super().__init__()

        # =====================================================
        # TÍTULO DE LA VENTANA
        # =====================================================

        self.title("Imágenes Creativas - Sistema de Gestión")
        self.tema_actual = "claro"

        # =====================================================
        # TEMA INICIAL
        # =====================================================
        self.crear_menu()
        aplicar_tema(self, self.tema_actual)

        # =====================================================
        # ICONO DE LA APLICACIÓN
        # =====================================================

        # Ubicación de la carpeta MediaPro
        carpeta_mediapro = os.path.dirname(os.path.dirname(__file__))

        # Ubicación del archivo logo.ico
        ruta_icono = os.path.join(
            carpeta_mediapro,
            "icons",
            "logo.ico"
        )

        # Comprobar la ubicación del icono
        print("RUTA DEL ICONO:", ruta_icono)
        print("¿EXISTE EL ICONO?:", os.path.exists(ruta_icono))

        # Cargar el icono
        if os.path.exists(ruta_icono):
            self.iconbitmap(ruta_icono)
        else:
            print("ADVERTENCIA: No se encontró el archivo logo.ico")

        # =====================================================
        # TAMAÑO DE LA VENTANA
        # =====================================================

        self.geometry("1200x700")
        self.resizable(True, True)

        # =====================================================
        # NOTEBOOK
        # =====================================================

        self.notebook = ttk.Notebook(self)

        # =====================================================
        # PESTAÑAS
        # =====================================================

        self.tab_personal = ttk.Frame(self.notebook)
        self.tab_equipos = ttk.Frame(self.notebook)
        self.tab_localizaciones = ttk.Frame(self.notebook)
        self.tab_planrodaje = ttk.Frame(self.notebook)

        # =====================================================
        # AGREGAR PESTAÑAS
        # =====================================================

        self.notebook.add(
            self.tab_personal,
            text="  Personal  "
        )

        self.notebook.add(
            self.tab_equipos,
            text="  Equipos  "
        )

        self.notebook.add(
            self.tab_localizaciones,
            text="  Localizaciones  "
        )

        self.notebook.add(
            self.tab_planrodaje,
            text="  Plan de Rodaje  "
        )

        # =====================================================
        # MOSTRAR NOTEBOOK
        # =====================================================

        self.notebook.pack(
            expand=True,
            fill="both"
        )

    # =========================================================
    # MENÚ DE TEMAS
    # =========================================================

    def crear_menu(self):

        self.menu_barra = tk.Menu(self)
        self.menu_temas = tk.Menu(
            self.menu_barra,
            tearoff=0
        )

        self.menu_temas.add_command(
            label="☀ Tema claro",
            command=lambda: self.cambiar_tema("claro")
        )

        self.menu_temas.add_command(
             label="🌙 Tema oscuro",
             command=lambda: self.cambiar_tema("oscuro")
        )

        self.menu_barra.add_cascade(
            label="Temas",
            menu=self.menu_temas
        )

        self.config(
                menu=self.menu_barra
        )

    # =========================================================
    # CAMBIAR TEMA
    # =========================================================

    def cambiar_tema(self, nombre_tema):

        self.tema_actual = nombre_tema

        aplicar_tema(
            self,
            nombre_tema
        )

# ==================================================
    # REGISTRAR CONTROLADORES
    # ==================================================

    def registrar_controladores(
        self,
        personal_controller,
        equipos_controller,
        localizacion_controller,
        planrodaje_controller
    ):

        self.personal_controller = personal_controller

        self.equipos_controller = equipos_controller

        self.localizacion_controller = localizacion_controller

        self.planrodaje_controller = planrodaje_controller