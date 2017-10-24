

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/VAL_KU.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure VAL_KU ***

  CREATE OR REPLACE PROCEDURE BARS.VAL_KU (vdat_ DATE, kvUAH_ SMALLINT) IS
kv_     int;
i_      int;
lcv_    CHAR(3);
bsum_   NUMBER(9,4);
vdate1_ DATE;
rateo1_ NUMBER(9,4);
rateb1_ NUMBER(9,4);
rates1_ NUMBER(9,4);
name_   VARCHAR2(35);
dmax_   date;
CURSOR TABVA IS
       SELECT kv,lcv,name
       FROM tabval
       WHERE kv<>kvUAH_ and d_close is null;
CURSOR VALUTES IS
       SELECT bsum,vdate,rate_o,rate_b,rate_s
       FROM   cur_rates
       WHERE  kv=kv_ and vdate<=vdat_
       ORDER  BY vdate desc;
BEGIN
      DELETE FROM TMP_VALK;
      OPEN TABVA;
      LOOP
           FETCH TABVA INTO kv_,lcv_,name_;
           EXIT WHEN TABVA%NOTFOUND;
           OPEN VALUTES;
           i_ := 0;
           LOOP
                FETCH VALUTES INTO bsum_,vdate1_,rateo1_,rateb1_,rates1_;
                EXIT WHEN VALUTES%NOTFOUND;
                IF i_ = 0 THEN
                   INSERT INTO TMP_VALK
                          (kv     ,lcv    ,name   ,bsum   ,vdate1 ,rateo1 ,
                           rateb1 ,rates1 ,vdate2 ,rateo2 ,rateb2 ,rates2 )
                   VALUES (kv_    ,lcv_   ,name_  ,bsum_  ,vdate1_,rateo1_,
                           rateb1_,rates1_,vdate1_,rateo1_,rateb1_,rates1_);
                   i_ := i_ + 1;
                ELSIF i_ = 1 THEN
                   UPDATE TMP_VALK
                   SET vdate2=vdate1_,rateo2=rateo1_,
                       rateb2=rateb1_,rates2=rates1_
                       WHERE kv=kv_;
                   EXIT;
                END IF;
           END LOOP;
           CLOSE VALUTES;
           begin
	      SELECT MAX(DAT)
              INTO dmax_
              FROM DILER_KURS
              WHERE kv=kv_ and trunc(dat)<=trunc(vdat_);
              begin
                 SELECT KURS_B,KURS_S
                 INTO rateb1_,rates1_
                 FROM DILER_KURS
                 WHERE DAT=dmax_ and kv=kv_;
	         UPDATE TMP_VALK
                 SET rateb1=rateb1_,rates1=rates1_
                 WHERE kv=kv_;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                 UPDATE TMP_VALK
                 SET rateb1=rateb1_/bsum,rates1=rates1_/bsum
                 WHERE kv=kv_;
              end;
           EXCEPTION WHEN NO_DATA_FOUND THEN
              null;
           end;
      END LOOP;
      CLOSE TABVA;
END val_ku;
 
/
show err;

PROMPT *** Create  grants  VAL_KU ***
grant EXECUTE                                                                on VAL_KU          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VAL_KU          to OPERKKK;
grant EXECUTE                                                                on VAL_KU          to TECH_MOM1;
grant EXECUTE                                                                on VAL_KU          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/VAL_KU.sql =========*** End *** ==
PROMPT ===================================================================================== 
