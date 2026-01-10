# backend/tools/papers_tool.py
from typing import List, Dict

class MedicalPapersTool:
    name = "search_medical_papers"
    description = "Search PubMed/Google Scholar for latest medical research papers"
    
    def __init__(self):
        self.pubmed_api = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"
    
    def execute(self, query: str, limit: int = 3) -> List[Dict]:
        """Return top medical research papers"""
        # Mock PubMed data (replace with real API)
        papers = {
            "paracetamol": ["Safety of Paracetamol in Adults (2025)", "NEJM"],
            "metformin": ["Metformin Long-term Effects (2026)", "Lancet"]
        }
        
        return [{
            "title": papers.get(query.lower(), ["No papers found"])[0],
            "source": "PubMed/NEJM",
            "year": 2026,
            "summary": f"Latest research on {query}"
        } for _ in range(limit)]
