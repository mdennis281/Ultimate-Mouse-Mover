#include <Constants.au3>
#include <WinAPISys.au3>

;       Title: Ultimate Mouse Mover
;        Desc:
;			This program moves your mouse in an unpredictable manner
;           to simulating user activity. The following paramaters are
;			random, and configurable:
;					Mouse Position Range (min/max,x/y)
;					Mouse Movement Speed (min/max)
;					Movement Delay (Min/Max)
;
;
;	   Author: Michael Dennis (https://github.com/mdennis281)
;     Created: 07/17/2019
;     Updated: 06/01/2020

;-------------------------------
;          GLOBALS
;-------------------------------

;Range: 0-100 (lower is faster)
$MIN_MOUSE_SPEED = 2
$MAX_MOUSE_SPEED = 50

;Time to sleep before start (ms)
$START_DELAY = 5000

;The range (in pixels) the program will move the cursor
$X_MIN = 0
$X_MAX = @DesktopWidth ;Pixel width of primary monitor
$Y_MIN = 0
$Y_MAX = @DesktopHeight ;Pixel height of primary monitor

;Delay between mouse movements (ms)
$MOVE_DELAY_MIN = 0
$MOVE_DELAY_MAX = 1000

;Defines the state of the program
$isRunning = True

;Amount of time to pass before determining no user activity
$OVERRIDE_SLEEP = 60000 ;ms

;Override Sound - plays if user moves mouse while script is running
$OVERRIDE_SOUND = "C:\Windows\Media\chord.wav"

;-------------------------------
;          HOTKEYS
;-------------------------------

;when you press escape, LoopFlagToggle is executed (killing the program)
HotKeySet("{esc}","killProgram")



;-------------------------------
;          FUNCTIONS
;-------------------------------

;Main looping part of the program
Func main()
	Sleep($START_DELAY)
	$x = 0
	$y = 0
	; loops until isRunning == False
	While $isRunning

		$x = Int(Random ( $X_MIN,$X_MAX ))
		$y = Int(Random ( $Y_MIN,$Y_MAX ))
		MM($x,$y)
		Sleep(Random ( $MOVE_DELAY_MIN,$MOVE_DELAY_MAX ))
		If Not isMouseAtCoords($x,$y) Then
		   If Not isWindowsLocked() Then 
		      SoundPlay($OVERRIDE_SOUND) 
		   EndIf
		   While Not isMouseAtCoords($x,$y)
			  $mousePos = MouseGetPos()
			  $x = $mousePos[0]
			  $y = $mousePos[1]
			  Sleep($OVERRIDE_SLEEP)
		   WEnd
		EndIf
	WEnd

EndFunc

;function to set global var $isRunning to False (killing the program)
Func killProgram()
	$isRunning = False
EndFunc

; Moves Mouse to passed coordinate
; At random speed
Func MM($x,$y)
	MouseMove ($x,$y,Random($MIN_MOUSE_SPEED,$MAX_MOUSE_SPEED));
EndFunc

Func isMouseAtCoords($x,$y)
   $mousePos = MouseGetPos()

   If $x == $mousePos[0] Then
	  If $y == $mousePos[1] Then
		 Return True
	  EndIf
   EndIf
   Return False
EndFunc


Func isWindowsLocked()
    If _WinAPI_OpenInputDesktop() Then Return False
    Return True
EndFunc

main()