"""
views/personal_view.py
──────────────────────
VISTA de Personal. Solo widgets Tkinter — sin BD ni validaciones.
"""

import tkinter as tk
from tkinter import ttk


FIELDS = [
    ("ID:",             "ID"),
    ("Nombre:",         "nombre"),
    ("Apellido:",       "apellido"),
    ("Especialidad:",   "especialidad"),
    ("Disponibilidad:", "disponibilidad"),
    ("Contacto:",       "contacto"),
]


TREE_COLUMNS = (
    ("ID", 50),
    ("Nombre", 120),
    ("Apellido", 120),
    ("Especialidad", 120),
    ("Disponibilidad", 110),
    ("Contacto", 120),
)


class PersonalView(ttk.Frame):

    def __init__(self, parent, controller):

        super().__init__(parent)

        self.controller = controller
        self.entries = {}

        self._crear_widgets()


    def _crear_widgets(self):

        main = tk.Frame(self)
        main.pack(
            fill="both",
            expand=True,
            padx=10,
            pady=10
        )

        # ─────────────────────────────────────────────
        # PARTE IZQUIERDA - FORMULARIO
        # ─────────────────────────────────────────────

        left = tk.Frame(main)
        left.pack(
            side="left",
            fill="y",
            padx=(0, 10)
        )

        tk.Label(
            left,
            text="GESTIÓN DE PERSONAL",
            font=("Arial", 14, "bold"),
            fg="#6A4C93"
        ).pack(pady=15)

        form = tk.Frame(left)
        form.pack(padx=20)

        for i, (label, key) in enumerate(FIELDS):

            tk.Label(
                form,
                text=label,
                font=("Arial", 11)
            ).grid(
                row=i,
                column=0,
                sticky="w",
                padx=(0, 8),
                pady=6
            )

            entry = tk.Entry(
                form,
                width=22,
                font=("Arial", 11),
                relief="solid",
                bd=1
            )

            entry.grid(
                row=i,
                column=1,
                sticky="w",
                pady=6
            )

            self.entries[key] = entry


        # ─────────────────────────────────────────────
        # BOTONES
        # ─────────────────────────────────────────────

        btns = tk.Frame(left)
        btns.pack(pady=12)

        for txt, color, cmd in [
            ("Guardar", "#4CAF50",
             lambda: self.controller.guardar()),

            ("Actualizar", "#2196F3",
             lambda: self.controller.actualizar()),

            ("Eliminar", "#f44336",
             lambda: self.controller.eliminar()),

            ("Buscar", "#FF9800",
             lambda: self.controller.buscar()),

            ("Limpiar", "#9E9E9E",
             lambda: self.controller.limpiar()),
        ]:

            tk.Button(
                btns,
                text=txt,
                font=("Arial", 9, "bold"),
                bg=color,
                fg="white",
                width=9,
                command=cmd
            ).pack(
                side="left",
                padx=2
            )


        # ─────────────────────────────────────────────
        # PARTE DERECHA - TABLA
        # ─────────────────────────────────────────────

        right = tk.Frame(main)
        right.pack(
            side="right",
            fill="both",
            expand=True
        )

        tk.Label(
            right,
            text="LISTA DE PERSONAL",
            font=("Arial", 12, "bold")
        ).pack(pady=8)

        frame_tree = tk.Frame(right)
        frame_tree.pack(
            fill="both",
            expand=True,
            padx=10
        )

        cols = [c for c, _ in TREE_COLUMNS]

        self.tree = ttk.Treeview(
            frame_tree,
            columns=cols,
            show="headings",
            height=18
        )

        for col, width in TREE_COLUMNS:
            self.tree.heading(
                col,
                text=col
            )
            self.tree.column(
                col,
                width=width
            )

        scrollbar = ttk.Scrollbar(
            frame_tree,
            orient="vertical",
            command=self.tree.yview
        )

        self.tree.configure(
            yscrollcommand=scrollbar.set
        )

        self.tree.pack(
            side="left",
            fill="both",
            expand=True
        )

        scrollbar.pack(
            side="right",
            fill="y"
        )

        self.tree.bind(
            "<<TreeviewSelect>>",
            lambda e: self.controller.on_select(e)
        )


    # ─────────────────────────────────────────────
    # API USADA POR EL CONTROLADOR
    # ─────────────────────────────────────────────

    def get_form_data(self) -> dict:
        return {
            key: entry.get()
            for key, entry in self.entries.items()
        }


    def set_form_data(self, values: dict):
        for key, entry in self.entries.items():

            entry.delete(
                0,
                tk.END
            )

            val = values.get(key)
            if val is not None:
                entry.insert(
                    0,
                    str(val)
                )


    def clear_form(self):
        for entry in self.entries.values():
            entry.delete(
                0,
                tk.END
            )


    def set_tree_data(self, rows):
        for item in self.tree.get_children():
            self.tree.delete(item)
        for row in rows:
            self.tree.insert(
                "",
                "end",
                values=row
            )


    def get_selected_tree_values(self):
        selection = self.tree.selection()
        if not selection:
            return None
        return self.tree.item(
            selection[0]
        )["values"]