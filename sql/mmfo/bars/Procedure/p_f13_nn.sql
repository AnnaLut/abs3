

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F13_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F13_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F13_NN (Dat_ DATE  ,
                                      sheme_ VARCHAR2 DEFAULT 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла #13 для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 26.10.2017 (07/08/2014)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
    sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
09.11.2010 если в OPER занесены внебал.символа, то при обработке внебал.
           символов из табл.OTCN_F13_ZBSK выполняется суммирование
           значений данных сиволов (курсор BaseL)
20/09/2010 убрал ORDER BY в курсоре BASEL
17/09/2010 добавила РЕФ документа в протокол
03.10.2007 для проводки Дт 2600 и Кт 2625 берем ACC Кт счета (ранее было
           ACC Дт счета)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    VARCHAR2(2):='13';
kodf_ext_ VARCHAR2(2):='13';
typ_ NUMBER;

nls_     VARCHAR2(15);
nlsk_    VARCHAR2(15);
mfo_     VARCHAR2(12);
data_    DATE;
kv_      SMALLINT;
s35      DECIMAL(24);
s70      DECIMAL(24);
kodp_    VARCHAR2(10);
znap_    VARCHAR2(30);
sk_      SMALLINT;
sk2_     SMALLINT;
s_       DECIMAL(24);
nbu_     SMALLINT;
kol_     NUMBER;
flag_    NUMBER;
ref_     NUMBER;
userid_  NUMBER;
dat1_    DATE;
dat2_    DATE;
dc_      INTEGER;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);
acc_     NUMBER;
acc1_    NUMBER;
sql_     VARCHAR2(1000):=NULL;
TYPE CURSORType IS REF CURSOR;
CURS_ CURSORType;

--- позабалансовый сим.89 из OPERW (tag='SK_ZB') выручка прошлого месяца
--- проводится в первые числа следующего месяца
CURSOR ZBSIMVOL89 IS
   SELECT  /*+ leading(s) */
         unique o.nlsa, o.kv, p.FDAT,
         SUBSTR(s.value,1,2), p.s, p.ref
   FROM OPER o, OPLDOK p, ACCOUNTS c, OPERW s
   WHERE c.acc=p.acc
     and c.kv=980
     and p.REF=s.REF
     and s.tag='SK_ZB'
     and SUBSTR(s.value,1,2)='89'
     and p.FDAT between Dat_ and Dat2_
     and o.REF=p.REF
     and p.SOS=5
     and p.DK=0 ;

CURSOR BaseL IS
   SELECT kodp, nbuc, SUM (znap)
   FROM RNBU_TRACE
   WHERE TO_NUMBER(kodp)>73
     and comm like 'SK_ZB%'
   GROUP BY kodp,nbuc;
------------------------------------------------------------------------------
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
   logger.info ('P_F13_NN: Begin for '||to_char(dat_,'dd.mm.yyyy'));

   Dat1_ := TRUNC(Dat_, 'MM');
   Dat2_ := TRUNC(Dat_ + 5);

   -- определение наличия табл. OTCN_F13_ZBSK
   SELECT COUNT(*) INTO flag_
   FROM ALL_TABLES
   WHERE owner='BARS' AND table_name = 'OTCN_F13_ZBSK' ;

    IF flag_ > 0 THEN
        sql_ := 'SELECT accd ACC, nlsd NLS, acck ACC1, nlsk NLSK, kv KV, '||
                'fdat DATA, to_char(NVL(SK_ZB,0)) KODP, to_char(s) ZNAP, ref '||
                'FROM  otcn_f13_zbsk '||
                'WHERE NVL(sk_zb,0) > 0 AND fdat BETWEEN :Dat1_ AND :Dat_';
    END IF;

    nbu_:= Isnbubank();

    -- определение начальных параметров
    P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

    P_F12_Nn_sb (Dat_,sheme_,kodf_ext_);
    
    logger.info ('P_F13_NN: End etap 1 for '||to_char(dat_,'dd.mm.yyyy'));
    -------------------------------------------------------------------
    userid_ := user_id;
    -------------------------------------------------------------------
    OPEN ZBSIMVOL89;
    LOOP
       FETCH ZBSIMVOL89 INTO nls_, kv_, data_, sk_, s_, ref_ ;
       EXIT WHEN ZBSIMVOL89%NOTFOUND;

        IF typ_>0 THEN
           nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
        ELSE
           nbuc_ := nbuc1_;
        END IF;

       IF s_<>0 THEN
          kodp_:= lpad(TO_CHAR(sk_), 2, '0');
          znap_:= TO_CHAR(s_);
          INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, nbuc, ref) 
          VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, ref_);
       END IF;
    END LOOP;
    CLOSE ZBSIMVOL89;
    
    logger.info ('P_F13_NN: End etap 2 for '||to_char(dat_,'dd.mm.yyyy'));
    
    -- формирование внебалансовых символов из табл. OTCN_F13_ZBSK
    IF sql_ is not null THEN
       OPEN CURS_ FOR sql_ USING Dat1_, Dat_;

       loop
          fetch CURS_ into acc_, nls_, acc1_, nlsk_, kv_, data_, kodp_, znap_, ref_;
       EXIT WHEN CURS_%NOTFOUND;

       IF substr(nls_,1,3) not in ('262','263') and nls_ not like '2909%' THEN
          nls_:=nlsk_;
          acc_:=acc1_;
       END IF;

       IF typ_>0 THEN
          nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
       ELSE
          nbuc_ := nbuc1_;
       END IF;

       INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, nbuc, ref, comm) VALUES
                                 (nls_, kv_, data_, kodp_, znap_, nbuc_, ref_, 'SK_ZB');
       end loop;

       close CURS_;
    END IF;
    
    logger.info ('P_F13_NN: End etap 3 for '||to_char(dat_,'dd.mm.yyyy'));

    --- позабалансовые символа сформированные процедурой P_F13_NN
    OPEN BaseL;
    LOOP
       FETCH BaseL INTO  kodp_, nbuc_, znap_;
       EXIT WHEN BaseL%NOTFOUND;

       BEGIN
          INSERT INTO TMP_NBU
               (kodf, datf, kodp, znap, nbuc)
          VALUES
               (kodf_, Dat_, kodp_, znap_, nbuc_);
       EXCEPTION WHEN OTHERS THEN
          update tmp_nbu set znap=to_char(to_number(znap)+to_number(znap_))
          where kodf=kodf_
            and datf=Dat_
            and kodp=kodp_;
       END;

    END LOOP;
    CLOSE BaseL;

    logger.info ('P_F13_NN: End for '||to_char(dat_,'dd.mm.yyyy'));
----------------------------------------
END P_F13_Nn;
/
show err;

PROMPT *** Create  grants  P_F13_NN ***
grant EXECUTE                                                                on P_F13_NN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F13_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
