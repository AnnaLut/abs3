

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_2400.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_2400 ***

  CREATE OR REPLACE PROCEDURE BARS.P_2400 (Dat01_ DATE, NAL_ varchar2 ) IS
--  Процедура заполнения счетов резервирования 2400, 3590 ...

/* Версия 2.0 14-06-2017  23-05-2016

 2) 14-06-2017  -   Update через ROWID
 1) 23-05-2016 LUDA Счета резерва по странам риска

*/


TYPE CurTyp IS REF CURSOR;
c0 CurTyp;

begin
DECLARE
   TYPE r0Typ IS RECORD (
        RI         VARCHAR2(1000),
        country    customer.country%type,
        ID         nbu23_rez.ID%TYPE,
        NBS_REZ    srezerv_ob22.NBS_REZ%TYPE,
        OB22_REZ   srezerv_ob22.OB22_REZ%TYPE,
        NBS_7f     srezerv_ob22.NBS_7f%TYPE,
        OB22_7f    srezerv_ob22.OB22_7f%TYPE,
        NBS_7r     srezerv_ob22.NBS_7r%TYPE,
        OB22_7r    srezerv_ob22.OB22_7r%TYPE,
        kv         accounts.kv%TYPE,
        rz         nbu23_rez.rz%TYPE,
        branch     accounts.branch%TYPE,
        sz         number,
        szn        number,
        sz_30      number,
        s080       specparam.s080%TYPE,
        pr         srezerv_ob22.pr%TYPE,
        r_s080     specparam.s080%TYPE,
        r013       specparam.r013%TYPE,
        nd         nbu23_rez.nd%TYPE,
        cc_id      nbu23_rez.cc_id%TYPE,
        nd_cp      nbu23_rez.nd_cp%TYPE,
        r_acc      VARCHAR2(1000),
        r_nls      VARCHAR2(1000)
);
     k r0Typ;

begin

      if nal_ in ('0','1','2','5','B','C','D') THEN

      OPEN c0 FOR
         select t.ri, t.country, t.id   , t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz   , t.branch,
                t.sz, t.szn    , t.sz_30, t.s080   , t.pr      , t.r_s080, t.r013   , t.nd    , t.cc_id  , t.nd_cp,
                substr(ConcatStr(ar.acc),1,999) r_acc, substr(ConcatStr(ar.nls),1,999) r_nls
         from  (select  r.rowid RI, c.country, r.id  , o.NBS_REZ     , o.OB22_REZ, o.NBS_7f, o.OB22_7f , o.NBS_7r  ,
                        o.OB22_7r , o.pr     , o.r013, nvl(r.rz,1) rz, r.KV      , null nd , null cc_id, null nd_cp,
                        rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
                        nvl(r.rez*100,0) sz,nvl(r.rezn*100,0) szn,nvl(r.rez_30*100,0) sz_30, decode(r.kat,1,1,9,9,2) s080,to_char(r.kat) r_s080
                from nbu23_rez r
                join customer     c on (r.rnk = c.rnk)
                join srezerv_ob22 o on (r.nbs = o.nbs and o.nal=nal_  AND
                                        nvl(r.ob22,0) = decode(o.ob22,'0', nvl(r.ob22,0),o.ob22) and
                                        decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                        r.custtype = decode(o.custtype,'0',r.custtype,o.custtype) and r.kv = decode(o.kv,'0',r.kv,o.kv) )
         where fdat = dat01_ and substr(r.id,1,4) <> 'CACP' and
               decode(nal_,'0',-sign(r.rez),'2',-sign(r.rez),sign(r.rez)) = 1 and
               r.s250=decode(nal_,'8','8','A','8','B','8','C','8','D','8',decode(r.s250,'8','Z',r.s250)) and
               nvl(decode(nal_,'A', rezn  , '2',rez_30  , '5', rez_30, 'C', rez_30, '6',rez_30,
                               'D', REz_30, '8', r.rez , decode(rez_30,0,r.rez-rezn,r.rez-rez_30)),0) <> 0 ) t
         --счет резерва
         left join v_gls080 ar on (t.NBS_REZ = ar.nbs    and ar.rz   = t.rz  and t.OB22_REZ = ar.ob22 and t.KV      = ar.kv and ar.pap = decode(nal_,'0',1,'2',1,2) and
                                   t.branch  = ar.BRANCH and ar.dazs is null and t.r_s080   = ar.s080 and t.country = ar.country
                                   )
         group by t.ri    , t.country, t.id , t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz,
                  t.branch, t.sz     , t.szn, t.sz_30  , t.s080    , t.pr    , t.r_s080 , t.r013  , t.nd     , t.cc_id, t.nd_cp;
   ELSIF nal_ in ('3','7') THEN
      OPEN c0 FOR
         select t.ri, t.country, t.id   , t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz,t.branch,
                t.sz, t.szn    , t.sz_30, t.s080   , t.pr      , t.r_s080, t.r013   , t.nd    , t.cc_id  , t.nd_cp,
                substr(ConcatStr(ar.acc),1,999) r_acc, substr(ConcatStr(ar.nls),1,999) r_nls
         from (select r.rowid RI, c.country, r.id  , o.NBS_REZ     , o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r,
                      o.OB22_7r , o.pr     , o.r013, nvl(r.rz,1) rz, r.KV      , r.nd nd , r.cc_id  , r.nd_cp ,
                      rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
                      nvl(r.rez*100,0) sz,nvl(r.rezn*100,0) szn,nvl(r.rez_30*100,0) sz_30, decode(r.kat,1,1,9,9,2) s080,r.kat r_s080
               from nbu23_rez r
               join customer     c on (r.rnk = c.rnk)
               join srezerv_ob22 o on (r.nbs = o.nbs and o.nal = decode(nal_,'3','1',nal_) and
                                       nvl(r.ob22,0) = decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                       decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                       nvl(r.custtype,0) = decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                      r.kv = decode(o.kv,'0',r.kv,o.kv) )
               where fdat = dat01_ and nvl(decode(nal_,'3',rez-rez_30,rez_30),0) <> 0 and id like 'CACP%'  and
                     r.nls NOT in ('31145020560509','31145020560510')
              ) t
         --счет резерва
         left join v_gls080 ar on (t.NBS_REZ = ar.nbs    and t.OB22_REZ = ar.ob22 and ar.rz    = t.rz    and t.KV      = ar.kv      and
                                   t.branch  = ar.BRANCH and ar.dazs      is null and t.r_s080 = ar.s080 and t.country = ar.country and
                                   t.nd_cp   = ar.nkd  )
         group by t.ri    , t.country, t.id , t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz   ,
                  t.branch, t.sz     , t.szn, t.sz_30  , t.s080    , t.pr    , t.r_s080 , t.r013  , t.nd     , t.cc_id, t.nd_cp;
   else
      OPEN c0 FOR
         select t.ri, t.country, t.id   , t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz,t.branch,
                t.sz, t.szn    , t.sz_30, t.s080   , t.pr      , t.r_s080, t.r013   , t.nd    , t.cc_id  , t.nd_cp,
                substr(ConcatStr(ar.acc),1,999) r_acc, substr(ConcatStr(ar.nls),1,999) r_nls
         from (select r.rowid RI, c.country, r.id  , o.NBS_REZ     , o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r,
                      o.OB22_7r , o.pr     , o.r013, nvl(r.rz,1) rz, r.KV      , r.nd nd , r.cc_id  , r.nd_cp ,
                      rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
                      nvl(r.rez*100,0) sz,nvl(r.rezn*100,0) szn,0 sz_30, decode(r.kat,1,1,9,9,2) s080,r.kat r_s080
               from nbu23_rez r
               join customer     c on (r.rnk = c.rnk)
               join srezerv_ob22 o on (r.nbs = o.nbs and o.nal=decode(nal_,'3','0','4','1',nal_) AND 
                                       nvl(r.ob22,0)= decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                       decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                       nvl(r.custtype,0)= decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                       r.kv = decode(o.kv,'0',r.kv,o.kv) )
               where fdat = dat01_ and nvl(rez,0) <> 0 and r.nls in ('31145020560509','31145020560510')
              ) t
         --счет резерва
         left join v_gls080 ar on (t.NBS_REZ = ar.nbs    and t.OB22_REZ = ar.ob22 and ar.rz    = t.rz    and t.KV      = ar.kv and
                                   t.branch  = ar.BRANCH and ar.dazs      is null and t.r_s080 = ar.s080 and t.country = ar.country and
                                   t.nd_cp   = ar.nkd  )
         group by t.ri    , t.country, t.id , t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   ,t.rz,
                  t.branch, t.sz     , t.szn, t.sz_30  , t.s080    , t.pr    , t.r_s080 , t.r013  , t.nd     , t.cc_id,t.nd_cp;

   end if;

   loop
      FETCH c0 INTO k;
      EXIT WHEN c0%NOTFOUND;

      if instr(k.r_nls,',')=0 THEN
         If    nal_ IN ('0','1','4','B')         and k.sz   <> k.szn THEN
            update nbu23_rez set nls_rez   = substr(k.r_nls,1,15), acc_rez   = k.r_acc,  ob22_rez  = k.ob22_rez  where ROWID = K.RI;
         elsif nal_ IN ('2','5','6','7','C','D') and k.sz_30<> 0     THEN
            update nbu23_rez set nls_rez_30= substr(k.r_nls,1,15), acc_rez_30= k.r_acc, ob22_rez_30= k.ob22_rez  where ROWID = K.RI;
         else
            update nbu23_rez set nls_rez   = substr(k.r_nls,1,15), acc_rez   = k.r_acc, ob22_rez   = k.ob22_rez  where ROWID = K.RI;
         end if;
      end if;

   end loop;
end;
end;
/
show err;

PROMPT *** Create  grants  P_2400 ***
grant EXECUTE                                                                on P_2400          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_2400          to RCC_DEAL;
grant EXECUTE                                                                on P_2400          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_2400.sql =========*** End *** ==
PROMPT ===================================================================================== 
