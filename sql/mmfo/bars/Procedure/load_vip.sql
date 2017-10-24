

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/LOAD_VIP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure LOAD_VIP ***

  CREATE OR REPLACE PROCEDURE BARS.LOAD_VIP (P_MFO      IN varchar2,
                                     P_RNK      IN varchar2,
                                     P_VIP      IN varchar2,
                                     P_KVIP     IN varchar2,
                                     P_DATBEG   IN date,
                                     P_DATEND   IN date,
                                     P_RETURN   OUT varchar2,
                                     p_COMMENTS IN varchar2 default null) is
BEGIN

  logger.trace('Start: load_vip');
  --
 load_vip_web(P_MFO, P_RNK, P_VIP, P_KVIP, P_DATBEG, P_DATEND, P_RETURN,  p_COMMENTS );

  logger.trace('Finish: load_vip');
END load_vip;
/
show err;

PROMPT *** Create  grants  LOAD_VIP ***
grant EXECUTE                                                                on LOAD_VIP        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on LOAD_VIP        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/LOAD_VIP.sql =========*** End *** 
PROMPT ===================================================================================== 
