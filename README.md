# TodoList-RealmDatabase-iOS
BEFORE OPENING AND RUNNING THE XCWORKSPACE:

    - Delete Podfile.lock
    - Delete Pods Folder
    - Delete .xcworkspace
    
    - Go to terminal:
      - cd Project folder
      - pod init
      - close terminal
    
    - Go to Project Folder:
      - open podfile
      - write above "end":
        - pod 'RealmSwift'
        - save pod file
    
    - open project foler in terminal
      - pod install
    
    This will install all the dependencies and create a new .xcworkspace file
    
    - Now open .xcworkspace file and run in any simulator
