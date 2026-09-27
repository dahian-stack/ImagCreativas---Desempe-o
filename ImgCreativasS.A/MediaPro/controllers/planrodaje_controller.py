"""
controllers/planrodaje_controller.py
─────────────────────────────────────
CONTROLADOR de Plan de Rodaje: valida la entrada, llama al
PlanRodajeModel y actualiza la PlanRodajeView con el resultado.
"""

from tkinter import messagebox

from models.planrodaje_model import PlanRodajeModel
from views.planrodaje_view import PlanRodajeView
from utils.validators import validate_required, validate_numeric


TREE_KEYS = [
    "ID",
    "fecha",
    "dia rodaje",
    "eficiencia",
    "requirimientos",
    "plan contigencia"
]


class PlanRodajeController:

    def __init__(self, parent, db):

        self.model = PlanRodajeModel(db)

        self.view = PlanRodajeView(parent, self)

        self.view.pack(
            fill="both",
            expand=True
        )

        self.cargar_lista()


    def guardar(self):

        data = self.view.get_form_data()

        if not validate_required(data["fecha"]):

            messagebox.showerror(
                "Validación",
                "La fecha es obligatoria."
            )

            return

        if not validate_required(data["dia rodaje"]):

            messagebox.showerror(
                "Validación",
                "El día de rodaje es obligatorio."
            )

            return

        if not validate_required(data["eficiencia"]):

            messagebox.showerror(
                "Validación",
                "La eficiencia es obligatoria."
            )

            return

        success, result = self.model.insert(
            data["fecha"],
            data["dia rodaje"],
            data["eficiencia"],
            data["requirimientos"] or None,
            data["plan contigencia"] or None
        )

        if success:

            messagebox.showinfo(
                "Éxito",
                "Plan de rodaje guardado correctamente."
            )

            self.limpiar()
            self.cargar_lista()

        else:

            messagebox.showerror(
                "Error",
                f"Error al guardar: {result}"
            )


    def actualizar(self):

        data = self.view.get_form_data()

        ok, plan_id = validate_numeric(data["ID"])

        if not ok or plan_id is None:

            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )

            return

        if not validate_required(data["fecha"]):

            messagebox.showerror(
                "Validación",
                "La fecha es obligatoria."
            )

            return

        if not validate_required(data["dia rodaje"]):

            messagebox.showerror(
                "Validación",
                "El día de rodaje es obligatorio."
            )

            return

        if not validate_required(data["eficiencia"]):

            messagebox.showerror(
                "Validación",
                "La eficiencia es obligatoria."
            )

            return

        success, result = self.model.update(
            plan_id,
            data["fecha"],
            data["dia rodaje"],
            data["eficiencia"],
            data["requirimientos"] or None,
            data["plan contigencia"] or None
        )

        if success:

            messagebox.showinfo(
                "Éxito",
                "Plan de rodaje actualizado correctamente."
            )

            self.cargar_lista()

        else:

            messagebox.showerror(
                "Error",
                f"Error al actualizar: {result}"
            )


    def eliminar(self):

        data = self.view.get_form_data()

        ok, plan_id = validate_numeric(data["ID"])

        if not ok or plan_id is None:

            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )

            return

        if not messagebox.askyesno(
            "Confirmar",
            "¿Deseas eliminar este plan de rodaje?"
        ):

            return

        success, result = self.model.delete(plan_id)

        if success:

            messagebox.showinfo(
                "Éxito",
                "Plan de rodaje eliminado correctamente."
            )

            self.limpiar()
            self.cargar_lista()

        else:

            messagebox.showerror(
                "Error",
                f"Error al eliminar: {result}"
            )


    def buscar(self):

        data = self.view.get_form_data()

        ok, plan_id = validate_numeric(data["ID"])

        if not ok or plan_id is None:

            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )

            return

        success, result = self.model.get_by_id(plan_id)

        if success and result:

            self.view.set_form_data(
                dict(zip(TREE_KEYS, result[0]))
            )

        else:

            messagebox.showinfo(
                "No encontrado",
                "No se encontró el plan de rodaje."
            )


    def limpiar(self):

        self.view.clear_form()


    def cargar_lista(self):

        success, result = self.model.get_all()

        if success:

            self.view.set_tree_data(result)

        else:

            messagebox.showerror(
                "Error",
                f"No se pudo cargar la lista: {result}"
            )


    def on_select(self, event):

        values = self.view.get_selected_tree_values()

        if values:

            self.view.set_form_data(
                dict(zip(TREE_KEYS, values))
            )