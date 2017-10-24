

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_NAZN2.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_NAZN2 ***

  CREATE OR REPLACE TRIGGER BARS.TI_NAZN2 
  BEFORE INSERT ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
NEW.kv=980 AND NEW.MFOB='300465' and NEW.NLSB LIKE '2603%'
      ) DECLARE
   ern  CONSTANT POSITIVE := 338;
   err  EXCEPTION;
   erm  VARCHAR2(80);

TYPE words_tab IS TABLE OF VARCHAR2(30);
word words_tab := words_tab('штраф','пеня','пені','реактивна','теплова','лічильника','послуги опалення','суд');

BEGIN
   FOR i IN word.FIRST..word.LAST LOOP
      IF INSTR(:NEW.nazn,word(i))>0 THEN
         :NEW.blk:=8615; EXIT;
      END IF;
   END LOOP;
END;


/
ALTER TRIGGER BARS.TI_NAZN2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_NAZN2.sql =========*** End *** ==
PROMPT ===================================================================================== 
