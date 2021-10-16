# import speech_recognition as sr  
   
#  # obtain audio from the microphone  
# r = sr.Recognizer()  
# with sr.Microphone() as source:  
#    print("Please wait. Calibrating microphone...")  
#    # listen for 5 seconds and create the ambient noise energy level  
#    r.adjust_for_ambient_noise(source, duration=5)  
#    print("Say something!")  
#    audio = r.listen(source)  
   
#  # recognize speech using Sphinx  
# try:  
#    print("Sphinx thinks you said '" + r.recognize_sphinx(audio) + "'")  
# except sr.UnknownValueError:  
#    print("Sphinx could not understand audio")  
# except sr.RequestError as e:  
#    print("Sphinx error; {0}".format(e))


import os
import time
import pyttsx3
import datetime
import pyaudio
import wikipedia
import webbrowser
import wolframalpha
import subprocess
import speech_recognition as sr 


engine = pyttsx3.init('sapi5')
voices = engine.getProperty('voices')
# print(voices[0].id)
engine.setProperty('voice', voices[0].id) #male voice
#engine.setProperty('voice', voices[1].id) female voice
def speak(audio):
    engine.say(audio)
    engine.runAndWait()
    pass


def wishMe():
    hour = datetime.datetime.now().hour
    if hour >= 0 and hour < 12:
        speak("Hello, Good Morning.")
        print("Hello, Good Morning.")
    elif hour >= 12 and hour < 18:
        speak("Hello, Good Afternoon.")
        print("Hello, Good Afternoon.")
    else:
        speak("Hello, Good Evening.")
        print("Hello, Good Evening.")


#function for taking command from user
def tackCommand():
    r = sr.Recognizer()    
    with sr.Microphone() as source:
        #print("Listening...")
        r.adjust_for_ambient_noise(source, duration=0.5)
        #r.pause_threshold = 1
        print("Listening...")
        audio = r.listen(source)
    try:
        print("Recognizing...")
        query = r.recognize_google(audio, language = 'en-in')
        print(f"User said: {query}\n")
    except Exception as e:
        print(e)
        speak("please say that again")
        print("please say that again")
        return "None"
    return query




if __name__ == "__main__":
    wishMe()
    # speak("I am Apoorva and Bhoomika.")
    # print("I am Katana.")
    while True:
        speak("What do u want")
        query = tackCommand().lower()

        if 'wikipedia' in query:
            print("Searching Wikipedia...")
            speak("Searching Wikipedia...")
            query = query.replace("wikipedia", "")
            results = wikipedia.summary(query, sentences = 2)
            speak("Accoding to Wikipedia")
            print(results)
            speak(results)

        elif 'current time' in query:
            strTime = datetime.datetime.now().strftime("%H:%M:%S")
            print(f"the current time is {strTime}\n")
            speak(f"the current time is {strTime}")

        elif 'ask' in query:
            #speak("I can answer any computational and geographical question.")
            speak("What question do you want to ask?")
            question = tackCommand()
            appID = "R7V94J-GVT6HVHGHP"
            client = wolframalpha.Client('R7V94J-GVT6HVHGHP')
            res = client.query(question)
            answer = next(res.results).text
            speak(answer)
            print(answer)
        if 'good bye' in query or 'ok bye' in query or 'stop' in query:
            speak("have a gret day sir.")
            print("end")
            break 