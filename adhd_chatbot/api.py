from flask import Flask, request, jsonify
from PyPDF2 import PdfReader
from langchain_community.llms import OpenAI
from langchain_community.vectorstores import FAISS
from langchain_community.embeddings import OpenAIEmbeddings
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.chains.question_answering import load_qa_chain
import os

os.environ['OPENAI_API_KEY'] = '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'

app = Flask(__name__)

def process_pdf(pdf_path):
    text = ""
    pdf_reader = PdfReader(pdf_path)
    for page in pdf_reader.pages:
        text += page.extract_text()

    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=1000,
        chunk_overlap=200,
        length_function=len
    )
    chunks = text_splitter.split_text(text=text)

    embeddings = OpenAIEmbeddings()
    vector_store = FAISS.from_texts(chunks, embeddings)

    return vector_store

def ask_question(pdf_path, query):
    docs = process_pdf(pdf_path).similarity_search(query=query, k=3)
    llm = OpenAI()
    chain = load_qa_chain(llm=llm, chain_type='stuff')
    response = chain.run(input_documents=docs, question=query)
    return response

@app.route('/', methods=['GET'])
def index():
    return jsonify({'message': 'Ask a Question!'}), 200

@app.route('/predict', methods=['GET'])
def predict_get():
    query = request.args.get('query')
    if query:
        response = process_query(query)
        return jsonify({'response': response})
    else:
        return jsonify({'error': 'No query provided'}), 400

@app.route('/predict', methods=['POST'])
def predict_post():
    data = request.get_json()
    query = data.get('query')
    if query:
        response = process_query(query)
        return jsonify({'response': response})
    else:
        return jsonify({'error': 'No query provided'}), 400

@app.route('/ask', methods=['POST'])
def ask_question_endpoint():
    data = request.get_json()
    question = data.get('question')
    if question:
        response = process_query(question)
        return jsonify({'response': response})
    else:
        return jsonify({'error': 'No question provided'}), 400

def process_query(query):
    pdf_folder_path = './documents/'
    pdf_files = [f for f in os.listdir(pdf_folder_path) if f.endswith('.pdf')]
    
    if not pdf_files:
        return "No documents found."

    combined_response = ""
    for pdf_file in pdf_files:
        pdf_path = os.path.join(pdf_folder_path, pdf_file)
        response = ask_question(pdf_path, query)
        combined_response += f"{response}\n\n"

    return combined_response.strip()

if __name__ == '__main__':
    app.run(debug=True)
