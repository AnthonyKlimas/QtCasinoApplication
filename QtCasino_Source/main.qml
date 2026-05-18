import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtMultimedia


Window {
    width: 1080
    height: 720
    visible: true
    title: qsTr("Athena's Casino")

    //Create bool for login screen
    property bool loginScreen: false
    //Create bool for signup screen
    property bool signupScreen: false
    //Create bool for main menu screen
    property bool mainmenu: true
    //Create bool for error message
    property bool errormessage: false
    //Create string for error message
    property string errortext: "Please Try Again!"
    //Game screen bool for game
    property bool gameScreen: false
    //Create bool for success message
    property bool successMessage: false
    //Refresh cards after button press
    property int refreshCards: 0
    //Refesh player hit
    property int refreshCardHit: 0
    //Refresh Dealer hit
    property int refreshCardStand: 0
    //Store Balance
    property real balance: 0
    //Store Username
    property string username: ""
    //Store Password
    property string password: ""
    //Store bet
    property real bet: 0
    //Bet chip image
    property string betImage: ""
    //Create bool for when gameisPlaying
    property bool gamePlaying: false
    //Create bool for dealer winning
    property bool dealerWins: false
    //Create bool for push
    property bool push: false
    //Create bool for player winning
    property bool playerWins: false
    //Create bool for hitting stand button
    property bool stand: false

    function resetCards()
    {
        playerCard1.visible = false
        playerCard2.visible = false
        playerCard3.visible = false
        playerCard4.visible = false
        playerCard5.visible = false
        playerCard6.visible = false

        dealerCard1.visible = false
        dealerCard2.visible = false
        dealerCard3.visible = false
        dealerCard4.visible = false
        dealerCard5.visible = false
        dealerCard6.visible = false


        refreshCards = 0
        refreshCardHit = 0

        dealerWins = false
        playerWins = false
        push = false
        stand = false

        playerCard1.y = 1000
        playerCard2.y = 1000
        playerCard3.y = 1000
        playerCard4.y = 1000
        playerCard5.y = 1000
        playerCard6.y = 1000

        dealerCard1.y = -500
        dealerCard2.y = -500
        dealerCard3.y = -500
        dealerCard4.y = -500
        dealerCard5.y = -500
        dealerCard6.y = -500
    }

    onGameScreenChanged:
    {
        if(gameScreen)
        {
            backgroundMusic.stop()
        }
        else
        {
            backgroundMusic.play()
        }
    }

    //Music Playing
    MediaPlayer
    {
        id: backgroundMusic

        source: "qrc:/music/casino.mp3"

        audioOutput: AudioOutput
        {
            id: backgroundAudio

            volume: 1

        }

        autoPlay: true

        loops: MediaPlayer.Infinite

    }



    //Homescreen image
    Image
    {
        anchors.fill: parent

        visible: !gameScreen

        source: "qrc:/images/homescreen.png"

        fillMode: Image.PreserveAspectCrop
    }


    //Animated Dog Gif
    AnimatedImage
    {
        id: athenagif

        property bool flipImage: false

        source: "qrc:/images/athena.gif"

        width: 128
        height: 128

        y: 500

        smooth: false

        visible: !gameScreen



        transform: Scale
        {
            origin.x: athenagif.width / 2
            origin.y: athenagif.height / 2

            xScale:
                athenagif.flipImage
                ? -1
                : 1
        }

        SequentialAnimation on x
        {
            loops: Animation.Infinite

            ScriptAction
            {
                script:
                {
                    athenagif.flipImage = false
                }
            }

            NumberAnimation
            {
                from: 0
                to: 950

                duration: 5000
            }

            ScriptAction
            {
                script:
                {
                    athenagif.flipImage = true
                }
            }

            NumberAnimation
            {
                from: 950
                to: 0

                duration: 5000
            }
        }

    }

    //Game Screen Felt Image
    Image
    {
        anchors.fill: parent

        visible: gameScreen

        source: "qrc:/images/felt.png"

        fillMode: Image.PreserveAspectCrop
    }

    //Transition
    Image
    {
        id: transitionScreen

        anchors.fill: parent

        opacity: 0.0

        source: "qrc:/images/transition.png"

        fillMode: Image.PreserveAspectCrop

        z: 999
    }

    SequentialAnimation
    {
        id: screenTransition

    ParallelAnimation
    {
        NumberAnimation
        {
            target: transitionScreen

            property: "opacity"

            from: 0.0
            to: 1.0

            duration: 2000
        }

        NumberAnimation
        {
            target: backgroundAudio

            property: "volume"

            from: 1.0
            to: 0.0

            duration: 1000
        }
    }
        ScriptAction
        {
            script:
            {
                mainmenu = false
                loginScreen = false
                signupScreen = false

                gameScreen = true

                backgroundMusic.stop()

                backgroundMusic.source = "qrc:/music/game.mp3"

                backgroundMusic.play()
            }
        }
    ParallelAnimation
    {
        NumberAnimation
        {
            target: transitionScreen

            property: "opacity"

            from: 1.0
            to: 0.0

            duration: 2000
        }

        NumberAnimation
        {
            target: backgroundAudio

            property: "volume"

            from: 0.0
            to: 1.0

            duration: 1000
        }
    }
}

    //Sign Up Button Manual Creation
    Rectangle
    {
        //Id for signup Button
        id: signupButton

        //How big the button is
        width: 150
        height: 50

        //Corner curves of button
        radius: 10

        visible: mainmenu && !gameScreen
        //Color of button with hover ability
        color:
            signupmouse.containsMouse
            ? "gold"
            : "black" //Viszla Brown

        //Scalibility of button when hovered
        scale:
            signupmouse.containsMouse
            ? 1.1
            : 1.0

        //Center Button with window
        anchors.horizontalCenter:
            parent.horizontalCenter

        //Y axis of button
        y: 275

        //Timing of animation of the color changing
        Behavior on color
        {
            ColorAnimation
            {
                duration: 100
            }
        }

        //Timing of animation of the size changing
        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        Text
        {
            //Center text in button
            anchors.centerIn: parent

            //What text in button says
            text: "Sign Up"

            //Color of text in button
            color: "white"

            //Size of text
            font.pixelSize: 25
            //If text is bold
            font.bold: true
            //Text font
            font.family: "Comic Sans"
        }

        MouseArea
        {
            //Id of the item MouseArea
            id: signupmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
                loginScreen = false
                signupScreen = true
                mainmenu = false
                successMessage = false

            }
        }
    }

    //Exit Button Manual Creation
    Rectangle
    {
        //Id for exit Button
        id: exitButton

        //How big the button is
        width: 150
        height: 50

        //Corner curves of button
        radius: 10

        visible: mainmenu && !gameScreen
        //Color of button with hover ability
        color:
            exitmouse.containsMouse
            ? "gold"
            : "black" //Viszla Brown

        //Scalibility of button when hovered
        scale:
            exitmouse.containsMouse
            ? 1.1
            : 1.0

        //Center Button with window
        anchors.horizontalCenter:
            parent.horizontalCenter

        //Y axis of button
        y: 350

        //Timing of animation of the color changing
        Behavior on color
        {
            ColorAnimation
            {
                duration: 100
            }
        }

        //Timing of animation of the size changing
        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        Text
        {
            //Center text in button
            anchors.centerIn: parent

            //What text in button says
            text: "Exit"

            //Color of text in button
            color: "white"

            //Size of text
            font.pixelSize: 25
            //If text is bold
            font.bold: true
            //Text font
            font.family: "Comic Sans"
        }

        MouseArea
        {
            //Id of the item MouseArea
            id: exitmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
                Qt.quit()
            }
        }
    }


    //Login Button Manual Creation
    Rectangle
    {
        //Id for login Button
        id: loginButton

        //How big the button is
        width: 150
        height: 50

        //Corner curves of button
        radius: 10

        visible: mainmenu

        //Color of button with hover ability
        color:
            loginmouse.containsMouse
            ? "gold"
            : "black" //Viszla Brown

        //Scalibility of button when hovered
        scale:
            loginmouse.containsMouse
            ? 1.1
            : 1.0

        //Center Button with window
        anchors.horizontalCenter:
            parent.horizontalCenter

        //Y axis of button
        y: 200

        //Timing of animation of the color changing
        Behavior on color
        {
            ColorAnimation
            {
                duration: 100
            }
        }

        //Timing of animation of the size changing
        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        Text
        {
            //Center text in button
            anchors.centerIn: parent

            //What text in button says
            text: "Login"

            //Color of text in button
            color: "white"

            //Size of text
            font.pixelSize: 25
            //If text is bold
            font.bold: true
            //Text font
            font.family: "Comic Sans"
        }

        MouseArea
        {
            //Id of the item MouseArea
            id: loginmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
                loginScreen = true
                signupScreen = false
                mainmenu = false
                successMessage = false
            }
        }
    }


    //Title Manual Creation
    Item
    {
        id: titleContainer

        width: titleText.width
        height: titleText.height

        anchors.horizontalCenter: parent.horizontalCenter

        visible: !gameScreen

        y: 50


        Text
        {
        id: titleText

        text: "Athena's Casino"

        color:
            titleMouse.containsMouse
            ? "gold"
            : "black" //Viszla Brown

        scale:
            titleMouse.containsMouse
            ? 1.1
            : 1.0

        font.pixelSize: 40
        font.bold: true
        font.family: "Comic Sans"

        Behavior on color
        {
            ColorAnimation
            {
                duration: 200
            }
        }

        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        MouseArea
            {
                id: titleMouse

                anchors.fill: parent

                hoverEnabled: true
            }
        }

    }

    //Sign Up Screen

    //Create Username TextBox
    TextField
    {
        id: usernameField

        width: 300
        height: 25
        font.pixelSize: 18
        font.family: "Comic Sans"
        color: "black"
        placeholderText:
            signupScreen && !loginScreen ? "Create Username" : "Input Username"
        placeholderTextColor: "black"
        verticalAlignment: Text.AlignVCenter

        visible: !mainmenu && !gameScreen

        anchors.horizontalCenter: parent.horizontalCenter

        y: 200

        background: Rectangle
        {
            color: "white"

            radius: 10

            border.color: "black"
            border.width: 2
        }
    }

    //Create Password TextBox
    TextField
    {
        id: passwordField

        width: 300
        height: 25
        font.pixelSize: 18
        font.family: "Comic Sans"
        color: "black"
        placeholderText:
            signupScreen && !loginScreen ? "Create Password" : "Input Password"
        placeholderTextColor: "black"
        verticalAlignment: Text.AlignVCenter

        visible: !mainmenu && !gameScreen

        anchors.horizontalCenter: parent.horizontalCenter

        y: 250

        background: Rectangle
        {
            color: "white"

            radius: 10

            border.color: "black"
            border.width: 2
        }
    }

    //Create Account / Play Button
    Rectangle
    {
        //Id for create account Button
        id: createaccountButton

        //How big the button is
        width: 275
        height: 50

        //Corner curves of button
        radius: 10

        visible: !mainmenu && !gameScreen

        //Color of button with hover ability
        color:
            createaccountmouse.containsMouse
            ? "gold"
            : "black" //Viszla Brown

        //Scalibility of button when hovered
        scale:
            createaccountmouse.containsMouse
            ? 1.1
            : 1.0

        //Center Button with window
        anchors.horizontalCenter:
            parent.horizontalCenter

        //Y axis of button
        y: 300

        //Timing of animation of the color changing
        Behavior on color
        {
            ColorAnimation
            {
                duration: 100
            }
        }

        //Timing of animation of the size changing
        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        Text
        {
            //Center text in button
            anchors.centerIn: parent

            //What text in button says
            text:
                loginScreen && !signupScreen ? "Play" : "Create Account"

            //Color of text in button
            color: "white"

            //Size of text
            font.pixelSize: 25
            //If text is bold
            font.bold: true
            //Text font
            font.family: "Comic Sans"
        }

        MouseArea
        {
            //Id of the item MouseArea
            id: createaccountmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
                if(loginScreen && !signupScreen)
                {
                    let success = backend.login(usernameField.text, passwordField.text)

                    if(success)
                    {
                        //Play Game
                        screenTransition.start()
                        errormessage = false
                        username = usernameField.text
                        password = passwordField.text
                        balance = backend.getBalance(username, password)
                        usernameField.text = ""
                        passwordField.text = ""
                    } else
                    {
                        //Login Failed Try Again
                        console.log("Login Failed")
                        errortext = "Incorrect Username or Password!"
                        errormessage = true
                        usernameField.text = ""
                        passwordField.text = ""

                    }
                }

                if(!loginScreen && signupScreen)
                {
                    if(usernameField.text.length < 5 && passwordField.text.length < 5)
                    {
                        console.log("Username and Password is too short!")
                        errormessage = true
                        errortext = "Username and Password is too short!"
                        usernameField.text = ""
                        passwordField.text = ""
                        return

                    } else if(passwordField.text.length < 5)
                    {
                        console.log("Pssword is too short")
                        errormessage = true
                        errortext = "Password is too short!"
                        usernameField.text = ""
                        passwordField.text = ""
                        return
                    } else if(usernameField.text.length < 5 && passwordField.text.length < 5)
                    {
                        console.log("Username is too short")
                        errormessage = true
                        errortext = "Username is too short!"
                        usernameField.text = ""
                        passwordField.text = ""
                        return
                    }


                    let success = backend.signup(usernameField.text, passwordField.text)

                    if(success)
                    {
                        console.log("Account created")
                        signupScreen = false
                        loginScreen = false
                        mainmenu = true
                        errormessage = false
                        successMessage = true
                        usernameField.text = ""
                        passwordField.text = ""
                    }
                    else
                    {
                        console.log("Signup Failed")
                        errortext = "Username already in use!"
                        errormessage = true
                        usernameField.text = ""
                        passwordField.text = ""
                    }
                }
            }

        }
    }

    //Error Message Text
    Item
    {
        id: errorMessage

        width: error.width
        height: error.height

        anchors.horizontalCenter: parent.horizontalCenter

        visible: errormessage

        y: 150


        Text
        {
        id: error

        text: errortext

        color: "red"

        font.pixelSize: 20
        font.bold: true
        font.family: "Comic Sans"


        }

    }

    //Success Message
    Item
    {
        id: successmessage

        width: success.width
        height: success.height

        anchors.horizontalCenter: parent.horizontalCenter

        visible: successMessage
        y: 150


        Text
        {
        id: success

        text: "Account Created!"

        color: "lime"


        font.pixelSize: 20
        font.bold: true
        font.family: "Comic Sans"


        }

    }

    //Back Button
    Rectangle
    {
        //Id for create account Button
        id: backButton

        //How big the button is
        width: 275
        height: 50

        //Corner curves of button
        radius: 10

        visible: !mainmenu && !gameScreen

        //Color of button with hover ability
        color:
            backmouse.containsMouse
            ? "gold"
            : "black" //Viszla Brown

        //Scalibility of button when hovered
        scale:
            backmouse.containsMouse
            ? 1.1
            : 1.0

        //Center Button with window
        anchors.horizontalCenter: parent.horizontalCenter

        //Y axis of button
        y: 375

        //Timing of animation of the color changing
        Behavior on color
        {
            ColorAnimation
            {
                duration: 100
            }
        }

        //Timing of animation of the size changing
        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        Text
        {
            //Center text in button
            anchors.centerIn: parent

            //What text in button says
            text: "Back"

            //Color of text in button
            color: "white"

            //Size of text
            font.pixelSize: 25
            //If text is bold
            font.bold: true
            //Text font
            font.family: "Comic Sans"
        }

        MouseArea
        {
            //Id of the item MouseArea
            id: backmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
                signupScreen = false
                loginScreen = false
                mainmenu = true
                errormessage = false
                usernameField.text = ""
                passwordField.text = ""

            }

        }
    }



    //GAME SCREEN


    //Deal Button
    Rectangle
    {
        //Id for create account Button
        id: blackjackButton

        //How big the button is
        width: 100
        height: 50

        //Corner curves of button
        radius: 10

        visible: gameScreen && !gamePlaying

        //Color of button with hover ability
        color:
            startBlackJack.containsMouse
            ? "gold"
            : "black" //Viszla Brown

        //Scalibility of button when hovered
        scale:
            startBlackJack.containsMouse
            ? 1.1
            : 1.0

        //Y axis of button
        y: 600
        x: 50

        //Timing of animation of the color changing
        Behavior on color
        {
            ColorAnimation
            {
                duration: 100
            }
        }

        //Timing of animation of the size changing
        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        Text
        {
            //Center text in button
            anchors.centerIn: parent

            //What text in button says
            text: "Deal"

            //Color of text in button
            color: "white"

            //Size of text
            font.pixelSize: 25
            //If text is bold
            font.bold: true
            //Text font
            font.family: "Comic Sans"
        }

        MouseArea
        {
            //Id of the item MouseArea
            id: startBlackJack

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
                    if(bet > 0)
                       {
                        resetCards()
                        backend.startBlackjack()

                        gamePlaying = true

                        //Activate source since cards arent null anymore
                        refreshCards++

                        //Start card Animation
                        playerCard1.visible = true
                        player1Anim.start()


                       }
            }

        }
    }




    //Player First Card
    Image
    {
        id: playerCard1

        visible: false

        width: 120
        height: 180

        scale: 1.5

        x: 400
        y: 1000

        z: 999

        source:
        {
                refreshCards
                backend.getPlayerCardImage(0)
        }
        SequentialAnimation
        {
            id: player1Anim

            NumberAnimation
            {
                target: playerCard1
                property: "y"

                from: 1000
                to: 350

                duration: 500
            }

            onFinished:
            {
                dealerCard1.visible = true
                dealer1Anim.start()
            }
        }
    }

    //Dealer First Card
    Image
    {
        id: dealerCard1

        visible: false

        width: 120
        height: 180

        scale: 1.5

        x: 400
        y: -500

        source:
        {
                refreshCards
                backend.getDealerCardImage(0)
        }
        SequentialAnimation
        {
            id: dealer1Anim

            NumberAnimation
            {
                target: dealerCard1
                property: "y"

                from: -500
                to: 50

                duration: 500
            }

            onFinished:
            {
                playerCard2.visible = true
                player2Anim.start()
            }
        }
    }

    //Player Second Card
    Image
    {
        id: playerCard2

        visible: false

        scale: 1.5

        width: 120
        height: 180

        x: 550
        y: 1000

        source:
        {
                refreshCards
                backend.getPlayerCardImage(1)
        }
        SequentialAnimation
        {
            id: player2Anim

            NumberAnimation
            {
                target: playerCard2
                property: "y"

                from: 1000
                to: 350

                duration: 500
            }

            onFinished:
            {
                dealerCard2.visible = true
                dealer2Anim.start()
            }
        }
    }

    //Dealers Second Card
    Image
    {
        id: dealerCard2

        visible: false

        width: 120
        height: 180

        scale: 1.5

        x: 550
        y: -500


        source:
        {
            if(dealerWins || playerWins || push || stand)
            {
                return backend.getDealerCardImage(1)
            }

            return "qrc:/cards/card_back.png"
        }
        SequentialAnimation
        {
            id: dealer2Anim

            NumberAnimation
            {
                target: dealerCard2
                property: "y"

                from: -500
                to: 50

                duration: 500
            }

            onFinished:
            {
                    if(backend.getDealerScore() === 21 && backend.getPlayerScore() === 21)
                    {
                         push = true
                         gamePlaying = false
                            //Change balance
                         balance += bet
                         bet = 0
                    }else if(backend.getDealerScore() === 21)
                    {
                    dealerWins = true
                    gamePlaying = false
                    //Change bet
                    bet = 0
                    backend.editBalance(username, balance)

                    } else if(backend.getPlayerScore() === 21 && backend.getDealerScore() !== 21)
                    {
                         playerWins = true

                         gamePlaying = false

                            //Change balance
                         balance += bet * 2.5
                         bet = 0
                         backend.editBalance(username, balance)
                    }
            }
        }
    }

    //Dealers Thrid Card
    Image
    {
        id: dealerCard3

        visible: false

        width: 120
        height: 180

        scale: 1.5

        x: 700
        y: -500


        source:
        {
                refreshCardStand
                backend.getDealerCardImage(2)
        }
        SequentialAnimation
        {
            id: dealer3Anim

            NumberAnimation
            {
                target: dealerCard3
                property: "y"

                from: -500
                to: 50

                duration: 500
            }

            onFinished:
            {

                    if(backend.getDealerScore() > 21)
                    {
                        playerWins = true
                        gamePlaying = false

                        balance += bet * 2
                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() > backend.getPlayerScore())
                    {
                        dealerWins = true
                        gamePlaying = false

                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() === backend.getPlayerScore())
                    {
                        push = true
                        gamePlaying = false

                            balance += bet
                            bet = 0
                            backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() < backend.getPlayerScore())
                    {
                        playerWins = true
                        gamePlaying = false

                        balance += bet * 2
                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() < 17)
                    {
                        backend.dealerTurn()

                        refreshCardStand++

                        dealerCard4.visible = true
                        dealer4Anim.start()
                    }


            }
        }

     }

    //Dealer Fourth Card
    Image
    {
        id: dealerCard4

        visible: false

        width: 120
        height: 180

        scale: 1.5

        x: 850
        y: -500


        source:
        {
                refreshCardStand
                backend.getDealerCardImage(3)
        }
        SequentialAnimation
        {
            id: dealer4Anim

            NumberAnimation
            {
                target: dealerCard4
                property: "y"

                from: -500
                to: 50

                duration: 500
            }

            onFinished:
            {

                    if(backend.getDealerScore() > 21)
                    {
                        playerWins = true
                        gamePlaying = false

                        balance += bet * 2
                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() > backend.getPlayerScore())
                    {
                        dealerWins = true
                        gamePlaying = false

                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() === backend.getPlayerScore())
                    {
                        push = true
                        gamePlaying = false

                            balance += bet
                            bet = 0
                            backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() < backend.getPlayerScore())
                    {
                        playerWins = true
                        gamePlaying = false

                        balance += bet * 2
                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() < 17)
                    {
                        backend.dealerTurn()

                        refreshCardStand++

                        dealerCard5.visible = true
                        dealer5Anim.start()
                    }

            }
        }

     }

    //Dealer Fifth Card
    Image
    {
        id: dealerCard5

        visible: false

        width: 120
        height: 180

        scale: 1.5

        x: 900
        y: -500


        source:
        {
                refreshCardStand
                backend.getDealerCardImage(4)
        }
        SequentialAnimation
        {
            id: dealer5Anim

            NumberAnimation
            {
                target: dealerCard5
                property: "y"

                from: -500
                to: 50

                duration: 500
            }

            onFinished:
            {

                    if(backend.getDealerScore() > 21)
                    {
                        playerWins = true
                        gamePlaying = false

                        balance += bet * 2
                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() > backend.getPlayerScore())
                    {
                        dealerWins = true
                        gamePlaying = false

                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() === backend.getPlayerScore())
                    {
                        push = true
                        gamePlaying = false

                            balance += bet
                            bet = 0
                            backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() < backend.getPlayerScore())
                    {
                        playerWins = true
                        gamePlaying = false

                        balance += bet * 2
                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() < 17)
                    {
                        backend.dealerTurn()

                        refreshCardStand++

                        dealerCard6.visible = true
                        dealer6Anim.start()
                    }

            }
        }

     }

    //Dealer Sixth Card
    Image
    {
        id: dealerCard6

        visible: false

        width: 120
        height: 180

        scale: 1.5

        x: 950
        y: -500


        source:
        {
                refreshCardStand
                backend.getDealerCardImage(5)
        }
        SequentialAnimation
        {
            id: dealer6Anim

            NumberAnimation
            {
                target: dealerCard6
                property: "y"

                from: -500
                to: 50

                duration: 500
            }

            onFinished:
            {

                    if(backend.getDealerScore() > 21)
                    {
                        playerWins = true
                        gamePlaying = false

                        balance += bet * 2
                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() > backend.getPlayerScore())
                    {
                        dealerWins = true
                        gamePlaying = false

                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() === backend.getPlayerScore())
                    {
                        push = true
                        gamePlaying = false

                            balance += bet
                            bet = 0
                            backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() >= 17
                             && backend.getDealerScore() < backend.getPlayerScore())
                    {
                        playerWins = true
                        gamePlaying = false

                        balance += bet * 2
                        bet = 0
                        backend.editBalance(username, balance)
                    }
                    else if(backend.getDealerScore() < 17)
                    {
                        backend.dealerTurn()

                        refreshCardStand++

                    }

            }
        }

     }

    //Player Third Card
    Image
    {
        id: playerCard3

        visible: false

        scale: 1.5

        width: 120
        height: 180

        x: 700
        y: 1000

        source:
        {
                refreshCardHit
                backend.getPlayerCardImage(2)
        }
        SequentialAnimation
        {
            id: player3Anim

            NumberAnimation
            {
                target: playerCard3
                property: "y"

                from: 1000
                to: 350

                duration: 500
            }

            onFinished:
            {
                    //If player score is greater than 21
                    if(backend.getPlayerScore() > 21)
                    {
                            dealerWins = true
                            gamePlaying = false
                            bet = 0
                            backend.editBalance(username, balance)
                    }
            }
        }
    }

    //Player Fourth Card
    Image
    {
        id: playerCard4

        visible: false

        scale: 1.5

        width: 120
        height: 180

        x: 850
        y: 1000

        source:
        {
                refreshCardHit
                backend.getPlayerCardImage(3)
        }
        SequentialAnimation
        {
            id: player4Anim

            NumberAnimation
            {
                target: playerCard4
                property: "y"

                from: 1000
                to: 350

                duration: 500
            }

            onFinished:
            {
                    //If player score is greater than 21
                    if(backend.getPlayerScore() > 21)
                    {
                            dealerWins = true
                            gamePlaying = false
                            bet = 0
                            backend.editBalance(username, balance)

                    }
            }
        }
    }

    //Player Fifth Card
    Image
    {
        id: playerCard5

        visible: false

        scale: 1.5

        width: 120
        height: 180

        x: 900
        y: 1000

        z: 1

        source:
        {
                refreshCardHit
                backend.getPlayerCardImage(4)
        }
        SequentialAnimation
        {
            id: player5Anim

            NumberAnimation
            {
                target: playerCard5
                property: "y"

                from: 1000
                to: 350

                duration: 500
            }

            onFinished:
            {
                    //If player score is greater than 21
                    if(backend.getPlayerScore() > 21)
                    {
                            dealerWins = true
                            gamePlaying = false
                            bet = 0
                            backend.editBalance(username, balance)

                    }
            }
        }
    }

    //Player Sixth Card
    Image
    {
        id: playerCard6

        visible: false

        scale: 1.5

        width: 120
        height: 180

        x: 950
        y: 1000

        z: 1

        source:
        {
                refreshCardHit
                backend.getPlayerCardImage(5)
        }
        SequentialAnimation
        {
            id: player6Anim

            NumberAnimation
            {
                target: playerCard6
                property: "y"

                from: 1000
                to: 350

                duration: 500
            }

            onFinished:
            {
                    //If player score is greater than 21
                    if(backend.getPlayerScore() > 21)
                    {
                            dealerWins = true
                            gamePlaying = false
                            bet = 0
                            backend.editBalance(username, balance)

                    }
            }
        }
    }

    //Hit Button
    Rectangle
    {
        //Id for hit button
        id: hitButton

        //How big the button is
        width: 150
        height: 50

        //Corner curves of button
        radius: 10

        visible: gamePlaying

        //Color of button with hover ability
        color:
            hitbuttonmouse.containsMouse
            ? "gold"
            : "black" //Viszla Brown

        //Scalibility of button when hovered
        scale:
            hitbuttonmouse.containsMouse
            ? 1.1
            : 1.0

        //Y axis of button
        y: 600
        x: 375

        //Timing of animation of the color changing
        Behavior on color
        {
            ColorAnimation
            {
                duration: 100
            }
        }

        //Timing of animation of the size changing
        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        Text
        {
            //Center text in button
            anchors.centerIn: parent

            //What text in button says
            text: "Hit"

            //Color of text in button
            color: "white"

            //Size of text
            font.pixelSize: 25
            //If text is bold
            font.bold: true
            //Text font
            font.family: "Comic Sans"
        }

        MouseArea
        {
            //Id of the item MouseArea
            id: hitbuttonmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {

                //Hit Card 3
                if(refreshCardHit == 0)
                {
                backend.playerHit()

                refreshCardHit++

                playerCard3.visible = true
                player3Anim.start()
                //Hit card 4
                } else if (refreshCardHit == 1)
                {
                backend.playerHit()

                refreshCardHit++
                playerCard4.visible = true
                player4Anim.start()
                //Hit card 5
                } else if (refreshCardHit == 2)
                {
                        backend.playerHit()

                        refreshCardHit++

                        playerCard5.visible = true
                        player5Anim.start()
                //Hit card 6
                } else if (refreshCardHit == 3)
                {
                        backend.playerHit()

                        refreshCardHit++

                        playerCard6.visible = true
                        player6Anim.start()
                }


            }

        }
    }

    //Stand Button
    Rectangle
    {
        //Id for hit button
        id: standButton

        //How big the button is
        width: 150
        height: 50

        //Corner curves of button
        radius: 10

        visible: gamePlaying

        //Color of button with hover ability
        color:
            standbuttonmouse.containsMouse
            ? "gold"
            : "black" //Viszla Brown

        //Scalibility of button when hovered
        scale:
            standbuttonmouse.containsMouse
            ? 1.1
            : 1.0

        //Y axis of button
        y: 600
        x: 550

        //Timing of animation of the color changing
        Behavior on color
        {
            ColorAnimation
            {
                duration: 100
            }
        }

        //Timing of animation of the size changing
        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        Text
        {
            //Center text in button
            anchors.centerIn: parent

            //What text in button says
            text: "Stand"

            //Color of text in button
            color: "white"

            //Size of text
            font.pixelSize: 25
            //If text is bold
            font.bold: true
            //Text font
            font.family: "Comic Sans"
        }

        MouseArea
        {
            //Id of the item MouseArea
            id: standbuttonmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {

                stand = true
                gamePlaying = false
                if(backend.getDealerScore() < 17)
                {
                backend.dealerTurn()
                refreshCardStand++
                dealerCard3.visible = true
                dealer3Anim.start()
                } else if (backend.getDealerScore() >= 17)
                {
                        if(backend.getDealerScore() > backend.getPlayerScore())
                            {
                                dealerWins = true

                                bet = 0
                                backend.editBalance(username, balance)
                            }
                            else if(backend.getDealerScore() < backend.getPlayerScore())
                            {
                                playerWins = true

                                balance += bet * 2

                                bet = 0
                                backend.editBalance(username, balance)
                            }
                            else
                            {
                                push = true

                                balance += bet

                                bet = 0
                                backend.editBalance(username, balance)
                            }
                }


            }

        }
    }

    //Double Button
    Rectangle
    {
        //Id for hit button
        id: doubleButton

        //How big the button is
        width: 150
        height: 50

        //Corner curves of button
        radius: 10

        visible: gamePlaying

        //Color of button with hover ability
        color:
            doublebuttonmouse.containsMouse
            ? "gold"
            : "black" //Viszla Brown

        //Scalibility of button when hovered
        scale:
            doublebuttonmouse.containsMouse
            ? 1.1
            : 1.0

        //Y axis of button
        y: 660
        x: 465

        //Timing of animation of the color changing
        Behavior on color
        {
            ColorAnimation
            {
                duration: 100
            }
        }

        //Timing of animation of the size changing
        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        Text
        {
            //Center text in button
            anchors.centerIn: parent

            //What text in button says
            text: "Double"

            //Color of text in button
            color: "white"

            //Size of text
            font.pixelSize: 25
            //If text is bold
            font.bold: true
            //Text font
            font.family: "Comic Sans"
        }

        MouseArea
        {
            //Id of the item MouseArea
            id: doublebuttonmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
        if(balance >= bet)
        {
                balance -= bet
                bet = bet * 2

                //Hit Card 3
                if(refreshCardHit == 0)
                {
                backend.playerHit()

                refreshCardHit++

                playerCard3.visible = true
                player3Anim.start()
                        stand = true
                        gamePlaying = false
                        if(backend.getDealerScore() < 17)
                        {
                        backend.dealerTurn()
                        refreshCardStand++
                        dealerCard3.visible = true
                        dealer3Anim.start()
                        } else if (backend.getDealerScore() >= 17)
                        {
                                if(backend.getDealerScore() > backend.getPlayerScore())
                                    {
                                        dealerWins = true

                                        bet = 0
                                        backend.editBalance(username, balance)
                                    }
                                    else if(backend.getDealerScore() < backend.getPlayerScore())
                                    {
                                        playerWins = true

                                        balance += bet * 2

                                        bet = 0
                                        backend.editBalance(username, balance)
                                    }
                                    else
                                    {
                                        push = true

                                        balance += bet

                                        bet = 0
                                        backend.editBalance(username, balance)
                                    }
                        }

            }
        }

        }
    }
    }

    //Balance
    Item
    {
        id: displayBalancetext

        visible: gameScreen

        x: 30
        y: 10

        Text
        {
            text: "BALANCE"

            color: "White"

            font.pixelSize: 25
            font.bold: true
            font.family: "Comic Sans"
        }
    }

    //Display balance data
    Item
    {
        id: displayBalance

        visible: gameScreen

        x: 70
        y: 40

        Text
        {
            text: "$" + balance.toFixed(2)

            color: "Lime"

            font.pixelSize: 25
            font.bold: true
            font.family: "Comic Sans"
        }
    }

    SoundEffect
    {
            id: errorSound

            source: "qrc:/music/error.mp3"
    }

    //Red Poker chip
    Image
    {
        id: redpokerchip

        visible: gameScreen && !gamePlaying

        x: 150
        y: 550

        source:
            "qrc:/images/redchip.png"

        scale:
            redchipmouse.containsMouse
            ? 0.75
            : 0.65

        MouseArea
        {
            //Id of the item MouseArea
            id: redchipmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
                if(bet <= balance + (bet - 0.25))
                {
                bet += 0.25
                balance -= 0.25
                betImage = "qrc:/images/redchip.png"
                } else
                {
                errorSound.play()
                }


            }

        }


    }

    //Blue Poker Chip
    Image
    {
        id: bluepokerchip

        visible: gameScreen && !gamePlaying

        x: 300
        y: 550

        source:
            "qrc:/images/bluechip.png"

        scale:
            bluechipmouse.containsMouse
            ? 0.75
            : 0.65

        MouseArea
        {
            //Id of the item MouseArea
            id: bluechipmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {

                    if(bet <= balance + (bet - 1))
                    {
                    bet += 1
                    balance -= 1
                    betImage = "qrc:/images/bluechip.png"
                    } else
                    {
                    errorSound.play()
                    }

            }

        }


    }

    //Green Poker Chip
    Image
    {
        id: greenpokerchip

        visible: gameScreen && !gamePlaying

        x: 450
        y: 550

        source:
            "qrc:/images/greenchip.png"

        scale:
            greenchipmouse.containsMouse
            ? 0.75
            : 0.65

        MouseArea
        {
            //Id of the item MouseArea
            id: greenchipmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
                    if(bet <= balance + (bet - 5))
                    {

                    bet += 5
                    balance -= 5
                betImage = "qrc:/images/greenchip.png"

                    } else
                    {
                    errorSound.play()
                    }

            }

        }


    }

    //Yellow Poker chip
    Image
    {
        id: yellowpokerchip

        visible: gameScreen && !gamePlaying

        x: 600
        y: 550

        source:
            "qrc:/images/yellowchip.png"


        scale:
            yellowchipmouse.containsMouse
            ? 0.75
            : 0.65

        MouseArea
        {
            //Id of the item MouseArea
            id: yellowchipmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
                    if(bet <= balance + (bet - 10))
                    {
                    bet += 10
                    balance -= 10
                        betImage = "qrc:/images/yellowchip.png"
                    } else
                    {
                    errorSound.play()
                    }

            }

        }


    }

    //Purple poker chip
    Image
    {
        id: purplepokerchip

        visible: gameScreen && !gamePlaying

        x: 750
        y: 550

        source:
            "qrc:/images/purplechip.png"

        scale:
            purplechipmouse.containsMouse
            ? 0.75
            : 0.65

        MouseArea
        {
            //Id of the item MouseArea
            id: purplechipmouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
                    if(bet <= balance + (bet - 50))
                    {
                    bet += 50
                    balance -= 50
                    betImage = "qrc:/images/purplechip.png"
                    } else
                    {
                    errorSound.play()
                    }

            }

        }

    }

    //Display currentBet
    Item
    {
        id: currentBet

        visible: gameScreen

        anchors.horizontalCenter: blackjackButton.horizontalCenter

        y: 550

        width: betText.width
        height: betText.height

        Text
        {
        id: betText

            text: "$" + bet.toFixed(2)

            color: "White"

            font.pixelSize: 25
            font.bold: true
            font.family: "Comic Sans"
        }
    }

    //Bet chip Image changes
    Image
    {
        id: betchip

        visible: bet != 0

        anchors.horizontalCenter: currentBet.horizontalCenter


        y: 415

        source:
            betImage

        scale: 0.65


    }

    //Display lose message
    Item
    {
        id: losemessage

        visible: dealerWins

        anchors.horizontalCenter: parent.horizontalCenter

        y: 270

        width: betText.width
        height: betText.height

        Text
        {
        id: loseText

            text: "Lose"

            color: "Red"

            font.pixelSize: 30
            font.bold: true
            font.family: "Comic Sans"
        }
    }

    //Display win message
    Item
    {
        id: winmessage

        visible: playerWins

        anchors.horizontalCenter: parent.horizontalCenter

        y: 270

        width: betText.width
        height: betText.height

        Text
        {
        id: winText

            text: "Win"

            color: "Lime"

            font.pixelSize: 30
            font.bold: true
            font.family: "Comic Sans"
        }
    }

    //Display push message
    Item
    {
        id: pushmessage

        visible: push

        anchors.horizontalCenter: parent.horizontalCenter

        y: 270

        width: betText.width
        height: betText.height

        Text
        {
        id: pushText

            text: "Push"

            color: "Black"

            font.pixelSize: 30
            font.bold: true
            font.family: "Comic Sans"
        }
    }

    //Leave Table Button
    Rectangle
    {
        //Id for leave table Button
        id: leavetable

        //How big the button is
        width: 100
        height: 50

        //Corner curves of button
        radius: 10

        visible: gameScreen && !gamePlaying

        //Color of button with hover ability
        color:
            leavebuttonMouse.containsMouse
            ? "gold"
            : "black" //Viszla Brown

        //Scalibility of button when hovered
        scale:
            leavebuttonMouse.containsMouse
            ? 1.1
            : 1.0

        //Y axis of button
        y: 600
        x: 925

        //Timing of animation of the color changing
        Behavior on color
        {
            ColorAnimation
            {
                duration: 100
            }
        }

        //Timing of animation of the size changing
        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        Text
        {
            //Center text in button
            anchors.centerIn: parent

            //What text in button says
            text: "Leave"

            //Color of text in button
            color: "white"

            //Size of text
            font.pixelSize: 25
            //If text is bold
            font.bold: true
            //Text font
            font.family: "Comic Sans"
        }

        MouseArea
        {
            //Id of the item MouseArea
            id: leavebuttonMouse

            //Changes the item MouseArea to fill the parent (Rectangle)
            anchors.fill: parent

            //Makes the haver Mechanic true
            hoverEnabled: true

            onClicked:
            {
                gameScreen = false
                mainmenu = true
                resetCards()
            }

        }
    }

    //CHIP VALUE TEXT
    Item
    {
        id: redchipvalue

        visible: gameScreen && !gamePlaying


        x: 190
        y: 680


        Text
        {
        id: redchiptext

            text: "$0.25"

            color: "Red"

            font.pixelSize: 25
            font.bold: true
            font.family: "Comic Sans"
        }
    }

    Item
    {
        id: bluechipvalue

        visible: gameScreen && !gamePlaying


        x: 340
        y: 680


        Text
        {
        id: bluechiptext

            text: "$1.00"

            color: "Blue"

            font.pixelSize: 25
            font.bold: true
            font.family: "Comic Sans"
        }
    }

    Item
    {
        id: greenchipvalue

        visible: gameScreen && !gamePlaying


        x: 495
        y: 680


        Text
        {
        id: greenchiptext

            text: "$5.00"

            color: "Green"

            font.pixelSize: 25
            font.bold: true
            font.family: "Comic Sans"
        }
    }

    Item
    {
        id: yellowchipvalue

        visible: gameScreen && !gamePlaying


        x: 635
        y: 680


        Text
        {
        id: yellowchiptext

            text: "$10.00"

            color: "Yellow"

            font.pixelSize: 25
            font.bold: true
            font.family: "Comic Sans"
        }
    }

    Item
    {
        id: purplechipvalue

        visible: gameScreen && !gamePlaying


        x: 785
        y: 680


        Text
        {
        id: purplechiptext

            text: "$50.00"

            color: "Purple"

            font.pixelSize: 25
            font.bold: true
            font.family: "Comic Sans"
        }
    }



}





