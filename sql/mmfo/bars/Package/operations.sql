
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/operations.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.OPERATIONS IS
/******************************************************************************
  Настройка операций
    1. Кэшированная работа с флагами операций (GET_FLAG)
******************************************************************************/
  TYPE TVALARRAY IS VARRAY (100) OF NUMBER;
  CURRENT_TTS  CHAR(3) := NULL;
  TTS_VALUES   TVALARRAY;

FUNCTION GET_FLAG(
  tt_id     IN VARCHAR2,
  flag_id   IN NUMBER) RETURN NUMBER;

END OPERATIONS;
/
CREATE OR REPLACE PACKAGE BODY BARS.OPERATIONS IS
FUNCTION GET_FLAG(
  tt_id     IN VARCHAR2,
  flag_id   IN NUMBER) RETURN NUMBER
IS
  PROCEDURE Reload_Flags (
    tt_id     VARCHAR2) IS
    i		      NUMBER := 1;
	i_max	  	  NUMBER;
	FetchNextRow  BOOLEAN := TRUE;
	CURSOR all_flags IS
	SELECT
	  fcode+1 fcode,
	  value
	FROM tts_flags
	WHERE tt=tt_id
	ORDER BY fcode ASC;
	c_af   all_flags%ROWTYPE;
  BEGIN
  	TTS_VALUES := TVALARRAY(0);
    IF TTS_VALUES.COUNT>0 THEN
	  TTS_VALUES.DELETE;
	END IF;
	SELECT MAX(code)+1 INTO i_max FROM flags;
    OPEN all_flags;
  	LOOP
  	  IF FetchNextRow THEN
	    FETCH all_flags INTO c_af;
	  	FetchNextRow := FALSE;
	  END IF;
  	  EXIT WHEN (all_flags%NOTFOUND) AND (i>i_max);
	  TTS_VALUES.EXTEND;
	  IF all_flags%FOUND THEN
	    IF c_af.fcode=i THEN
		  TTS_VALUES(i) := c_af.value;
	  	  FetchNextRow := TRUE;
	    ELSE
		  TTS_VALUES(i) := 0;
	  	END IF;
	  ELSE
		TTS_VALUES(i) := 0;
	  END IF;
	  i := i + 1;
    END LOOP;
    CLOSE all_flags;
  END Reload_Flags;
BEGIN
  IF (CURRENT_TTS<>tt_id) OR (CURRENT_TTS IS NULL) THEN
    Reload_Flags( tt_id );
  END IF;
  IF (flag_id+1) > TTS_VALUES.COUNT THEN
    RETURN 0;
  ELSE
    RETURN TTS_VALUES(flag_id+1);
  END IF;
END GET_FLAG;
END OPERATIONS;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/operations.sql =========*** End *** 
 PROMPT ===================================================================================== 
 