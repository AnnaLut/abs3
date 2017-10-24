

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/VAL_KSBB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure VAL_KSBB ***

  CREATE OR REPLACE PROCEDURE BARS.VAL_KSBB (datbeg_ DATE, datend_ DATE, kvUAH_ SMALLINT) IS
kv_     int;
i_      int;
lcv_    CHAR(3);
bsum_   NUMBER(9,4);
vdate1_ DATE;
rateo1_ NUMBER(9,4);
name_   VARCHAR2(35);
CURSOR TABVA IS
       SELECT kv,lcv,name
       FROM tabval
       WHERE kv<>kvUAH_;
CURSOR VALUTES IS
       SELECT bsum,vdate,rate_o
       FROM   cur_rates
       WHERE  kv=kv_ and vdate>=datbeg_ and vdate<=datend_
       ORDER  BY vdate desc;
BEGIN
      DELETE FROM TMP_VALK;
      OPEN TABVA;
      LOOP
           FETCH TABVA INTO kv_,lcv_,name_;
           EXIT WHEN TABVA%NOTFOUND;
           OPEN VALUTES;
           LOOP
                FETCH VALUTES INTO bsum_,vdate1_,rateo1_;
                EXIT WHEN VALUTES%NOTFOUND;
                   INSERT INTO TMP_VALK
                          (kv ,bsum ,vdate1 ,rateo1 )
                   VALUES (kv_,bsum_,vdate1_,rateo1_);
           END LOOP;
           CLOSE VALUTES;
      END LOOP;
      CLOSE TABVA;
END val_ksbb;
 
/
show err;

PROMPT *** Create  grants  VAL_KSBB ***
grant EXECUTE                                                                on VAL_KSBB        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VAL_KSBB        to OPERKKK;
grant EXECUTE                                                                on VAL_KSBB        to TECH_MOM1;
grant EXECUTE                                                                on VAL_KSBB        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/VAL_KSBB.sql =========*** End *** 
PROMPT ===================================================================================== 
