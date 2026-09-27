"""
models/personal_model.py
────────────────────────
MODELO de Personal. Traduce las operaciones del sistema a llamadas de
Stored Procedures (sp_InsertPersonal, sp_UpdatePersonal, sp_DeletePersonal,
sp_GetPersonal, sp_GetAllPersonal).
"""

from models.database import DatabaseConnector


class PersonalModel:

    def __init__(self, db: DatabaseConnector):
        self.db = db

    def get_all(self):
        return self.db.call_procedure('sp_GetAllPersonal')

    def get_by_id(self, personal_id: int):
        return self.db.call_procedure(
            'sp_GetPersonal',
            (personal_id,)
        )

    def insert(
            self,
            nombre,
            apellido,
            especialidad,
            disponibilidad,
            contacto
    ):
        return self.db.call_procedure(
            'sp_InsertPersonal',
            (
                nombre,
                apellido,
                especialidad,
                disponibilidad,
                contacto
            )
        )

    def update(
            self,
            personal_id,
            nombre,
            apellido,
            especialidad,
            disponibilidad,
            contacto
    ):
        return self.db.call_procedure(
            'sp_UpdatePersonal',
            (
                personal_id,
                nombre,
                apellido,
                especialidad,
                disponibilidad,
                contacto
            )
        )

    def delete(self, personal_id: int):
        return self.db.call_procedure(
            'sp_DeletePersonal',
            (personal_id,)
        )
