	TITLE EmptyAplet 2.0
**miscdoc+**************************************************
*
*    File: Empty Aplet
* Machine: Enterprise
* Created: October/12/2000 by J.Y Avenard 
* Purpose: Example of code only aplet
* More information can be found there:
* http://www.epita.fr/~avenar_j/hp
*
* To compile it do the following:
* >rplcomp empty.s empty.c
* >sasm -B -W -a empty.l -o empty.o empty.c
* >sload -H empty.m
*
* Then start the HP39G connectivity kit and download the
* aplet to your HP39/40G
**+miscdoc**************************************************

INCLUDE =Entry39.h
INCLUDE =Common.h

ASSEMBLE
	Dir_Head 16,Function Example,604
*                ^1       ^2          ^3
* ^1=Size of the name
* ^2=Aplet's title
* ^3=Library attached to the library. This is compulsory, even if the library is empty
RPL

     StndtType		( This aplet skeleton will only provide access to the "C" type of aplet )


INCLUDE =Sharedvar.h	( Include all the variables needed by the aplet structure )

ASSEMBLE 
	Vfield  L34,IntTable
	CON(5)	=DOHSTR
	REL(5)  endLink
	Link	_Main
	Link	_Entry
	Link	_Exit
	Link	_Action
	Link	_Reset
*>>>	Add links to more routines here, they must
*	be paired w/ the defines just below
	
endLink
RPL

DEFINE Main		INT_00
DEFINE Entry		INT_01
DEFINE Exit		INT_02
DEFINE Action		INT_03
DEFINE Reset		INT_04
*>>>	Add defines for more routines here
*	INT_05..INT_09, INT_0A..INT_0F or BINT INT_NN
*	Use INT_10..INT_1F and INT_NN w/ care !
* Each entry should be in the form of:
* DEFINE LabelName	INT_xx

ASSEMBLE
	Vfield  IntTable,DirVar
RPL
ASSEMBLE
	CON(5)	=DOHSTR
	REL(5)  endCode
RPL

*
* DEFINES to get access to the saved parameters
*
DEFINE	Param@	LastBut3
DEFINE	Param!	LastBut3 REPLACE DROP

* The HP39/40G provides a list of 91 TopicVariables that can contain any kind of object
* Instead of using local variables as on the HP48/49, it's a good idea to use these
* variables instead. The access is really fast and easy. The contain of these variables
* will be preserved while the aplet is running. If you're exiting the view or
* switch to another aplet, the content will be deleted.
* To ease the access to your variables, use alias like:
DEFINE	Arg1!	TopicVar1!
DEFINE	Arg1@	TopicVar1@
DEFINE	Arg2!	TopicVar2!
DEFINE	Arg2@	TopicVar2@

*
* Main code entry
*
NAMELESS _Main
  ::

     StndCheck			( Default handler for the aplet )

* To add a "RESET" option in the VIEWS list, replace StndCheck with the following:
*  {
*    MINUSONE   { { "Start" :: ZERO INT_00 ; } { "Reset" :: EIGHT INT_00 ; } }
*    StndVar StndReset StndEntry StndExit
*  } BinLookup case EVAL EIGHT #= IT Reset


*
* Too see how StndCheck works, look at the definition in =Common.h file
* If you want to change it (warning it's quite tricky)
* It has to be like:
*
*<SOURCE CODE BEGIN>
*{
*   MINUSONE	( VIEWS menu definition )
*   {
*    { "Item1 in VIEWS list"
*      :: ( Associated program ) ;
*    }
*   }
*   MINUSTWO	( Aplet variables [VAR] definition )
*   {
*    "Sketch" {SketchSet}
*    "Note"   {NoteText}
*   }   
*   MINUSTHREE	( Reset Handler: To be enabled the name of the aplet must be MiscAplet )
*   :: ( Reset program here ) ;
*   MINUSFOUR	( Topic Entry Handler )
*   :: ( Topic Entry Handler Here ) ;
*   MINUSFIVE	( Topic Exit Handler )
*   :: ( Topic Exit Handler Here ) ;
*}
*BinLookup case EVAL
*
* ( Here on level one of the stack, you will have a system binary )
* ( The value depends on the requested view by the user )
*
*  ( # may be:	ApLet entered by:	)
*  ( ZERO	plot view		)
*  ( ONE	plot setup view		)
*  ( TWO	numeric view		)
*  ( THREE	numeric setup view	)
*  ( FOUR	symbolic view		)
*  ( FIVE	symbolic. setup view	)
*  ( SIX	note view		)
*  ( SEVEN	sketch view		)
*  
** For each view, the main code is supposed to return 8 arguments (similar to the HP48/49 ParOuterLoop):
** Level: 8: View Entry handler (program)
**        7: View Exit handler (program)
**        6: Display handler (program)
**        5: Hard Key handler (program)
**        4: Flag to allow normal keys (TRUE or FALSE)
**        3: Menu Definition (list)
**        2: Initial Menu Page (System Binary)  
**        1: Error handler (program)
*<SOURCE CODE END>

* Example of a view

     ' Entry			( view entry )
     ' Exit			( view exit )
		
     '				( view display )
	::
	EnsureMenuOff		( **Remove this line if you want the menu to be displayed )
	;
     '				( view hard key handlers )
	::
	  {
	   { kcEnter :: TakeOver Action ; }	( **ENTER will start your main code )
	   NULL{}
	   NULL{}
	   NULL{}
	   NULL{}
	   NULL{}
          }
          ONE KeyFace
       ;
    ( Note for all following quoted objects: as	)
    ( they grow further, it suggested to move	)
    ( them to become [named] INT_xx objects.	)


    TRUE				( **Allow normal keys** )

    {					( **Initial menu** )
    {					( Call Run )
	"RUN"
	::
	( pressing the F1 key will do a short melody. Thanks Detlef for the code )
	    300 554 OVER 659 SEVENTYFIVE 740 150
	    6PICK 4PICK 6PICK 4PICK OVER
	    SIX ZERO
	    DO
		setbeep
	    LOOP
	;
    }
    }
    
    ONE 				( **Initial menu page** )

    '					( **Error object** )
    ::	TURNMENUON RECLAIMDISP		( Ensure AGROB to be displayed when an error occurs )
	ERRJMP
    ;
  ;

NAMELESS _Entry ( -> ) ( Display a short message )
  ::
*
* recall your saved parameters here:
*
	( Get the first value of the list )
	Param@ CARCOMP Arg1!
	( Get the second value of the list )
	Param@ TWO NTHCOMPDROP Arg2!

	TURNMENUOFF
	HARDBUFF
	ZEROZERO BINT_131d SIXTYFOUR
	GROB!ZERODRP
	NULL$ DUP
	$ "to start..."
	$ "Press ENTER"
	NULL$ DUPDUP
	SEVEN ZERO
	DO
	 FOUR EIGHT INDEX@ #*
	 Put5x7
	LOOP
  ;

NAMELESS _Exit ( -> ) ( Display a short message )
  ::
*
* Save your parameters here:
*
   Arg1@ Arg2@ TWO {}N
   Param!
   
   ( Ensure the screen is correctly configured when exiting )
   LeaveGraphView
  ;

NAMELESS _Action ( Put your code here )
  ::	
CODE ( This program does a short ML beep, then exits )
	GOSBVL	=SAVPTR
	LCHEX	01000
	A=C	A
	LCHEX	10000
loop
	OUT=C
	C=C-CON	A,16
	A=A-1	A
	GONC	loop
	GOVLNG	=GETPTRLOOP
ENDCODE
  ;

NAMELESS _Reset
*
* Reset code here
*
::
  {
    ONE
    TWO
    ( Add your default parameters here )
  }
  Param!	( Will save the default parameters into the Aplet structure )
;

ASSEMBLE
endCode
RPL


*****************************************************************************
*		PARAMETER
*****************************************************************************

ASSEMBLE
	Vfield DirVar,DirCode
RPL
* This variable will contain all the saved parameters of the aplet
* You can add your own variable in the list
  {
	ONE
	TWO
*	Add more parameters here
  }

ASSEMBLE
	Vfield DirCode,DirAlt
RPL
  { }

ASSEMBLE
	Vfield DirAlt,DirNot
RPL
  $ "Put your note here"

ASSEMBLE
	Vfield DirNot,DirEnd
RPL
  { }
