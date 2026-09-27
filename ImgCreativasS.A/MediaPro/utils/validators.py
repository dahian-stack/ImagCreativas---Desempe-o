"""
utils/validators.py
────────────────────
Validaciones reutilizadas por los controladores. No dependen de Tkinter
ni de la BD — solo transforman/valida texto y devuelven (ok, valor_o_None).
"""

from datetime import datetime


def validate_required(value: str) -> bool:
    return bool(value and value.strip())


def validate_numeric(value: str):
    """Convierte texto vacío a None (campo opcional) o a int/float."""
    if not value or not value.strip():
        return True, None
    try:
        return True, float(value) if '.' in value else int(value)
    except ValueError:
        return False, None


def validate_date(value: str):
    """Convierte 'YYYY-MM-DD' a datetime, o texto vacío a None."""
    if not value or not value.strip():
        return True, None
    try:
        return True, datetime.strptime(value.strip(), "%Y-%m-%d")
    except ValueError:
        return False, None
