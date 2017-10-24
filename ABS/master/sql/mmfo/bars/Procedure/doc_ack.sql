

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DOC_ACK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DOC_ACK ***

  CREATE OR REPLACE PROCEDURE BARS.DOC_ACK ( tt_	IN	VARCHAR2,
                   chk_	IN	VARCHAR2,
                   ack_	OUT	NUMBER    )
IS
idchk_ 	NUMBER;
erm  	VARCHAR2 (80);
ern  	CONSTANT POSITIVE       := 717;
err  	EXCEPTION;
hex1_   CHAR(1);
hex2_   CHAR(1);
BEGIN
   BEGIN
      SELECT  idchk		-- Obtain the Check ID of the
        INTO  idchk_		-- controller with the max priority
        FROM  chklist_tts
       WHERE tt = tt_
         AND priority =
             ( SELECT MAX(priority) -- Get MAX possible priority for
                 FROM chklist_tts   -- the given transaction
                 WHERE tt = tt_ );
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
           ack_ := 1;     -- No acknowlegment expected
           RETURN;
   END;
   ack_ := 0;           -- No acknowleged
   IF chk_ IS NOT NULL THEN
      IF LENGTH ( RTRIM(chk_) ) >= 6 THEN
         hex1_ := SUBSTR ( RTRIM ( chk_ ), -6, 1);
         hex2_ := SUBSTR ( RTRIM ( chk_ ), -5, 1);
         IF idchk_ = (INSTR('0123456789ABCDEF',hex1_)-1)*16+
                      INSTR('0123456789ABCDEF',hex2_)-1 THEN
            ack_ := 1;  -- Acknowleged
         END IF;
      END IF;
   END IF;
   RETURN;
EXCEPTION
   WHEN err
        THEN
            raise_application_error(-(20000+ern),'\'||erm,TRUE);
   WHEN OTHERS
        THEN
	    raise_application_error(-(20000+ern),SQLERRM,TRUE);
END doc_ack;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DOC_ACK.sql =========*** End *** =
PROMPT ===================================================================================== 
