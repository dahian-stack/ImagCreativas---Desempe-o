"""
controllers/main_controller.py
───────────────────────────────
Controlador principal de MediaPro.
"""

from tkinter import messagebox

from models.database import DatabaseConnector
from views.main_view import MainView

from controllers.personal_controller import PersonalController
from controllers.equipos_controller import EquiposController
from controllers.localizacion_controller import LocalizacionController
from controllers.planrodaje_controller import PlanRodajeController


class MainController:

    def __init__(self, db_config: dict):

        # ==========================================
        # BASE DE DATOS
        # ==========================================

        self.db = DatabaseConnector(
            db_config
        )

        # ==========================================
        # VISTA PRINCIPAL
        # ==========================================

        self.view = MainView()

        # ==========================================
        # CONEXIÓN
        # ==========================================

        ok, err = self.db.connect()

        if not ok:

            messagebox.showerror(
                "Error de Conexión",
                f"No se pudo conectar a la base de datos:\n{err}"
            )

            self.view.destroy()

            raise SystemExit(1)

        # ==========================================
        # CONTROLADOR PERSONAL
        # ==========================================

        self.personal_controller = PersonalController(
            self.view.tab_personal,
            self.db
        )

        # ==========================================
        # CONTROLADOR EQUIPOS
        # ==========================================

        self.equipos_controller = EquiposController(
            self.view.tab_equipos,
            self.db
        )

        # ==========================================
        # CONTROLADOR LOCALIZACIONES
        # ==========================================

        self.localizacion_controller = LocalizacionController(
            self.view.tab_localizaciones,
            self.db
        )

        # ==========================================
        # CONTROLADOR PLAN DE RODAJE
        # ==========================================

        self.planrodaje_controller = PlanRodajeController(
            self.view.tab_planrodaje,
            self.db
        )

        # ==========================================
        # REGISTRAR CONTROLADORES EN LA VISTA
        # ==========================================

        self.view.registrar_controladores(
            self.personal_controller,
            self.equipos_controller,
            self.localizacion_controller,
            self.planrodaje_controller
        )

        # ==========================================
        # CERRAR APLICACIÓN
        # ==========================================

        self.view.protocol(
            "WM_DELETE_WINDOW",
            self.on_closing
        )

    # ==================================================
    # CERRAR
    # ==================================================

    def on_closing(self):

        self.db.disconnect()

        self.view.destroy()

    # ==================================================
    # EJECUTAR
    # ==================================================

    def run(self):

        self.view.mainloop()