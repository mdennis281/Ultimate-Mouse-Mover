#include <Constants.au3>

;       Title: Ultimate Mouse Mover
;        Desc:
;			This program moves your mouse in an unpredictable manner
;           to simulate user activity. The following paramaters are
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
	; loops until isRunning == False
	While $isRunning
		Sleep(Random ( $MOVE_DELAY_MIN,$MOVE_DELAY_MAX )) 
		MM(Random ( $X_MIN,$X_MAX ),Random ( $Y_MIN,$Y_MAX ))
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

main()