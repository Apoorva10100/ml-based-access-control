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
import sys
import speech_recognition as sr


name = ["bhoomika", "apoorva", "bhumika"]
Questions = ["What is your name?", "What is your Employee ID", "What is the name of the project you are currently woking on",
             "Whatis the Name your Supervisor", "What is the role you are assigned to"]
Request = ["Requesting Name", "Requesting Employee ID", "Requesting Project Name",
           "Requesting Supervisor Name", "Requesting the assigned Role"]
UserAnswers = []
DataAnswers = []

name = ''
ID = ''
project_name = ''
supervisor = ''
role = ''
email = ''
otp = ''


r = requests.get("http://localhost:3000/user/getall")
print(r.text)
engine = pyttsx3.init('sapi5')
voices = engine.getProperty('voices')
# print(voices[0].id)
# engine.setProperty('voice', voices[0].id)  # male voice
engine.setProperty('voice', voices[1].id) #female voice


def speak(audio):
    engine.say(audio)
    engine.runAndWait()
    pass

# function for taking command from user


def tackCommand():
    flag = 0
    r = sr.Recognizer()
    # with sr.Microphone(device_index=2) as source:
    with sr.Microphone() as source:
        # print("Listening...")
        r.adjust_for_ambient_noise(source, duration=0.5)
        # r.pause_threshold = 1
        # print("Listening...")
        audio = r.listen(source, phrase_time_limit=4)
    try:
        print("Recognizing...")
        query = r.recognize_google(audio, language='en-us')
        print(f"User said: {query}\n")
    except Exception as e:
        flag = 1
        print(e)
        speak("please say that again")
        print("please say that again")
        return "None", flag
    return query, flag


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


def StartBot():
    getEmail()

    

def UserQuest():
    for i in range(len(Questions)):
        query, flag = quest(i)
        while (flag == 1):
            query, flag = quest(i)
        if(query.lower()!=DataAnswers[i].lower()):
            speak("Can you repeat")
            query, flag = quest(i)
        while (flag == 1):
            query, flag = quest(i)
        
            
        UserAnswers.append(query.lower())
        # speak("Got it!")
        # print("Got it")
    print(UserAnswers)
    print(DataAnswers)
    count=0
    for i in range(len(DataAnswers)):
        if DataAnswers[i].lower() == UserAnswers[i].lower():
            count=count + 1
    print(count)
    print(count/len(DataAnswers)*100)




def getEmail():
    speak("What is your Email ID")
    print("Requesting Email ID")
    mail, flag = tackCommand()
    while (flag == 1):
        getEmail()
    mail = mail.lower().replace(' at ', '@')
    print(mail)
    getOTP(mail)

def getOTP(mail):
    speak("What is the OTP")
    print("Requesting OTP")
    otp1, flag = tackCommand()
    while (flag == 1):
        getOTP(mail)
    if(otp1!=otp):
        speak("OTP is incorrect")
        speak("Refresh and reenter OTP")
        print("Requesting OTP")
        otp1, flag = tackCommand()
        while (flag == 1):
            getOTP(mail)
    if(otp1==otp):
        speak("OTP Accepted")
        print("OTP Success!!")        

    

    getUserDetails(mail)




def getUserDetails(email):
    try:
        data = {'Email': email}
        response = requests.post("http://localhost:3000/user/get", json=data)
        print(response.json()['Employee_Name'])
        DataAnswers.append(response.json()['Employee_Name'].lower())
        DataAnswers.append(response.json()['Employee_ID'].lower())
        DataAnswers.append(response.json()['Project_Name'].lower())
        DataAnswers.append(response.json()['Supervisor_Name'].lower())
        DataAnswers.append(response.json()['Role'].lower())
        otp = response.json()['otp']
        UserQuest()
        
    except:
        speak("Please try again.")
        getEmail()


def quest(i):
    speak(Questions[i])
    print(Request[i])
    query, flag = tackCommand()
    return query, flag


if __name__ == "__main__":
    wishMe()
    StartBot()
