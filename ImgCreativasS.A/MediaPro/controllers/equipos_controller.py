"""
controllers/equipos_controller.py
──────────────────────────────────
CONTROLADOR de Equipos: valida la entrada, llama al EquiposModel y
actualiza la EquiposView con el resultado.
"""

from tkinter import messagebox

from models.equipos_model import EquiposModel
from views.equipos_view import EquiposView
from utils.validators import validate_required, validate_numeric


TREE_KEYS = [
    "ID",
    "categoria",
    "marca",
    "modelo",
    "caracteristicas",
    "disponibilidad"
]


class EquiposController:

    def __init__(self, parent, db):

        self.model = EquiposModel(db)

        self.view = EquiposView(parent, self)

        self.view.pack(
            fill="both",
            expand=True
        )

        self.cargar_lista()


    def guardar(self):

        data = self.view.get_form_data()

        if not validate_required(data["categoria"]):

            messagebox.showerror(
                "Validación",
                "La categoría es obligatoria."
            )

            return

        if not validate_required(data["marca"]):

            messagebox.showerror(
                "Validación",
                "La marca es obligatoria."
            )

            return

        if not validate_required(data["modelo"]):

            messagebox.showerror(
                "Validación",
                "El modelo es obligatorio."
            )

            return

        success, result = self.model.insert(
            data["categoria"],
            data["marca"],
            data["modelo"],
            data["caracteristicas"] or None,
            data["disponibilidad"] or None
        )

        if success:

            messagebox.showinfo(
                "Éxito",
                "Equipo guardado correctamente."
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

        ok, equipo_id = validate_numeric(data["ID"])

        if not ok or equipo_id is None:

            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )
            return
        if not validate_required(data["categoria"]):

            messagebox.showerror(
                "Validación",
                "La categoría es obligatoria."
            )
            return
        if not validate_required(data["marca"]):
            messagebox.showerror(
                "Validación",
                "La marca es obligatoria."
            )
            return
        if not validate_required(data["modelo"]):
            messagebox.showerror(
                "Validación",
                "El modelo es obligatorio."
            )

            return
        success, result = self.model.update(
            equipo_id,
            data["categoria"],
            data["marca"],
            data["modelo"],
            data["caracteristicas"] or None,
            data["disponibilidad"] or None
        )
        if success:
            messagebox.showinfo(
                "Éxito",
                "Equipo actualizado correctamente."
            )
            self.cargar_lista()
        else:
            messagebox.showerror(
                "Error",
                f"Error al actualizar: {result}"
            )


    def eliminar(self):
        data = self.view.get_form_data()
        ok, equipo_id = validate_numeric(data["ID"])
        if not ok or equipo_id is None:
            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )

            return
        if not messagebox.askyesno(
            "Confirmar",
            "¿Deseas eliminar este equipo?"
        ):
            return
        success, result = self.model.delete(equipo_id)
        if success:
            messagebox.showinfo(
                "Éxito",
                "Equipo eliminado correctamente."
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
        ok, equipo_id = validate_numeric(data["ID"])
        if not ok or equipo_id is None:
            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )
            return
        success, result = self.model.get_by_id(equipo_id)
        if success and result:
            self.view.set_form_data(
                dict(zip(TREE_KEYS, result[0]))
            )
        else:
            messagebox.showinfo(
                "No encontrado",
                "No se encontró el equipo."
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