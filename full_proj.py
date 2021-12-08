import face_recognition
import requests
import time
import pyttsx3
import serial
import datetime
import requests
import speech_recognition as sr

# name = ["bhoomika", "apoorva", "bhumika"]
Questions = ["What is your name?", "What is your Employee ID", "What is the name of the project you are currently woking on",
             "Whatis the Name your Supervisor", "What is the role you are assigned to"]
Request = ["Requesting Name", "Requesting Employee ID", "Requesting Project Name",
           "Requesting Supervisor Name", "Requesting the assigned Role"]
UserAnswers = []
DataAnswers = []
allofit = []
headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0",
           "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
           "Accept-Language": "en-US,en;q=0.9"
           }
name = ''
ID = ''
project_name = ''
supervisor = ''
role = ''
email = ''

otp = ''
k_image =''
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
    # print(UserAnswers)
    # print(DataAnswers)
    count=0
    for i in range(len(DataAnswers)):
        if DataAnswers[i].lower() == UserAnswers[i].lower():
            count=count + 1
    if(count/len(DataAnswers)*100 > 60):
        allofit.append(True)
    recognize_face(email)




def getEmail():
    speak("What is your Email ID")
    print("Requesting Email ID")
    mail, flag = tackCommand()
    mail = mail.lower().replace(' at ', '@')
    print(mail)
    data = {'Email': mail}
    response = requests.post("http://localhost:3000/user/get", json=data)
    # print(response.status_code)
    if (response.status_code == 404):
        speak("Please try again.")
        getEmail()
    else:
        getUserDetails(mail)
        
    

def getOTP(email):
    speak("What is the OTP")
    print("Requesting OTP")
    otp1, flag = tackCommand()
    otp = getOTPdetails(email)
    while (flag == 1):
        getOTP()
    if(otp1!=otp):
        # print("otp: ",otp,"otp1: ",otp1)
        speak("OTP is incorrect")
        speak("Refresh and reenter OTP or Try same OTP again")
        speak("What is the OTP")
        print("Requesting OTP")
        otp1, flag = tackCommand()
        otp = getOTPdetails(email)
        while (flag == 1):
            getOTP()
    if(otp1==otp):
        speak("OTP Accepted")
        print("OTP Success!!")  
    else:
        speak("OTP Incorrect")
        print("Access denied")  


def getOTPdetails(mail):
    data = {'Email': mail}
    response = requests.post("http://localhost:3000/user/get", json=data)
    otp = response.json()['otp']
    return otp




def getUserDetails(email):
    
        data = {'Email': email}
        response = requests.post("http://localhost:3000/user/get", json=data)
        # print(response.json()['Employee_Name'])
        flag=0
        DataAnswers.append(response.json()['Employee_Name'].lower())
        DataAnswers.append(response.json()['Employee_ID'].lower())
        DataAnswers.append(response.json()['Project_Name'].lower())
        DataAnswers.append(response.json()['Supervisor_Name'].lower())
        DataAnswers.append(response.json()['Role'].lower())
        k_image = response.json()['image']
        otp = response.json()['otp']
        # print(k_image, DataAnswers)
        UserQuest()
        
    # except:
    #     speak("Please try again.")
    #     getEmail()


def quest(i):
    speak(Questions[i])
    print(Request[i])
    query, flag = tackCommand()
    return query, flag

def recognize_face(mail):
    speak("Face recognition in progress......")
    print("Face recognition in progress......")
    body = {
        "Email": "picture@test.com"
    }
    rec=[]
    url = "http://localhost:3000/user/getimages/"
    response = requests.post(url, json=body)
    k_images = response.json()
    downloaded_obj = requests.get(k_images, headers=headers).content
    with open("known_image.png", "wb") as file:
        file.write(downloaded_obj)
    known_image = face_recognition.load_image_file("known_image.png")
    for i in range(2,8):
        try:
            unknown_image1 = face_recognition.load_image_file("C:/out/"+str(i)+".bmp")
            known_encoding = face_recognition.face_encodings(known_image)[0]
            unknown_encoding1 = face_recognition.face_encodings(unknown_image1)[0]
            results = face_recognition.compare_faces([known_encoding], unknown_encoding1)
            rec.append(results[0])
        except:
            rec.append(False)
    c = 0
    for i in rec:
        if i == True:
            c += 1
    if (c/len(rec)) >= 0.3:
        allofit.append(True)
    if len(allofit)==2:
        getOTP(mail)
    else:
        for _ in range(0,5):
            speak("ACCESS DENIED. ALERTING SECURITY")
            print("ACCESS DENIED. ALERTING SECURITY")

def getOTP(email):
    speak("What is the OTP")
    print("Requesting OTP")
    otp1, flag = tackCommand()
    otp = getOTPdetails(email)
    while (flag == 1):
        getOTP(email)
    if(otp1!=otp):
        # print("otp: ",otp,"otp1: ",otp1)
        speak("OTP is incorrect")
        speak("Refresh and reenter OTP or Try same OTP again")
        speak("What is the OTP")
        print("Requesting OTP")
        otp1, flag = tackCommand()
        otp = getOTPdetails(email)
        while (flag == 1):
            getOTP()
    if(otp1==otp):
        speak("OTP Accepted")
        print("OTP Success!!") 
        allofit.append(True)
        checkAccess()
    else:
        speak("OTP Incorrect")
     
def checkAccess():
    print(allofit)
    ser = serial.Serial("COM5",9600)
    if len(allofit)== 3:
        speak("ACCESS GRANTED!!!!")
        print("ACCESS GRANTED!!!!")
        time.sleep(2)
        ser.write(b"H")
    else:
        time.sleep(2)
        ser.write(b"L")
        for _ in range(0,5):
            speak("ACCESS DENIED. ALERTING SECURITY")
            print("ACCESS DENIED. ALERTING SECURITY")   
    
    

def getOTPdetails(mail):
    data = {"Email": "picture@test.com"}
    response = requests.post("http://localhost:3000/user/get", json=data)
    otp = response.json()['otp']
    return otp


if __name__ == "__main__":
    wishMe()
    StartBot()

