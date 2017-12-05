

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F84SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F84SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F84SB (Datf_ DATE ,
                                     kodf_    VARCHAR2 default '84') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования ручных файлов КБ (универсальная)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 10.11.2017 (04.11.2009) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
10.11.2017 - изменил некоторые блоки формирования 
04.11.2009 - для Сбербанка и кода файла 84 будет ручное формирование и 
             необходимо вытягивать из табл. TMP_IREP а не из TMP_NBU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
typ_     number;
acc_     Number;
kv_      Number;
nls_     Varchar2(15);
nlsk_    Varchar2(15);
nlsk1_   Varchar2(15);
mfo_     Varchar2(12);
nbuc1_   Varchar2(20);
nbuc_    Varchar2(20);
tk_      Varchar2(1);
kol_     Number;
rnk_     Number;
okpo_    Varchar2(14);
dat_z_   Date;
data_    Date;
Dat1_    Date;
Datz_    Date;
kodp_    Varchar2(35);
znap_    Varchar2(70);
userid_  Number;
ref_     number;
rez_     number;
branch_id_ Varchar2(15);
-----------------------------------------------------------------------------
BEGIN
   execute immediate 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
-------------------------------------------------------------------
   userid_ := user_id;
   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   BEGIN
      select max(datf) 
         into datz_
      from tmp_irep
      where kodf = '84' and datf < Datf_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      datz_ := Datf_;
   END;

   mfo_:=F_OURMFO();

   -- параметры формирования файла
--   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

--   nbuc_ := nbuc1_;

--  logger.info('P_F00: '||to_char(datf_)||', '||to_char(datz_)||', '||kodf_ );

 
insert into rnbu_trace 
(nls, kv, odate, kodp, znap, nbuc)  
select 1, 1, datz_, kodp, znap, nbuc 
from tmp_irep
where kodf = kodf_
  and datf = datz_;
---------------------------------------------------
DELETE FROM tmp_irep where kodf = kodf_ and datf = datf_;
---------------------------------------------------
INSERT INTO tmp_irep (kodf, kodp, datf, znap, nbuc)
   SELECT kodf_, kodp, Datf_, znap, nbuc
   FROM rnbu_trace;

----------------------------------------
END p_f84sb;
/
show err;

PROMPT *** Create  grants  P_F84SB ***
grant EXECUTE                                                                on P_F84SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F84SB         to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F84SB.sql =========*** End *** =
PROMPT ===================================================================================== 
