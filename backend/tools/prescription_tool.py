# backend/tools/prescription_tool.py
from typing import List, Dict

class PrescriptionTool:
    name = "get_prescription_history"
    description = "Get all prescriptions with medicines, dosages, frequencies, dates"
    
    def __init__(self, db):
        self.db = db
    
    def execute(self, user_id: str, date_from: str = None) -> List[Dict]:
        """Return structured prescription history"""
        query = {"user_id": user_id}
        if date_from:
            query["uploaded_at"] = {"$gte": date_from}
            
        prescriptions = list(self.db.prescriptions.find(query).sort("uploaded_at", -1))
        
        return [{
            "prescription_id": str(rx["_id"]),
            "date": rx["uploaded_at"],
            "medicines": rx["medicines"],
            "pharmacy": rx.get("pharmacy", "N/A")
        } for rx in prescriptions]
