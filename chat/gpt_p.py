import openai
import sys
import os

openai.api_key = os.getenv("OPENAI_API_KEY")

def ask_openai(question):
    prompt = question
    if code:
        prompt += f"\n\nHere is the code:\n{code}"
    response = openai.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "system", "content": "You are a helpfule computer science assistant and you will not output more than 50 tokens per response"},
            {"role": "user", "content": prompt}
        ]
    )
    return response.choices[0].message.content

if __name__ == "__main__":
    try:
        with open("/home/rohman/.prompt", 'r') as file:
            question = str(file.read())
    except Exception as e:
        print(f"Error reading the file: {e}")
        sys.exit(1)
    if question == None:
        quesiton = ""
    code = None
    answer = ask_openai(question)
    try:
        with open("/home/rohman/.aiv", 'w') as file:
            file.write(answer)
        print("File has been overwritten successfully.")
    except Exception as e:
        print(f"Error writing to file: {e}")
