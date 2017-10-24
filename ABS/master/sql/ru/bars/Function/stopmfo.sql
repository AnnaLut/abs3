
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/stopmfo.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.STOPMFO (P_MFO VARCHAR2)
   RETURN NUMBER
IS
   l_mfo   banks.mfo%TYPE;
BEGIN
   SELECT MFO
     INTO l_mfo
     FROM BANKS$BASE
    WHERE mfo = p_mfo AND MFOU IN ('300465', '820172') and blk=0;
   --
   RETURN 1;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN 0;
END stopmfo;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/stopmfo.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 