# Updated VITARIAMedicalAgent with no warnings
from langchain.agents import AgentExecutor, create_react_agent
from langchain import hub
from langchain_openai import ChatOpenAI
from tools.history_tool import MedicalHistoryTool
from tools.papers_tool import MedicalPapersTool
from tools.prescription_tool import PrescriptionTool
from tools.user_tool import UserInfoTool
from typing import List, Dict

class VITARIAMedicalAgent:
    def __init__(self, db):
        self.db = db
        self.llm = ChatOpenAI(
            model="gpt-3.5-turbo",
            temperature=0,
            openai_api_key="your-api-key"  # Add your key here
        )
        
        # Initialize tools
        self.tools = [
            {
                "name": "user_profile",
                "func": UserInfoTool(db).execute,
                "description": "Get patient demographics, allergies, contacts"
            },
            {
                "name": "prescription_history",
                "func": PrescriptionTool(db).execute, 
                "description": "Get all medicines, dosages, prescription dates"
            },
            {
                "name": "medical_papers",
                "func": MedicalPapersTool().execute,
                "description": "Latest medical research from PubMed"
            },
            {
                "name": "medical_history",
                "func": MedicalHistoryTool(db).execute,
                "description": "Complete diagnoses, surgeries, hospitalizations timeline"
            }
        ]
        
        # Convert to proper Tool objects
        from langchain.agents import Tool
        langchain_tools = []
        for tool in self.tools:
            langchain_tools.append(
                Tool(
                    name=tool["name"],
                    func=tool["func"],
                    description=tool["description"]
                )
            )
        
        # Create agent (new way)
        prompt = hub.pull("hwchase17/react")
        agent = create_react_agent(
            llm=self.llm,
            tools=langchain_tools,
            prompt=prompt
        )
        
        self.agent_executor = AgentExecutor(
            agent=agent,
            tools=langchain_tools,
            verbose=True,
            handle_parsing_errors=True  # Important for robustness
        )
    
    def query(self, user_id: str, question: str) -> str:
        """Agent decides which tools to use automatically"""
        try:
            result = self.agent_executor.invoke({
                "input": f"Patient ID: {user_id}\nQuestion: {question}"
            })
            return result["output"]
        except Exception as e:
            return f"Error processing query: {str(e)}"