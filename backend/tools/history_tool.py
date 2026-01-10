# backend/tools/history_tool.py
from typing import List, Dict

class MedicalHistoryTool:
    name = "get_medical_history"
    description = "Get complete medical timeline: diagnoses, surgeries, hospitalizations"
    
    def __init__(self, db):
        self.db = db
    
    def execute(self, user_id: str) -> Dict:
        """Comprehensive medical history timeline"""
        history = {
            "diagnoses": list(self.db.diagnoses.find({"user_id": user_id})),
            "surgeries": list(self.db.surgeries.find({"user_id": user_id})),
            "hospitalizations": list(self.db.hospitalizations.find({"user_id": user_id})),
            "vaccinations": list(self.db.vaccinations.find({"user_id": user_id}))
        }
        
        return {
            "timeline": history,
            "critical_events": self._extract_critical(history),
            "last_update": "2026-01-10"
        }
