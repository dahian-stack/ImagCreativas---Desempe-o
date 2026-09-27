"""
models/planrodaje_model.py
──────────────────────────
MODELO de Plan de Rodaje. Traduce las operaciones del sistema a llamadas
de Stored Procedures (sp_InsertPlanRodaje, sp_UpdatePlanRodaje,
sp_DeletePlanRodaje, sp_GetPlanRodaje, sp_GetAllPlanRodaje).
"""

from models.database import DatabaseConnector


class PlanRodajeModel:

    def __init__(self, db: DatabaseConnector):
        self.db = db

    def get_all(self):
        return self.db.call_procedure(
            'sp_GetAllPlanRodaje'
        )

    def get_by_id(self, plan_id: int):
        return self.db.call_procedure(
            'sp_GetPlanRodaje',
            (plan_id,)
        )

    def insert(
        self,
        fecha,
        dia_rodaje,
        eficiencia,
        requirimientos,
        plan_contigencia
    ):
        return self.db.call_procedure(
            'sp_InsertPlanRodaje',
            (
                fecha,
                dia_rodaje,
                eficiencia,
                requirimientos,
                plan_contigencia
            )
        )

    def update(
        self,
        plan_id,
        fecha,
        dia_rodaje,
        eficiencia,
        requirimientos,
        plan_contigencia
    ):
        return self.db.call_procedure(
            'sp_UpdatePlanRodaje',
            (
                plan_id,
                fecha,
                dia_rodaje,
                eficiencia,
                requirimientos,
                plan_contigencia
            )
        )

    def delete(self, plan_id: int):
        return self.db.call_procedure(
            'sp_DeletePlanRodaje',
            (plan_id,)
        )