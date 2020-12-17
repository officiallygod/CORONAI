import numpy as np
import cv2
import sys
import os

# Takes first name and last name via command
# line arguments and then display them
# print("Image Path: " + sys.argv[1])

if sys.argv[1] != "default":
    
    img = cv2.imread(sys.argv[1])
    face = cv2.CascadeClassifier('frontal_face.xml')
    font = cv2.FONT_HERSHEY_SIMPLEX


    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    detect_face = face.detectMultiScale(gray, 1.2, 1)

    for (x, y, w, h) in detect_face:
        img = cv2.rectangle(img, (x, y), (x + w, y + h), (255, 0, 0), 2)
        ROI = gray[x:x+w, y:y+h]
        length = ROI.shape[0]
        breadth = ROI.shape[1]
        Area = length * breadth
        Distance = 149 - 1.08*(10**(-3))*Area + 2.59*(10**(-9))*(Area**2)
        Distance = round(Distance, 2)
        display = str(Distance)
        if Area > 0:
            cv2.putText(img, display, (x, y-10), font,
                        0.5, (255, 255, 0), 2, cv2.LINE_AA)
            print(display)
            
    if detect_face == ():
        print('no_match')
        
    if os.path.exists(sys.argv[1]):
        os.remove(sys.argv[1])

    #cv2.imshow('img', img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

else:
    print("no_image")