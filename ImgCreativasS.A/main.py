"""
main.py
───────
04 — Audiovisuales CRUD con arquitectura MVC
Tkinter + MySQL · GUI carpeta

Misma app que 01_Gui_POO/32_northwind_crud_bd.py (CRUD de Products,
Customers y Employees con Treeview y Stored Procedures), pero separada
en capas:

  models/      - acceso a datos vía Stored Procedures (sin Tkinter)
  views/       - widgets Tkinter puros (sin BD ni reglas de negocio)
  controllers/ - validación + orquestación modelo↔vista (sin SQL directo)

Requiere: pip install mysql-connector-python tkcalendar
BD: Northwindx (ver 03_GUI_DB/northwind_stored_procedures.sql)
"""

from config import DB_CONFIG
from controllers.main_controller import MainController

if __name__ == "__main__":
    app = MainController(DB_CONFIG)
    app.run()
