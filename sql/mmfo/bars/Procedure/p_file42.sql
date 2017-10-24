

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FILE42.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FILE42 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FILE42 (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура консолидации по типу "Спецобработка #91"
%  			  	для файла 42
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 21.12.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_   - звiтна дата
               sheme_ - код схеми формування
с 22.12.2005 добавлен код "05"
c 15.12.2006 для показателей имеющих код NNNN должна быть свозная нумерация
             коды NNNN должны только совпадать для одного и того же клиента
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
-- вступають в дiю змiни згiдно телеграми НБУ №24-622/212 вiд 30.11.2005
dat_Zm_	   DATE := TO_DATE('21122004','ddmmyyyy');

kodf_      varchar2(2) := '42';
kf1_       VARCHAR2(2) := '01';
dd_        Varchar2(2);
file_id_   Number;
nbuc_      Number;
Oste_      Number;
na1_       Number;
na1_1      Number;
na2_       Number;
na2_3      Number;
na3_       Number;
sum_k_     Number;
sum_sk_    Number;
prizn_     Number;
pr_01      NUmber:=0;
pr_03      Number:=0;
nn_        Varchar2(4);
kodp_      Varchar2(12);
znap_      Varchar2(70);
s01_       number:=0;
s02_       number:=0;
s03_       number:=0;
s04_       number:=0;
s05_       number:=0;
nbucGL_    number;
mfo_       varchar2(12);

-- Залишки
CURSOR SALDO IS
   SELECT file_id,
          substr(kodp,1,2),
   	  kodp,
	  substr(kodp,3,4),
	  nbuc,
          SUM(TO_NUMBER(nvl(znap,'0')))
   FROM v_banks_report
   WHERE datf=Dat_    AND
         kodf=kodf_   AND
         substr(kodp,1,2) in ('01','02','03','04','06')
   GROUP BY file_id, kodp, substr(kodp,3,4), nbuc
   ORDER BY 2, 6 DESC ;

CURSOR SALDO1 IS
   SELECT  kodp,
   	   sum(to_number(nvl(znap,'0')))
   FROM v_banks_report
   WHERE datf=Dat_    AND
         kodf=kodf_   AND
         kodp is not null AND
	 substr(kodp,1,2) not in ('01','02','03','04','05','06','00','99')
   GROUP BY kodp;

BEGIN
-------------------------------------------------------------------
DELETE FROM V_BANKS_REPORT91 where datf=Dat_ and kodf=kodf_;
-------------------------------------------------------------------
sum_k_:=Rkapital(Dat_);
IF dat_ >= dat_Zm_ THEN	-- з 21.12.2005
   -- статутний капiтал
   BEGIN
      SELECT SUM(DECODE(SUBSTR(kodp,1,1),'1',-1,1)*TO_NUMBER(znap))
      INTO sum_SK_
      FROM   v_banks_report
      WHERE  datf=Dat_ AND
             kodf=kf1_ AND
             SUBSTR(kodp,2,4) = '0500';
   EXCEPTION WHEN NO_DATA_FOUND THEN
      sum_SK_:=0 ;
   END ;

   IF NVL(sum_SK_, 0) = 0 THEN
      sum_sk_:= F_Get_Params ('NORM_SK', 0);
   END IF;
END IF;

mfo_:=f_ourmfo();

BEGIN
   SELECT to_number(trim(zzz)) INTO nbucGL_
   FROM KL_F00
   WHERE kodf=kodf_
     AND a017=sheme_;
EXCEPTION
          WHEN NO_DATA_FOUND THEN
   nbucGL_ := to_number(mfo_);
END;

na1_:=0 ;
na2_:=0 ;
na3_:=0 ;

OPEN SALDO;
LOOP
   FETCH SALDO INTO file_id_, dd_, kodp_, nn_, nbuc_, Oste_ ;
   EXIT WHEN SALDO%NOTFOUND;

   if substr(kodp_,1,2) = '02'  then
      if oste_ >=  round(sum_k_*0.1)  then
         s02_:=s02_+oste_;
      end if;
   elsif substr(kodp_,1,2) = '04' then
      s04_:=s04_+oste_;
   end if;

---- 01
   if substr(kodp_,1,2) = '01' then
      na1_:=na1_+1;

      if na1_= 1 then
         insert into V_BANKS_REPORT91  (nbuc, kodf, datf, kodp, znap)
         values
         (file_id_, kodf_, dat_, '01'||substr('0000'||to_char(na1_),-4)||nn_, to_char(oste_));
         if oste_ >= round(sum_k_*0.25) then
       	    pr_01 := 1;
         end if;
         BEGIN
            SELECT  sum(to_number(nvl(znap,'0'))) into s05_
            FROM v_banks_report
            WHERE datf=Dat_             AND
                  kodf=kodf_            AND
                  kodp is not null      AND
                  file_id=file_id_      AND
                  nbuc=nbuc_            AND
                  substr(kodp,1,2)='05' AND
                  substr(kodp,3,4)=nn_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            s05_:=0;
         END;
         if s05_<>0 then
            insert into V_BANKS_REPORT91  (nbuc, kodf, datf, kodp, znap)
            values
            (file_id_, kodf_, dat_, '05'||substr('0000'||to_char(na1_),-4), to_char(s05_));
         end if;
      else
         if oste_ >= round(sum_k_*0.25)  then
       	    insert into V_BANKS_REPORT91  (nbuc, kodf, datf, kodp, znap)
            values
            (file_id_, kodf_, dat_, '01'||substr('0000'||to_char(na1_),-4)||nn_,to_char(oste_));
            pr_01 := 1;

            BEGIN
               SELECT  sum(to_number(nvl(znap,'0'))) into s05_
               FROM v_banks_report
               WHERE datf=Dat_             AND
                     kodf=kodf_            AND
                     kodp is not null      AND
                     file_id=file_id_      AND
                     nbuc=nbuc_            AND
	             substr(kodp,1,2)='05' AND
                     substr(kodp,3,4)=nn_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               s05_:=0;
	    END;
	    if s05_<>0 then
               insert into V_BANKS_REPORT91  (nbuc, kodf, datf, kodp, znap)
               values
               (file_id_, kodf_, dat_, '05'||substr('0000'||to_char(na1_),-4), to_char(s05_));
            end if;
         end if;

         if pr_01=0 then
            na1_ := na1_-1;
         end if;

         if pr_01=1 and oste_ < round(sum_k_*0.25) then
            s01_ := oste_;
            pr_01 := 0;
            na1_1 := na1_;
         end if;

      end if;
   end if;

---- 03
   if substr(kodp_,1,2) = '03' then
      na1_:=na1_+1;
      na2_:=na2_+1;

      if na2_= 1 then
      	 insert into V_BANKS_REPORT91  (nbuc, kodf, datf, kodp, znap)
         values
         (file_id_, kodf_, dat_, '03'||substr('0000'||to_char(na1_),-4)||nn_,to_char(oste_));
       	 if ((Dat_<dat_Zm_ and oste_ >= round(sum_k_*0.05)) or
             (Dat_>=dat_Zm_ and oste_ >= round(sum_sk_*0.05))) then
       	    pr_03 := 1;
         end if;
      else
         if ((Dat_<dat_Zm_ and oste_ >= round(sum_k_*0.05)) or
             (Dat_>=dat_Zm_ and oste_ >= round(sum_sk_*0.05))) then
       	    insert into V_BANKS_REPORT91  (nbuc, kodf, datf, kodp, znap)
            values
            (file_id_, kodf_, dat_, '03'||substr('0000'||to_char(na1_),-4)||nn_,to_char(oste_));
	      pr_03 := 1;
	 end if;

	 if pr_03=0 then
            na1_ := na1_-1;
         end if;

	 if pr_03=1 and ((Dat_<dat_Zm_ and oste_ < round(sum_k_*0.05)) or
             (Dat_>=dat_Zm_ and oste_ < round(sum_sk_*0.05))) then
	    s03_ := oste_;
	    pr_03 := 0;
--            na2_3 := na2_;
            na2_3 := na1_;
	 end if;
      end if;
   end if;

---- 06
   if substr(kodp_,1,2) = '06' then
      na3_:=na3_+1;

      BEGIN
         SELECT  to_number(substr(kodp,3,4)) into na1_
         FROM v_banks_report91
         WHERE datf=Dat_             AND
               kodf=kodf_            AND
               kodp is not null      AND
               nbuc=file_id_         AND
               substr(kodp,1,2) in ('01','03') AND
               substr(kodp,7,4)=nn_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         na1_ := na1_+1;
      END;

      if na3_= 1 then
         insert into V_BANKS_REPORT91  (nbuc, kodf, datf, kodp, znap)
         values
         (file_id_, kodf_, dat_, '06'||substr('0000'||to_char(na1_),-4),to_char(oste_));
      else
         if oste_ >=  round(sum_k_*0.15)  then
       	    insert into V_BANKS_REPORT91  (nbuc, kodf, datf, kodp, znap)
            values
            (file_id_, kodf_, dat_, '06'||substr('0000'||to_char(na1_),-4),to_char(oste_));
	 end if;
      end if;
   end if;

END LOOP;
CLOSE SALDO;

------------------------------------------------------------
if s01_<>0 then
   insert into V_BANKS_REPORT91  (nbuc, kodf , datf, kodp, znap) values
                                 (nbucGL_, kodf_, dat_, '01'||substr('0000'||to_char(na1_1),-4), to_char(s01_));
end if;

if s02_<>0 then
   insert into V_BANKS_REPORT91  (nbuc, kodf , datf, kodp, znap) values
                                 (nbucGL_, kodf_, dat_, '020000', to_char(s02_));
end if;

if s03_<>0 then
   insert into V_BANKS_REPORT91  (nbuc, kodf , datf, kodp, znap) values
                                 (nbucGL_, kodf_, dat_, '03'||substr('0000'||to_char(na2_3),-4), to_char(s03_));
end if;

if s04_<>0 then
   insert into V_BANKS_REPORT91  (nbuc, kodf , datf, kodp, znap) values
                                 (nbucGL_, kodf_, dat_, '040000', to_char(s04_));
end if;
------------------------------------------------------------
OPEN SALDO1;
LOOP
   FETCH SALDO1 INTO kodp_, Oste_;
   EXIT WHEN SALDO1%NOTFOUND;

   IF Oste_<>0 THEN
      IF substr(kodp_,3,4)<>'0000' THEN
         BEGIN
            SELECT  to_number(substr(kodp,3,4)) into na1_
            FROM v_banks_report91
            WHERE datf=Dat_             AND
                  kodf=kodf_            AND
                  kodp is not null      AND
                  nbuc=file_id_         AND
                  substr(kodp,1,2) in ('01','03','06') AND
                  substr(kodp,7,4)=substr(kodp_,3,4);
         EXCEPTION WHEN NO_DATA_FOUND THEN
            na1_ := na1_+1;
         END;
         kodp_ := substr(kodp_,1,2)||substr('0000'||to_char(na1_),-4);
      END IF;

      INSERT INTO V_BANKS_REPORT91 (NBUC, KODF, DATF, KODP, ZNAP)
      values
      (nbucGL_, kodf_, dat_, kodp_, to_char(Oste_));

   END IF;
END LOOP;
CLOSE SALDO1;
----------------------------------------
update v_banks_report91 set nbuc=nbucGL_,kodp=substr(kodp,1,6);

END p_file42;
/
show err;

PROMPT *** Create  grants  P_FILE42 ***
grant EXECUTE                                                                on P_FILE42        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FILE42.sql =========*** End *** 
PROMPT ===================================================================================== 
