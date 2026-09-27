"""
controllers/personal_controller.py
────────────────────────────────────
CONTROLADOR de Personal: valida la entrada, llama al PersonalModel y
actualiza la PersonalView con el resultado.
"""

from tkinter import messagebox

from models.personal_model import PersonalModel
from views.personal_view import PersonalView
from utils.validators import validate_required, validate_numeric


TREE_KEYS = [
    "ID",
    "nombre",
    "apellido",
    "especialidad",
    "disponibilidad",
    "contacto"
]


class PersonalController:

    def __init__(self, parent, db):

        self.model = PersonalModel(db)

        self.view = PersonalView(parent, self)

        self.view.pack(
            fill="both",
            expand=True
        )

        self.cargar_lista()


    def guardar(self):

        data = self.view.get_form_data()

        if not validate_required(data["nombre"]):
            messagebox.showerror(
                "Validación",
                "El nombre es obligatorio."
            )
            return

        if not validate_required(data["apellido"]):
            messagebox.showerror(
                "Validación",
                "El apellido es obligatorio."
            )
            return

        success, result = self.model.insert(
            data["nombre"],
            data["apellido"],
            data["especialidad"] or None,
            data["disponibilidad"] or None,
            data["contacto"] or None
        )

        if success:

            messagebox.showinfo(
                "Éxito",
                "Personal guardado correctamente."
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

        ok, personal_id = validate_numeric(data["ID"])

        if not ok or personal_id is None:

            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )

            return

        if not validate_required(data["nombre"]):

            messagebox.showerror(
                "Validación",
                "El nombre es obligatorio."
            )

            return

        if not validate_required(data["apellido"]):

            messagebox.showerror(
                "Validación",
                "El apellido es obligatorio."
            )

            return

        success, result = self.model.update(
            personal_id,
            data["nombre"],
            data["apellido"],
            data["especialidad"] or None,
            data["disponibilidad"] or None,
            data["contacto"] or None
        )

        if success:

            messagebox.showinfo(
                "Éxito",
                "Personal actualizado correctamente."
            )

            self.cargar_lista()

        else:

            messagebox.showerror(
                "Error",
                f"Error al actualizar: {result}"
            )


    def eliminar(self):

        data = self.view.get_form_data()

        ok, personal_id = validate_numeric(data["ID"])

        if not ok or personal_id is None:

            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )

            return

        if not messagebox.askyesno(
            "Confirmar",
            "¿Deseas eliminar este registro de personal?"
        ):

            return

        success, result = self.model.delete(personal_id)

        if success:

            messagebox.showinfo(
                "Éxito",
                "Registro eliminado correctamente."
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

        ok, personal_id = validate_numeric(data["ID"])

        if not ok or personal_id is None:

            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )

            return

        success, result = self.model.get_by_id(personal_id)

        if success and result:

            self.view.set_form_data(
                dict(zip(TREE_KEYS, result[0]))
            )

        else:

            messagebox.showinfo(
                "No encontrado",
                "No se encontró el registro de personal."
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