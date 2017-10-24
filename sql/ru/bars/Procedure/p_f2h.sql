

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2H.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F2H ***

  CREATE OR REPLACE PROCEDURE BARS.P_F2H (dat_ IN DATE)
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ѕроцедура формировани¤ файла
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :    18/01/2016 (04/01/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*/
IS
    kodf_    varchar2(2):='2H';
    sheme_   varchar2(1):='C';
    typ_     number;

    dat1_    date;
    mfo_     Varchar2(12);
    nbuc1_   Varchar2(12);
    nbuc_    Varchar2(12);
BEGIN
   -------------------------------------------------------------------
   logger.info ('P_P2H: Begin for '||to_char(dat_,'dd.mm.yyyy'));

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   mfo_ := F_OURMFO();
   Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього мiс¤ц¤

   -- параметры формировани¤ файла
   p_proc_set(kodf_,sheme_, nbuc1_,typ_);

   nbuc_ := nbuc1_;

   delete from tmp_nbu where datf = dat_ and kodf = kodf_;
   INSERT INTO tmp_nbu(datf, kodf, kodp, znap, nbuc)
   select dat_, kodf_, kodp, znap, nbuc
   from (select '1'||CODE_QUEST kodp,
              CODE_ANSW znap, nbuc_ nbuc
         from  otcn_2h_anketa
         where datf = dat_
              union
         select '2'||CODE_QUEST kodp,
              CODE_ANSW znap, nbuc_ nbuc
         from  otcn_2h_anketa
         where datf = dat_ and
             CODE_ANSW not in ('000','091')
              union
         select '2'||CODE_QUEST kodp,
              substr(trim(comm),1,70) znap, nbuc_ nbuc
         from  otcn_2h_anketa
         where datf = dat_ and
             CODE_ANSW in ('000','091') and
             trim(comm) is not null)
   order by 1;

   logger.info ('P_P2H: End for '||to_char(dat_,'dd.mm.yyyy'));
END;
/
show err;

PROMPT *** Create  grants  P_F2H ***
grant EXECUTE                                                                on P_F2H           to RPBN002;
grant EXECUTE                                                                on P_F2H           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2H.sql =========*** End *** ===
PROMPT ===================================================================================== 
