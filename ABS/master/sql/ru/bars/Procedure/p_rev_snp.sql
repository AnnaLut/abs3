

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REV_SNP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REV_SNP ***

  CREATE OR REPLACE PROCEDURE BARS.P_REV_SNP (p_dat DATE DEFAULT null) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура вирівнювання коригуючих (переоцінка коригуючих)
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :    17/01/2011 (11,01,2012)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  DAT_  date ;
  caldt_id_     number;
  ------------------------------
  NLS_9900  accounts.NLS%type  ; --\  ВЕШАЛКА   для 9000-9599
  NLS_9910  accounts.NLS%type  ; --/  ВЕШАЛКА   для 9600-9999
  NLS_3800  accounts.NLS%type  ; --   ВЕШАЛКА   для 1001-7999
  NLS_3801  accounts.NLS%type  ; --   контр.ВЕШ.для 1001-7999
  n980      accounts.KV%type   ;
  ost_     NUMBER; --  исх.остат в номинале
  IXQ_      NUMBER; -- Исх. остат в эквивале
  dlta_     NUMBER; -- дельта для переоц сч.

  acc_3800 accounts.acc%type ;
  acc_3801 accounts.acc%type ;
  acc_6204 accounts.acc%type ;
BEGIN
  DAT_  := trunc(p_DAT, 'mm');
  n980  := gl.baseval;
  caldt_id_ := f_snap_dati(dat_, 2);

  dbms_output.put_line(to_char(p_dat)|| ' ' ||caldt_id_|| ' ' || n980);
  dbms_output.put_line(NLS_3800|| ' ' ||NLS_9900|| ' ' ||NLS_9910);

  -------------------------------
  NLS_9900  := vkrzn(substr(gl.AMFO,1,5),'99000999999999'); --- ???. 9000-9599
  NLS_9910  := vkrzn(substr(gl.AMFO,1,5),'99100999999999'); --- ???. 9600-9999
  NLS_3800  := vkrzn(substr(gl.AMFO,1,5),'38000000000000'); --- ???. 1000-7999
  NLS_3801  := vkrzn(substr(gl.AMFO,1,5),'38010000000000'); --|
  -------------------------------

  -- выгружаем во врем табл 1(TMP_REV1) все счета, кот будем переоценивать
  EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_REV1 ';

  insert into TMP_REV1 ( NBS,KV,ACC)
     select nbs,kv,acc from accounts
     where nbs is  not  null  and nbs  NOT like '8%'
        and kv<>n980          and nls  not in ( NLS_3800,NLS_9900,NLS_9910)
        AND pos = 1           and (dazs is null or dazs > p_dat -20 );

  --цикл-1 d по датам
    FOR c IN (SELECT 1 PR, s.caldt_id, s.acc, a.NBS, a.KV, b.branch,
                    s.ost, s.ostq,
                    s.dos, s.dosq,
                    s.kos, s.kosq,
                    s.CRDOS, s.CRDOSq,
                    s.CRKOS, s.CRKOSq
                 FROM TMP_REV1 a, ACCM_AGG_MONBALS s, accounts b
                WHERE a.acc = s.acc
                  and a.acc = b.acc
                  and s.caldt_id = caldt_id_
                  and s.CRDOSq + s.CRKOSq <> 0
                  and s.ostq - s.CRDOSq + s.CRKOSq <> gl.p_icurval(a.kv, s.ost - s.CRDOS + s.CRKOS, p_dat)
                  and a.nbs not like '38%'
                  and s.ost - s.CRDOS + s.CRKOS = 0
                  and s.ostq - s.CRDOSq + s.CRKOSq <> 0
                  /* and not exists (select 1
                                  from ACCM_AGG_MONBALS z, accounts p
                                  where z.caldt_id = caldt_id_ and
                                        z.acc = p.acc and
                                        z.acc <> a.acc and
                                        p.nbs = a.nbs and
                                        p.kv = a.kv and
                                        z.ostq - z.CRDOSq + z.CRKOSq <> 0 and
                                        sign(z.ostq - z.CRDOSq + z.CRKOSq) = sign(s.ostq - s.CRDOSq + s.CRKOSq)
                                  )*/
               )
     LOOP
        OST_ :=  c.ost - c.crdos + c.crkos;

        -------  Исх ост в экв
        IXQ_  := gl.p_icurval(c.kv, ost_, p_dat);

        -------  дельта для переоц сч
        dlta_ := (c.ostq - c.CRDOSq + c.CRKOSq) - IXQ_;

        if dlta_<> 0 then
            if dlta_< 0 then
                SELECT v.acc3800, v.acc3801,v.acc_RRR
                into acc_3800, acc_3801, acc_6204
                FROM accounts a, vp_list v
                WHERE a.acc=v.acc3800
                  AND a.kv=c.kv
                  and branch=substr(c.branch, 1, 15)
                  and exists (select 1
                              from ACCM_AGG_MONBALS
                              where caldt_id=caldt_id_ and
                                    acc = v.acc3800 and
                                    CRDOSq + CRKOSq<> 0)
                  and rownum = 1;
            else
                SELECT v.acc3800, v.acc3801,v.acc_RRR
                into acc_3800, acc_3801, acc_6204
                FROM accounts a, vp_list v
                WHERE a.acc=v.acc3800
                  AND a.kv=c.kv
                  and branch=substr(c.branch, 1, 15)
                  and exists (select 1
                              from ACCM_AGG_MONBALS
                              where caldt_id=caldt_id_ and
                                    acc = v.acc3800 and
                                    CRDOSq + CRKOSq<> 0)
                  and rownum = 1;
            end if;

            update ACCM_AGG_MONBALS
            set CRDOSq = CRDOSq + (case when  dlta_< 0 AND CRDOSq>0 then dlta_ else 0 end) + (case when  dlta_> 0 AND CRKOSq=0 then dlta_ else 0 end),
                CRKOSq = CRKOSq + (case when  dlta_> 0 AND CRKOSq>0 then -dlta_ else 0 end) + (case when  dlta_< 0 AND CRDOSq=0 then -dlta_ else 0 end)
            where acc = c.acc and
                  caldt_id = caldt_id_;

            update ACCM_AGG_MONBALS
            set CRDOS = CRDOS + (case when  dlta_< 0 then dlta_ else 0 end),
                 CRKOS = CRKOS + (case when  dlta_> 0 then -dlta_ else 0 end),
                 CRDOSq = CRDOSq + (case when  dlta_< 0 then dlta_ else 0 end),
                 CRKOSq = CRKOSq + (case when  dlta_> 0 then -dlta_ else 0 end)
            where acc = acc_3801 and
                  caldt_id = caldt_id_;

            update ACCM_AGG_MONBALS
            set CRDOSq = CRDOSq + (case when  dlta_> 0 then -dlta_ else 0 end),
                CRKOSq = CRKOSq + (case when  dlta_< 0 then dlta_ else 0 end)
            where acc = acc_3800 and
                  caldt_id = caldt_id_;

            update ACCM_AGG_MONBALS
            set CRDOS = CRDOS + (case when  dlta_> 0 then -dlta_ else 0 end),
                CRKOS = CRKOS + (case when  dlta_< 0 then dlta_ else 0 end),
                CRDOSq = CRDOSq + (case when  dlta_> 0 then -dlta_ else 0 end),
                CRKOSq = CRKOSq + (case when  dlta_< 0 then dlta_ else 0 end)
            where acc = acc_6204 and
                  caldt_id = caldt_id_;

            commit;

            dbms_output.put_line(c.acc||' '||c.NBS||' '||c.KV||' '||to_char(dlta_));
            dbms_output.put_line(acc_3800||' '||acc_3801||' '||acc_6204);
            dbms_output.put_line('---------------------------');
         end if;
     END LOOP;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REV_SNP.sql =========*** End ***
PROMPT ===================================================================================== 
