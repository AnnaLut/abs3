

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RET_PAY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RET_PAY ***

  CREATE OR REPLACE PROCEDURE BARS.RET_PAY ( ref_ NUMBER)  IS             -- Reference number
-- Версия 4
-- 2011-06-24 добавив вставку в oper_visa
sos_    NUMBER;
dat_    DATE;
dapp_   DATE;
acc_    NUMBER;
accc_   NUMBER;
stmt_   NUMBER := -1;
fl_     NUMBER;
j       NUMBER;
ms_     NUMBER;
kv_     NUMBER;
mkv_    NUMBER;
rato_   NUMBER;
ratb_   NUMBER;
rats_   NUMBER;
lev_    NUMBER :=5;
reason_id VARCHAR2(2) := '15';
CURSOR c0 IS
SELECT ref,fdat,tt,dk,acc,s,sq,stmt,txt,NVL(sos,0) sos,rowid FROM opldok
 WHERE ref = ref_ AND NVL(sos,0) <= lev_
   AND EXISTS
     ( SELECT 1 FROM oper
        WHERE (tt in (select tt from tts_buy_sell)) AND ref=ref_ AND vdat=trunc(sysdate) AND sos=5
          AND pdat+15/24/60 >= SYSDATE )
    ORDER BY sos,stmt
   FOR UPDATE OF ref NOWAIT;

ern         CONSTANT POSITIVE := 204;
err         EXCEPTION;
erm         VARCHAR2(80);


BEGIN
   dat_:=gl.bDATE;

-- Идем по бухмодели, платим обратные фактически, другие - убиваем

   FOR c IN c0 LOOP
      IF c.sos = 0 THEN  -- c.sos = 0
         DELETE FROM opldok WHERE rowid=c.rowid;
      ELSIF c.sos IN (1,3,4,5) THEN  -- c.sos = 1,3,4,5

         IF c.sos = 3 THEN gl.bDATE := CASE WHEN lev_>5 THEN c.fdat ELSE dat_ END - 1; END IF;

         if c.stmt=stmt_ then
            fl_ := 0;
         else
            fl_ := 1; stmt_ := c.stmt;
         end if;

         gl.pay2 ( NULL, c.ref,
                   CASE WHEN lev_>5 THEN c.fdat ELSE dat_ END,
                  'BAK',NULL,
                     1 - c.dk,
                         c.acc,
                         c.s,
                         c.sq,fl_,
              'СТОРНО '||c.txt);

         IF c.sos = 5 THEN sos_:=5;
         ELSIF c.sos = 4 THEN sos_:=5;
            UPDATE opldok SET sos=4 WHERE rowid=gl.aOROW;
         ELSE   -- sos 1,3
            DELETE FROM opldok WHERE rowid IN (c.rowid, gl.aOROW);
         END IF;
         gl.bDATE := dat_;
      ELSE
         raise_application_error(-(20000+ern),
         '\9322 - Invalid transaction sos #'||c.sos, TRUE);
      END IF;
   END LOOP;

   If sos_ = 5 then
      gl.pay ( 2, ref_, dat_);

     UPDATE oper SET sos = -2 WHERE ref = ref_;

       Insert into BARS.OPER_VISA     (REF, DAT, USERID, STATUS)
         Values    (ref_, sysdate, user_id,   3);


      begin
         INSERT INTO operw (ref,tag,value) VALUES (ref_,'BACKR',reason_id);
      exception when others then
         if (sqlcode = -0001) then null; else raise; end if;
      end;
      else
   raise_application_error(-(20000+ern),  '\9322 Увага!!! - Сторнування валютно обмінної операції референс документа №  '||ref_||' не проведено(порушено умови сторнування валютно-обмінних операцій)', TRUE);
   end if;

EXCEPTION WHEN OTHERS THEN gl.bDATE := dat_;RAISE;
END;
/
show err;

PROMPT *** Create  grants  RET_PAY ***
grant EXECUTE                                                                on RET_PAY         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RET_PAY         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RET_PAY.sql =========*** End *** =
PROMPT ===================================================================================== 
