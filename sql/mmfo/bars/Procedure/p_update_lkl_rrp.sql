

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_UPDATE_LKL_RRP.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_UPDATE_LKL_RRP ***

  CREATE OR REPLACE PROCEDURE BARS.P_UPDATE_LKL_RRP (P_CLMFO  varchar2,
                                              P_CLKV   number,
                                              P_CLLTK  number,
                                              P_CLLNO  number) is
L_UID number;
BEGIN

  UPDATE lkl_rrp SET lim = P_CLLTK,  lno=P_CLLNO
  WHERE mfo=P_CLMFO AND kv=P_CLKV;

    begin
    FOR c IN
      (SELECT a.acc,l.mfo,l.lim,l.lno
         FROM lkl_rrp l, bank_acc b, accounts a
        WHERE l.mfo=b.mfo AND a.kv=l.kv AND a.acc=b.acc
          AND a.tip='L00' AND a.lim<>-l.lim
        ORDER BY l.mfo,l.kv)
     LOOP
       UPDATE accounts SET lim=-c.lim WHERE acc=c.acc;
       INSERT INTO lkl_rrp_update (mfo,dat,lim,lno,userid,dat_sys)
       VALUES (c.mfo, gl.bDATE, c.lim, c.lno, USER_ID, SYSDATE);
    END LOOP;
    end;
END p_update_lkl_rrp;
/
show err;

PROMPT *** Create  grants  P_UPDATE_LKL_RRP ***
grant EXECUTE                                                                on P_UPDATE_LKL_RRP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_UPDATE_LKL_RRP.sql =========*** 
PROMPT ===================================================================================== 
