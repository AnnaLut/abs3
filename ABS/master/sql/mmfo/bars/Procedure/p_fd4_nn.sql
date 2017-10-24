

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FD4_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FD4_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FD4_NN (dat_ DATE,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирование файла #40 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 04/04/2017 (23/03/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 23.03.2016  на 01.04.2016 файл будет формироваться как месячный
% 09.09.2014  код 31 формируем только при пустом ddd_
% 01.09.2014  новая структура показателя (добавлен 1 символ 1-сума,9-примітка)
% 18.07.2012  внесены комментарии ранее выполненных изменений
% 23.05.2012  выполнены изменения по замечаниях банка Надра
% 02.08.2006  исключаем проводки типа Дт 1600 --> 6110, Дт 1608 --> Кт 1600
% 03.07.2006  добавлен код "31"-списано за iншими операцiями, що не були
%             вiдображенi за кодами 21-23
% 03.03.2006  добавление в структуру показателя кода валюты "DDHHHHHHHHHHVVV"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    Varchar2(2):='D4';
nbs_     varchar2(4);
nls_     varchar2(15);
nlsd_    varchar2(15);
nlsk_    varchar2(15);
ref_     number;
flag_    number;
typ_     number;
nbuc1_   Varchar2(12);
nbuc_    Varchar2(12);
dat1_    date;
data_    date;
kv_      SMALLINT;
sn_      DECIMAL(24);
dos_     DECIMAL(24);
kos_     DECIMAL(24);
sump_    DECIMAL(24);
kb_      varchar2(11);
kodp_    varchar2(35);
znap_    varchar2(70);
ddd_     varchar2(3);
rnk_     Number;
stmt_    Number;
userid_  Number;

--- Обороты ( списания и зачисления )
CURSOR OPL_DOK IS
   SELECT a.nls, a.kv, c.ref, c.fdat, cb.alt_bic, 
          NVL(substr(k.value,1,2),'00'), c.s, c.stmt, b.rnk
   FROM accounts a, opldok c, operw k,
        custbank cb, customer b
   WHERE a.nbs in (select r020 from kl_f3_29 where kf=kodf_) AND
         a.acc=c.acc                    AND
         c.fdat between Dat1_ AND Dat_  AND
         a.rnk=cb.rnk                   AND
         cb.rnk=b.rnk                   AND
         MOD(b.codcagent,2)=0           AND
         c.sos=5                        AND
         c.ref=k.ref(+)                 AND
         k.tag(+)='D#40' ;

CURSOR BaseL IS
    SELECT kodp, SUM(TO_NUMBER(znap))
    FROM rnbu_trace
    GROUP BY kodp;

BEGIN
   -------------------------------------------------------------------
   userid_ := user_id;
   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
   -------------------------------------------------------------------
    -- параметры формирования файла
   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

   nbuc_ := nbuc1_;

   if nbuc_ is null then
      nbuc_ := '0';
   end if;
   
   if Dat_ < to_date('21032016','ddmmyyyy')
   then
      Dat1_ := Dat_;
   else
      Dat1_ := TRUNC(Dat_, 'MM');
   end if;

    --- списание и зачисление (коды 11-31)
   OPEN OPL_DOK;
   LOOP
       FETCH OPL_DOK INTO nls_, kv_, ref_, data_, kb_, ddd_, sn_, stmt_, rnk_ ;
       EXIT WHEN OPL_DOK%NOTFOUND;

       flag_:=0;

       SELECT count(*) INTO flag_ 
       FROM provodki 
       WHERE ref=ref_ 
         and ((s*100=sn_ and 
              ((substr(nlsd,1,4)='1608' and substr(nlsk,1,4)='1600') OR 
              (substr(nlsd,1,4)='1600' and substr(nlsk,1,4)='6110'))) OR 
              (s*100=GL.P_ICURVAL(kv_, sn_, data_) and 
               substr(nlsd,1,4)='3801' and substr(nlsk,1,4)='6110')) ;

       IF flag_=0 and SN_ >0 THEN
          BEGIN
             select nlsd, nlsk 
                into nlsd_, nlsk_
             from provodki 
             where ref = ref_
               and stmt = stmt_;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             null;
          END;

          if nlsd_ like '3739%' and nlsk_ like nls_ || '%' and ddd_ = '00' then
             ddd_ := '13';
          end if;

          if nlsd_ like nls_ || '%' and nlsk_ like '3739%' and ddd_ = '00' then
             ddd_ := '31';
          end if;

          IF kb_ IS NULL OR kb_=' ' THEN
             kb_:='0000000000' ;
          ELSE
             kb_:=SUBSTR(TO_CHAR(10000000000+TO_NUMBER(kb_)),2,10) ;
          END IF;

          znap_:= TO_CHAR(ABS(sn_)) ;

          if Dat_ >= to_date('01092014','ddmmyyyy') 
          then
             kodp_:= '1' || SUBSTR(ddd_,1,2) || kb_ ||lpad(kv_,3,'0');
             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, rnk) VALUES
                                    (nls_, kv_, data_, kodp_,znap_, ref_, rnk_);

             kodp_:= '9' || SUBSTR(ddd_,1,2) || kb_ ||lpad(kv_,3,'0');
             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, rnk) VALUES
                                    (nls_, kv_, data_, kodp_,'0', ref_, rnk_);

          else
             kodp_:= SUBSTR(ddd_,1,2) || kb_ ||lpad(kv_,3,'0');
             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, rnk) VALUES
                                    (nls_, kv_, data_, kodp_,znap_, ref_, rnk_);

          end if;

       END IF;
   END LOOP;
   CLOSE OPL_DOK;
    ---------------------------------------------------
    DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
    ---------------------------------------------------
    OPEN BaseL;
    LOOP
       FETCH BaseL INTO  kodp_, znap_;
       EXIT WHEN BaseL%NOTFOUND;

       if dat_ >= to_date('01092014','ddmmyyyy') and kodp_ like '9%'
       then
          znap_ := ' ';
       end if;

       INSERT INTO tmp_nbu
           (kodf, datf, kodp, znap)
       VALUES
           (kodf_, Dat_, kodp_, znap_);
    END LOOP;
    CLOSE BaseL;
---------------------------------------------------
END p_fd4_nn;
/
show err;

PROMPT *** Create  grants  P_FD4_NN ***
grant EXECUTE                                                                on P_FD4_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FD4_NN        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FD4_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
