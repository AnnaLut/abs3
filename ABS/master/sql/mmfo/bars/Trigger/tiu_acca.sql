

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCA.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCA ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCA 
AFTER INSERT OR UPDATE OF accc, blkd, blkk, dazs, isp, kv, lim, ostx, pos, nbs,
                          nls, nlsalt, nms, pap, grp, sec, seci, seco, tip, vid,
                          tobo, mdate, rnk, kf, daos, branch, ob22, send_sms
ON accounts
-- Reflects accounts updating into accounts_update table
-- VER @(#) tiu_acc.sql 4.8 12/12/2016

declare
   id_upd     int;
   l_bankdate date;
   g_bankdate date;

begin
  IF gl.acc_rec.acc IS NOT NULL THEN
    SELECT bars_sqnc.get_nextval('s_accounts_update', gl.acc_rec.kf)
    into   id_upd
    FROM   DUAL;

    g_bankdate := glb_bankdate;

    l_bankdate    := COALESCE(bars.gl.bd, glb_bankdate);

    INSERT
    INTO   accounts_update (acc      ,
                            nls      ,
                            nlsalt   ,
                            kv       ,
                            nbs      ,
                            nbs2     ,
                            daos     ,
                            isp      ,
                            nms      ,
                            pap      ,
                            grp      ,
                            sec      ,
                            seci     ,
                            seco     ,
                            vid      ,
                            tip      ,
                            dazs     ,
                            blkd     ,
                            blkk     ,
                            lim      ,
                            pos      ,
                            accc     ,
                            tobo     ,
                            mdate    ,
                            ostx     ,
                            rnk      ,
                            kf       ,
                            chgdate  ,
                            chgaction,
                            doneby   ,
                            idupd    ,
                            effectdate,
                            branch,
                            ob22,
                            globalbd,
                            send_sms
                          )
                    VALUES (gl.acc_rec.acc   ,
                            gl.acc_rec.nls   ,
                            gl.acc_rec.nlsalt,
                            gl.acc_rec.kv    ,
                            gl.acc_rec.nbs   ,
                            gl.acc_rec.nbs2  ,
                            gl.acc_rec.daos  ,
                            gl.acc_rec.isp   ,
                            gl.acc_rec.nms   ,
                            gl.acc_rec.pap   ,
                            gl.acc_rec.grp   ,
                            gl.acc_rec.sec   ,
                            gl.acc_rec.seci  ,
                            gl.acc_rec.seco  ,
                            gl.acc_rec.vid   ,
                            gl.acc_rec.tip   ,
                            gl.acc_rec.dazs  ,
                            gl.acc_rec.blkd  ,
                            gl.acc_rec.blkk  ,
                            gl.acc_rec.lim   ,
                            gl.acc_rec.pos   ,
                            gl.acc_rec.accc  ,
                            gl.acc_rec.tobo  ,
                            gl.acc_rec.mdate ,
                            gl.acc_rec.ostx  ,
                            gl.acc_rec.rnk   ,
                            gl.acc_rec.kf    ,
                            sysdate          ,
                            gl.acc_otm        ,
                            user_name         ,
                            id_upd            ,
                            l_bankdate        ,
                            gl.acc_rec.branch ,
                            gl.acc_rec.ob22   ,
                            g_bankdate        ,
                            gl.acc_rec.send_sms
                            );
   END IF;
END tiu_acca;
/
ALTER TRIGGER BARS.TIU_ACCA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCA.sql =========*** End *** ==
PROMPT ===================================================================================== 
