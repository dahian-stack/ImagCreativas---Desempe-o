"""
models/localizacion_model.py
────────────────────────────
MODELO de Localizaciones. Traduce las operaciones del sistema a llamadas
de Stored Procedures (sp_InsertLocalizacion, sp_UpdateLocalizacion,
sp_DeleteLocalizacion, sp_GetLocalizacion, sp_GetAllLocalizaciones).
"""

from models.database import DatabaseConnector


class LocalizacionModel:

    def __init__(self, db: DatabaseConnector):
        self.db = db

    def get_all(self):
        return self.db.call_procedure(
            'sp_GetAllLocalizaciones'
        )

    def get_by_id(self, localizacion_id: int):
        return self.db.call_procedure(
            'sp_GetLocalizacion',
            (localizacion_id,)
        )

    def insert(
        self,
        Nombre,
        direccion,
        tipo,
        permiso,
        estado,
        facilidades
    ):
        return self.db.call_procedure(
            'sp_InsertLocalizacion',
            (
                Nombre,
                direccion,
                tipo,
                permiso,
                estado,
                facilidades
            )
        )

    def update(
        self,
        localizacion_id,
        Nombre,
        direccion,
        tipo,
        permiso,
        estado,
        facilidades
    ):
        return self.db.call_procedure(
            'sp_UpdateLocalizacion',
            (
                localizacion_id,
                Nombre,
                direccion,
                tipo,
                permiso,
                estado,
                facilidades
            )
        )

    def delete(self, localizacion_id: int):
        return self.db.call_procedure(
            'sp_DeleteLocalizacion',
            (localizacion_id,)
        )