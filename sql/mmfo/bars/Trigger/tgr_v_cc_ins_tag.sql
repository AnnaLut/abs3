

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TGR_V_CC_INS_TAG.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TGR_V_CC_INS_TAG ***

  CREATE OR REPLACE TRIGGER BARS.TGR_V_CC_INS_TAG 
  INSTEAD OF DELETE OR UPDATE ON "BARS"."V_CC_INS_TAG"
  REFERENCING FOR EACH ROW
  DECLARE
   tmpVar NUMBER;  Str_ VARCHAR2(200); Tag_ VARCHAR2(20);
BEGIN
   Str_:=trim(:NEW.tag);
   Tag_:=pul.Get_Mas_Ini_Val('CC_TAG');

   IF DELETING OR Str_ IS NULL  THEN
      DELETE FROM ND_TXT WHERE tag=Tag_ AND nd=:OLD.ND;
      RETURN;
   END IF;

   IF Tag_='PAN' THEN

      IF LENGTH(Str_)>14 OR LENGTH(Str_)<5 THEN
         RAISE_APPLICATION_ERROR(-20001,
         'Лицевой счет для договора №'||:OLD.ND||' имеет неверную длину!');
      END IF;

      IF SUBSTR(Str_,1,4)<>'2625' THEN
         RAISE_APPLICATION_ERROR(-20001,
         'Балансовый счет для договора №'||:OLD.ND||' указан неверно!');
      END IF;

      SELECT COUNT(nd) INTO tmpVar    FROM CC_DEAL
      WHERE nd IN (SELECT nd FROM ND_TXT WHERE txt=TO_CHAR(Str_)) AND rnk<>:OLD.RNK;
      IF tmpVar>0 THEN
         RAISE_APPLICATION_ERROR(-20001,
         'Лицевой счет '||Str_||' для договора №'||:OLD.ND||' уже зарегистрирован на другого клиента!');
      END IF;

   END IF;

   BEGIN
      INSERT INTO ND_TXT (nd,tag,txt) VALUES (:OLD.ND,Tag_,Str_);
   EXCEPTION WHEN OTHERS THEN
      UPDATE ND_TXT SET txt=Str_ WHERE tag=Tag_ AND nd=:OLD.ND;
   END;

END TGR_V_CC_INS_TAG;



/
ALTER TRIGGER BARS.TGR_V_CC_INS_TAG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TGR_V_CC_INS_TAG.sql =========*** En
PROMPT ===================================================================================== 
