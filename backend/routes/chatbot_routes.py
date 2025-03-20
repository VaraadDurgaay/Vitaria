import openai
import os
from fastapi import APIRouter
from dotenv import load_dotenv
from models.chatbot import ChatbotQuery

load_dotenv()
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

chatbot_router = APIRouter()

@chatbot_router.post("/")
def chat_with_ai(query: ChatbotQuery):
    if not OPENAI_API_KEY:
        return {"error": "OPENAI_API_KEY is not set."}
    
    try:
        response = openai.ChatCompletion.create(
            model="gpt-4",
            messages=[{"role": "user", "content": query.text}]
        )
        return {"response": response["choices"][0]["message"]["content"]}
    except Exception as e:
        return {"error": str(e)}
