
* Here you define the library number, make sure it's consistent everywhere
xROMID 604

    TITLE	Little Function example

*****************************************************************************
*		APLET LAYOUT
*****************************************************************************





ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME MYFUNCTION
::
  CK1&Dispatch
  ONE :: %2 %* %1 %+ ;
;
RPL

***** erf function 

ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME ERF
::
  CK1&Dispatch
  ONE :: %0 % 0.5 ROT ROMPTR 004 007 %2 %* %1 SWAP %- 
  ;
*  ONE ::  % 1 FPTR2 ~xBEEP ;
;
RPL

***** erfc function 

ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME ERFC
::
  CK1&Dispatch
  ONE :: %0 % 0.5 ROT ROMPTR 004 007 %2 %* 
   
  ;
;
RPL


***** Q function 

ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME QFUNC
::
  CK1&Dispatch
  ONE :: %0 %1 ROT ROMPTR 004 007 
   
  ;
;
RPL


***** order 0 besselj function 

ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME BJ0
::
  CK1&Dispatch
  ONE :: 
  {
	LAM varx
	}
	BIND
  LAM varx %7 %/ % 20 %^ %1 %+ %1 SWAP %/ DUP 
  %1 %6 %/ %1 %3 %/ LAM varx %2 %/ %COS %* %1 %3 %/ %3 %SQRT LAM varx %* %2 %/ %COS %* %1 %6 %/ LAM varx %COS %* %+ %+ %+ %*
  SWAP
  %1 SWAP %- LAM varx DUP %SGN %PI %* %4 %/ %- %COS %2 %PI LAM varx %ABS %* %/ %SQRT %* %* %+
	ABND
  ;
;
RPL

***** MEL: frequency -> mel

ASSEMBLE
        CON(3)  0
RPL

xNAME MEL
::
  CK1&Dispatch
  ONE ::  % 700 %/ %1 %+ %LN % 1127 %*
  ;
;
RPL


***** IMEL: mel -> frequency

ASSEMBLE
        CON(3)  0
RPL

xNAME IMEL
::
  CK1&Dispatch
  ONE ::  % 1127 %/ %EXP %1 %- % 700 %*
  ;
;
RPL


***** power ratio -> db

ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME DB
::
  CK1&Dispatch
  ONE ::  %LOG %10 %*
   
  ;
;
RPL

***** db->power ratio

ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME IDB
::
  CK1&Dispatch
  ONE :: %10 %/ %ALOG
   
  ;
;
RPL

***** dbm -> power

ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME IDBM
::
  CK1&Dispatch
  ONE :: %10 %/ %3 %- %ALOG
   
  ;
;
RPL

***** power  -> dbm

ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME DBM
::
  CK1&Dispatch
  ONE :: %LOG %3 %+ %10 %*
   
  ;
;
RPL

***** RANDN normal random N(0,1)
ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME RANDN
::
  CK0 %RAN %LN %-2 %* %SQRT %RAN %2 %PI %* %* %COS %*
;
RPL

***** randint(a,b)=> [a,b) function
ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME RANDINT
::
  CK2&Dispatch
  #00011 ::
	OVER %- %RAN %* %+ %FLOOR
	 
  ;
;
RPL

***** EB(s,a) Erlang B function
ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME EB
::
  CK2&Dispatch
  #00011 ::
	%0
	{
	LAM vars
	LAM vara
	LAM varsum
	}
	BIND
	::
	LAM vars COERCE #1 #+ ZERO DO
	LAM vara INDEX@ UNCOERCE %^
	INDEX@ UNCOERCE %FACT %/
	LAM varsum %+ 
	' LAM varsum
	STO
	LOOP
	;
	LAM vara LAM vars %^
	LAM vars %FACT %/
	LAM varsum %/
	ABND
	 
  ;
;
RPL

***** gamma function
ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME GAMMA
::
  CK1&Dispatch
  ONE ::
	%1 %- %FACT
	 
  ;
;
RPL


***** beta function
ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME BETA
::
  CK2&Dispatch
  #00011 ::
	{
	LAM varx
	LAM vary
	}
	BIND
	LAM varx %1 %- %FACT
	LAM vary %1 %- %FACT %*
	LAM varx LAM vary %+ %1 %- %FACT %/
	ABND
	 
  ;
;
RPL

***** CC make complex number use length and angle (%POL>%REC ?)

ASSEMBLE
        CON(3)  0
*         CON(1)  8
RPL

xNAME CC
::
  CK2&Dispatch
  #00011 :: 
	{
	LAM length
	LAM angle
	}
	BIND
	LAM length LAM angle %COS %*
	LAM length LAM angle %SIN %*
	%>C%
	ABND
	 
  ;
;
RPL

**miscdoc+*********************************************************************
** algebraic function property list elements
**+miscdoc*********************************************************************

** help data (if present)    ( Textbook data )


        
* parse data (if present)

        
        
* derivative (if present)

     
* inverse (if present)


* COLCT data (if present)

        
* EXPND data (if present)

        
* FORM menu (if present)

        
* Integral Data (if present)

        
* WHERE Building Data (if present)

        
        
* very-unsyminner Data (if present)

*
* Program to initialize the library at warmstart
*
NULLNAME functioncfg
:: # 604 TOSRRP ;
