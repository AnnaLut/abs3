

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F00.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F00 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F00 (Datf_ DATE ,
                                   Datz_ DATE ,
                                   kodf_    VARCHAR2) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования ручных файлов КБ (универсальная)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 27.05.2008
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
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
   SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
   DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------

   mfo_:=F_OURMFO();

   -- параметры формирования файла
--   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

--   nbuc_ := nbuc1_;

--  logger.info('P_F00: '||to_char(datf_)||', '||to_char(datz_)||', '||kodf_ );

insert into rnbu_trace
(nls, kv, odate, kodp, znap, nbuc)
select 1, 1, datz_, kodp, znap, nbuc
from tmp_nbu
where kodf=kodf_
  and datf=datz_;

---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= datf_;
---------------------------------------------------
INSERT INTO tmp_nbu (kodp, datf, kodf, znap, nbuc)
   SELECT kodp, Datf_, kodf_, znap, nbuc
   FROM rnbu_trace
   WHERE userid=userid_;

--exception
--   when others then
--       raise_application_error(-20000, 'Error in p_fd0_nn: '||sqlerrm);
----------------------------------------
END p_f00;
 
/
show err;

PROMPT *** Create  grants  P_F00 ***
grant EXECUTE                                                                on P_F00           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F00           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F00.sql =========*** End *** ===
PROMPT ===================================================================================== 
