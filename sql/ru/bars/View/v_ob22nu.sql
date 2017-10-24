CREATE OR REPLACE FORCE VIEW BARS.V_OB22NU
(ACC, NLS, NMS, NBS, P080, 
 OB22, ACCN, NLSN, NMSN, NBSN, 
 NP080, NOB22, PRIZN, NMS8, AP, 
 VIDF, APF)
AS 
SELECT a.acc, a.nls, a.nms, a.nbs, s.p080, s.ob22, n.acc accn, n.nls nlsn,
          n.nms nmsn, n.nbs nbsn, n.p080 np080, n.ob22 nob22, n.prizn, n.nms8 ,n.ap,
          decode(a.vid,89,1,0) vidf, n.apf
     FROM accounts a,
          specparam_int s,
          (SELECT a.acc, a.nls, a.nms, a.nbs, s.p080, s.ob22, s.r020_fa,
                  p.prizn_vidp prizn, p.nms8,p.ap, p.apf
             FROM accounts a,
                  specparam_int s,
                  (SELECT DISTINCT SUBSTR (a.txt, 1, 35) nms8,
                                    a.p080,
                                    a.r020_fa,
                                    a.r020,
                                    a.prizn_vidp,
                                    a.ob22,
									a.ap,
                                    decode(b.r020_fa, null,3,a.ap) as apf 
                     FROM sb_p0853 a, (select r020_fa, ob22
                                          from sb_p0853 
                                         WHERE r020_fa <> '0000'
                                           AND (d_close IS NULL OR d_close > gl.bd)
                                           AND d_open <= gl.bd
                                           group by r020_fa, ob22
                                           having count(1) > 1) b
                    WHERE     a.r020_fa <> '0000'
                          AND (a.d_close IS NULL OR a.d_close > gl.bd)
                          AND a.d_open <= gl.bd
                          and a.r020_fa= b.r020_fa(+)
                          and a.ob22 = b.ob22(+)) p
            WHERE a.acc = s.acc
              AND a.daos<=gl.bd
              AND (a.dazs is null or a.dazs>gl.bd)
              AND a.kv = 980
              AND SUBSTR (a.nls, 1, 1) = '8'
              AND a.nbs = p.r020
              AND s.ob22 = p.ob22
              AND s.r020_fa = p.r020_fa
              AND s.p080 = p.p080
              AND a.vid<>89) n
    WHERE a.acc = s.acc AND a.nbs = n.r020_fa AND s.ob22 = n.ob22 AND a.vid<>89
/

CREATE OR REPLACE TRIGGER BARS.tu_v_ob22nu
instead of update ON BARS.V_OB22NU for each row
declare
  l_msg    varchar2(4000):=null;
begin
      if :old.vidf<>1 and :new.vidf=1  and :old.acc=:new.acc then
          update   accounts
             set   vid = 89
           where   acc =:new.acc;
          l_msg:='Замiна по рахунку '||:old.nls||' в accounts.vid даних  з 0 на 89(ВИКЛ в ПО)';
      end if;
      if :old.ob22<>:new.ob22 and :old.acc=:new.acc then
      update   specparam_int
          set ob22=:new.ob22
        where   acc=:new.acc;
      l_msg:='Замiна символа ОБ22 по рахунку '||:old.nls||
              ' з '||:old.ob22||' на '||:new.ob22;
      end if;
      if l_msg is not null then
         bars_audit.info(l_msg);
      end if;
end;
/


GRANT SELECT ON  BARS.V_OB22NU TO CUST001
/

GRANT SELECT, UPDATE ON  BARS.V_OB22NU TO NALOG
/

GRANT SELECT ON  BARS.V_OB22NU TO RPBN001
/

GRANT SELECT ON  BARS.V_OB22NU TO START1
/

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON  BARS.V_OB22NU TO WR_ALL_RIGHTS
/
