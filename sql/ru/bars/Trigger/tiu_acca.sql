

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCA.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCA ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCA 
AFTER INSERT OR UPDATE OF accc, blkd, blkk, dazs, isp, kv, lim, ostx, pos, nbs,
                          nls, nlsalt, nms, pap, grp, sec, seci, seco, tip, vid,
                          tobo, mdate, rnk, daos, branch, ob22
  , send_sms
ON accounts
-- Reflects accounts updating into accounts_update table
-- VER @(#) tiu_acc.sql 4.4 30/04/2015

declare
   id_upd     int;
   l_bankdate date;
   g_bankdate date;

begin
  IF pul.acc_rec.acc IS NOT NULL THEN
    SELECT S_Accounts_Update.NEXTVAL
    into   id_upd
    FROM   DUAL;

    g_bankdate := glb_bankdate;

    l_bankdate := bars.gl.bd;
    if ( l_bankdate is Null ) then
      l_bankdate := glb_bankdate;
    end if;

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
                            chgdate  ,
                            chgaction,
                            doneby   ,
                            idupd    ,
                            effectdate,
                            branch,
                            ob22,
                            globalbd
  , send_sms
                          )
                    VALUES (pul.acc_rec.acc   ,
                            pul.acc_rec.nls   ,
                            pul.acc_rec.nlsalt,
                            pul.acc_rec.kv    ,
                            pul.acc_rec.nbs   ,
                            pul.acc_rec.nbs2  ,
                            pul.acc_rec.daos  ,
                            pul.acc_rec.isp   ,
                            pul.acc_rec.nms   ,
                            pul.acc_rec.pap   ,
                            pul.acc_rec.grp   ,
                            pul.acc_rec.sec   ,
                            pul.acc_rec.seci  ,
                            pul.acc_rec.seco  ,
                            pul.acc_rec.vid   ,
                            pul.acc_rec.tip   ,
                            pul.acc_rec.dazs  ,
                            pul.acc_rec.blkd  ,
                            pul.acc_rec.blkk  ,
                            pul.acc_rec.lim   ,
                            pul.acc_rec.pos   ,
                            pul.acc_rec.accc  ,
                            pul.acc_rec.tobo  ,
                            pul.acc_rec.mdate ,
                            pul.acc_rec.ostx  ,
                            pul.acc_rec.rnk   ,
                            sysdate           ,
--                          to_date(To_char(gl.bdate,'dd/mm/yyyy')||' '||
--                                  To_char(sysdate,'hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
                            pul.acc_otm       ,
                            user_name         ,
                            id_upd            ,
                            l_bankdate        ,
                            pul.acc_rec.branch,
                            pul.acc_rec.ob22,
                            g_bankdate
  , pul.acc_rec.send_sms
                            );
   END IF;
END tiu_acca;
/
ALTER TRIGGER BARS.TIU_ACCA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCA.sql =========*** End *** ==
PROMPT ===================================================================================== 
