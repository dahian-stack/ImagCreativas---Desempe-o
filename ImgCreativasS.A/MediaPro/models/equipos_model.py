"""
models/equipos_model.py
───────────────────────
MODELO de Equipos. Traduce las operaciones del sistema a llamadas de
Stored Procedures (sp_InsertEquipos, sp_UpdateEquipos, sp_DeleteEquipos,
sp_GetEquipos, sp_GetAllEquipos).
"""

from models.database import DatabaseConnector


class EquiposModel:

    def __init__(self, db: DatabaseConnector):
        self.db = db

    def get_all(self):
        return self.db.call_procedure('sp_GetAllEquipos')

    def get_by_id(self, equipo_id: int):
        return self.db.call_procedure(
            'sp_GetEquipos',
            (equipo_id,)
        )

    def insert(
        self,
        categoria,
        marca,
        modelo,
        caracteristicas,
        disponibilidad
    ):
        return self.db.call_procedure(
            'sp_InsertEquipos',
            (
                categoria,
                marca,
                modelo,
                caracteristicas,
                disponibilidad
            )
        )

    def update(
        self,
        equipo_id,
        categoria,
        marca,
        modelo,
        caracteristicas,
        disponibilidad
    ):
        return self.db.call_procedure(
            'sp_UpdateEquipos',
            (
                equipo_id,
                categoria,
                marca,
                modelo,
                caracteristicas,
                disponibilidad
            )
        )

    def delete(self, equipo_id: int):
        return self.db.call_procedure(
            'sp_DeleteEquipos',
            (equipo_id,)
        )