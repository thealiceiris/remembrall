from PyPDF2 import PdfReader
from langchain_community.llms import OpenAI
from langchain.llms import OpenAI
from langchain_community.vectorstores import FAISS
from langchain.chains.question_answering import load_qa_chain
from langchain.embeddings.openai import OpenAIEmbeddings
from langchain.text_splitter import RecursiveCharacterTextSplitter
import os
from langchain.embeddings.openai import OpenAIEmbeddings



os.environ['OPENAI_API_KEY'] = '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'

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
    VectorStore = FAISS.from_texts(chunks, embeddings)

    return VectorStore

def ask_question(pdf_path, query):
    docs = process_pdf(pdf_path).similarity_search(query=query, k=3)
    llm = OpenAI()
    chain = load_qa_chain(llm=llm, chain_type='stuff')
    response = chain.run(input_documents=docs, question=query)
    return response

def main():
    # Specify the path to the folder containing PDF files
    pdf_folder_path = './documents/'

    for pdf_file in os.listdir(pdf_folder_path):
        if pdf_file.endswith('.pdf'):
            print(f'Remembrally: {pdf_file}')
            pdf_path = os.path.join(pdf_folder_path, pdf_file)

            query = input("Ask a question about ADHD: ")
            if query:
                response = ask_question(pdf_path, query)
                print(response)

if __name__ == '__main__':
    main()
