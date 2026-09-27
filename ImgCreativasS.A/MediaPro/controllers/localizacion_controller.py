"""
controllers/localizacion_controller.py
───────────────────────────────────────
CONTROLADOR de Localizaciones: valida la entrada, llama al
LocalizacionModel y actualiza la LocalizacionView con el resultado.
"""

from tkinter import messagebox

from models.localizacion_model import LocalizacionModel
from views.localizacion_view import LocalizacionView
from utils.validators import validate_required, validate_numeric


TREE_KEYS = [
    "ID",
    "Nombre",
    "direccion",
    "tipo",
    "permiso",
    "estado",
    "facilidades"
]


class LocalizacionController:

    def __init__(self, parent, db):

        self.model = LocalizacionModel(db)

        self.view = LocalizacionView(parent, self)

        self.view.pack(
            fill="both",
            expand=True
        )

        self.cargar_lista()


    def guardar(self):

        data = self.view.get_form_data()

        if not validate_required(data["Nombre"]):

            messagebox.showerror(
                "Validación",
                "El nombre es obligatorio."
            )

            return

        if not validate_required(data["direccion"]):

            messagebox.showerror(
                "Validación",
                "La dirección es obligatoria."
            )

            return

        if not validate_required(data["tipo"]):

            messagebox.showerror(
                "Validación",
                "El tipo es obligatorio."
            )

            return

        success, result = self.model.insert(
            data["Nombre"],
            data["direccion"],
            data["tipo"],
            data["permiso"] or None,
            data["estado"] or None,
            data["facilidades"] or None
        )

        if success:

            messagebox.showinfo(
                "Éxito",
                "Localización guardada correctamente."
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

        ok, localizacion_id = validate_numeric(data["ID"])

        if not ok or localizacion_id is None:

            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )

            return

        if not validate_required(data["Nombre"]):

            messagebox.showerror(
                "Validación",
                "El nombre es obligatorio."
            )

            return

        if not validate_required(data["direccion"]):

            messagebox.showerror(
                "Validación",
                "La dirección es obligatoria."
            )

            return

        if not validate_required(data["tipo"]):

            messagebox.showerror(
                "Validación",
                "El tipo es obligatorio."
            )

            return

        success, result = self.model.update(
            localizacion_id,
            data["Nombre"],
            data["direccion"],
            data["tipo"],
            data["permiso"] or None,
            data["estado"] or None,
            data["facilidades"] or None
        )

        if success:

            messagebox.showinfo(
                "Éxito",
                "Localización actualizada correctamente."
            )

            self.cargar_lista()

        else:

            messagebox.showerror(
                "Error",
                f"Error al actualizar: {result}"
            )


    def eliminar(self):

        data = self.view.get_form_data()

        ok, localizacion_id = validate_numeric(data["ID"])

        if not ok or localizacion_id is None:

            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )

            return

        if not messagebox.askyesno(
            "Confirmar",
            "¿Deseas eliminar esta localización?"
        ):

            return

        success, result = self.model.delete(localizacion_id)

        if success:

            messagebox.showinfo(
                "Éxito",
                "Localización eliminada correctamente."
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

        ok, localizacion_id = validate_numeric(data["ID"])

        if not ok or localizacion_id is None:

            messagebox.showerror(
                "Error",
                "Ingresa un ID válido."
            )

            return

        success, result = self.model.get_by_id(localizacion_id)

        if success and result:

            self.view.set_form_data(
                dict(zip(TREE_KEYS, result[0]))
            )

        else:

            messagebox.showinfo(
                "No encontrado",
                "No se encontró la localización."
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