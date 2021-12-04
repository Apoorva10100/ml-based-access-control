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
import requests
import wikipedia
import webbrowser
import wolframalpha
import subprocess
import speech_recognition as sr 


engine = pyttsx3.init('sapi5')
voices = engine.getProperty('voices')
# print(voices[0].id)
engine.setProperty('voice', voices[0].id) #male voice
#engine.setProperty('voice', voices[1].id) #female voice
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
        #print("Listening...")
        audio = r.listen(source)
    try:
        print("Recognizing...")
        query = r.recognize_google(audio, language = 'en-in')
        print(f"User said: {query}\n")
    except Exception as e:
        print(e)
        # speak("please say that again")
        print("please say that again")
        return "None"
    return query



def getUserDetails(email):
    print(email)



def StartBot():
    name =["bhoomika","apoorva","bhumika"]
    Questions = ["What is your email id?", "What is your name?","What is your Employee ID","What is the name of the project you are currently woking on", "Now Name your Supervisor", "What is the role you are assigned to"]
    Request = ["Requesting Name","Requesting Employee ID","Requesting Email ID", "Requesting Project Name","Requesting Supervisor Name", "Requesting the assigned Role"]
    OTP = "Enter your OTP"


    for i in range(len(Questions)):
        speak(Questions[i])
        print(Questions[i])


    speak("What is your name")
    print("Requesting Name..")
    query_name = tackCommand().lower()
    
    if query_name in name:
        speak("Welcome"+query_name)
        print("User found in Database")

        speak("Enter PIN")
        print("Requesting PIN..")
 
        query_PIN = tackCommand().lower()

        if(query_PIN == "123"):
            speak("Access Granted!!")
            print("Access Granted")
        else:
            speak("Incorrect PIN, Access Denied")
            print("Acess Denied")



    else:
        speak("Sorry!! Could not recognize you!!")
        print("Sorry!! Could not recognize you!!")
        StartBot()

   





if __name__ == "__main__":
    
    wishMe()
    StartBot()

    

    
