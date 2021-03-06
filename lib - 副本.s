
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
  ONE :: %0 % 0.5 ROT ROMPTR 004 007 %2 %* %1 SWAP %- SWAPDROP
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
  SWAPDROP
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
  SWAPDROP
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
	SWAPDROP
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
	SWAPDROP
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
	SWAPDROP
  ;
;
RPL

***** CC make complex number use length and angle

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
	SWAPDROP
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
