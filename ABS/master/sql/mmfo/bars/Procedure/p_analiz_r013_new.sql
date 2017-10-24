

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ANALIZ_R013_NEW.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ANALIZ_R013_NEW ***

  CREATE OR REPLACE PROCEDURE BARS.P_ANALIZ_R013_NEW (
   ------------------------------------------------------------------------------------
   -- VERSION: 09/12/2015 (11/11/2015)
   ------------------------------------------------------------------------------------
   mfo_       IN       NUMBER,
   mfou_      IN       NUMBER,
   dat_       IN       DATE,
   acc_       IN       NUMBER,
   tip_       in       VARCHAR2,
   nbs_       IN       VARCHAR2,
   kv_        IN       SMALLINT,
   r013_      IN       VARCHAR2,
   se_        IN       DECIMAL,
   nd_        IN       NUMBER,
   freqp_     in       NUMBER,
   ----------------------------
   -- ДО 30 ДНЕЙ
   o_r013_1   OUT      VARCHAR2,
   o_se_1     OUT      DECIMAL,
   o_comm_1   OUT      rnbu_trace.comm%TYPE,
   -- ПОСЛЕ 30 ДНЕЙ
   o_r013_2   OUT      VARCHAR2,
   o_se_2     OUT      DECIMAL,
   o_comm_2   OUT      rnbu_trace.comm%TYPE
)
IS

BEGIN
   -- для місячних файлів та розрахунку резервів
   P_ANALIZ_R013_CALC (2, MFO_, MFOU_, DAT_, ACC_, TIP_, NBS_, KV_, R013_, SE_,
            ND_, FREQP_, O_R013_1, O_SE_1, O_COMM_1, O_R013_2, O_SE_2, O_COMM_2 );
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ANALIZ_R013_NEW.sql =========***
PROMPT ===================================================================================== 
