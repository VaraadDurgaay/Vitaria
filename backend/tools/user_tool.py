# backend/tools/user_tool.py
from pydantic import BaseModel
from typing import Dict, Any

class UserInfoTool:
    name = "get_user_profile"
    description = "Get complete patient profile including age, gender, allergies, contact info"
    
    def __init__(self, db):
        self.db = db
    
    def execute(self, user_id: str) -> Dict[str, Any]:
        """Fetch patient demographics + preferences"""
        user = self.db.users.find_one({"user_id": user_id})
        return {
            "name": user.get("name", "N/A"),
            "age": user.get("age"),
            "gender": user.get("gender"),
            "allergies": user.get("allergies", []),
            "phone": user.get("phone"),
            "emergency_contact": user.get("emergency_contact")
        }