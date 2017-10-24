

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PR_OB529.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PR_OB529 ***

  CREATE OR REPLACE PROCEDURE BARS.PR_OB529 ( MODE_ int, p_dat1 varchar2,p_dat2 varchar2 ) is
   l_tkolk number;
   l_tkold number;
   l_tqumd  number;
   l_tqumk number;
   ern  CONSTANT POSITIVE := 021;
   erm  VARCHAR2(80);
   err  EXCEPTION;
begin

---------------------------------
  If MODE_= 1 then
    delete from tmp_ob529;
     for p in ( SELECT a.ACC, a.NLS, a.KV, a.NMS, z.KOLK, z.KOLD, z.SUMK,
                       z.SUMD, z.QUMK, z.QUMD, v.MFOB, v.NLSB, v.NAM_B, v.KOL,  v.S, v.Q, r.RU, r.NAME
                FROM ACCOUNTS a,  banks_RU R,
                     ( select c.ACC,
                              sum(decode(o.dk,1,1   ,0)) KOLK,
                              sum(decode(o.dk,0,decode(substr(o.TT,1,2),'TK',1   ,0),0)) KOLD,
                              sum(decode(o.dk,1,o.S ,0)) SUMK,
                              sum(decode(o.dk,0,decode(substr(o.TT,1,2),'TK',o.S ,0),0)) SUMD,
                              sum(decode(o.dk,1,o.SQ,0)) QUMK,
                              sum(decode(o.dk,0,decode(substr(o.TT,1,2),'TK',o.SQ,0),0)) QUMD
                       from accounts c,    opldok o
                    where o.fdat between  to_date(p_dat1,'dd-mm-yyyy') and
                                          to_date(p_dat2,'dd-mm-yyyy')
                    and o.sos = 5 and o.acc = c.acc
                      and c.tip in ('NLA','NLP','NL3' ) and c.nbs = '2906'
                   group by c.acc ) Z,
                 ( select c.ACC,   o.MFOB,  o.NLSB,   o.NAM_B, count(*) KOL,   sum(p.S) S,  sum(p.SQ) Q
                   from accounts c,  oper o,      opldok p
                   where p.fdat between to_date(p_dat1,'dd-mm-yyyy') and
                                        to_date(p_dat2,'dd-mm-yyyy')
                     and p.dk   = 0 and p.sos  = 5 and p.ref  = o.ref and p.acc  = c.acc
                     and c.tip in ('NLA','NLP','NL3' )  and c.nbs  = '2906'
                     and substr(o.TT,1,2) <> 'TK'
                   group by c.ACC, o.MFOB,o.NLSB,o.NAM_B
                   union ALL          select ACC,'300465',  '',  '',     0,    0,        0
                   from accounts           where tip in ('NLA','NLP','NL3' ) and nbs='2906' ) V
             WHERE a.acc = z.acc and a.acc = v.acc  and a.tip in ('NLA','NLP','NL3' ) and a.nbs = '2906'  and MFO_RU(v.MFOB) = r.RU
             ORDER BY a.NLS, a.KV , r.RU )
  LOOP
    insert into tmp_ob529
      (    ACC,    NLS,     KV,    NMS,    KOLK,   KOLD,   SUMK,   SUMD,
          QUMK,   QUMD,   MFOB,   NLSB,   NAM_B,    KOL,      S,      Q,
            RU,   NAME,  TKOLK,  TKOLD,   TQUMD,  TQUMK )
    values
      (  p.ACC,  p.NLS,   p.KV,  p.NMS,  p.KOLK, p.KOLD, p.SUMK, p.SUMD,
        p.QUMK, p.QUMD, p.MFOB, p.NLSB, p.NAM_B,  p.KOL,    p.S,    p.Q,
          p.RU, p.NAME,   0,         0,       0,      0 );
  END LOOP;

    ----  подсчет общих итогов - пишем в 1-ю запись
  begin
    select sum(t.kolk), sum(t.kold), sum(t.qumd), sum(t.qumk)
      into     l_tkolk,     l_tkold,     l_tqumd,    l_tqumk
    from (select distinct acc, kolk, kold, qumd, qumk from tmp_ob529) t;
    exception when no_data_found then null;
  end;
  update tmp_ob529 set tkolk = l_tkolk,  tkold = l_tkold, tqumd = l_tqumd, tqumk = l_tqumk
                 where rownum() = 1;
------------------------------------
  ElsIf MODE_= 2 then

   delete from TMP_CRTX;

    insert into TMP_CRTX ( fdat, acc, ref)
    select  f.FDAT, c.acc, 0
    from fdat f, accounts c where c.nbs='3801' AND f.fdat>=TRUNC(to_date(p_dat2,'dd-mm-yyyy'),'YEAR')
         AND f.fdat<= to_date(p_dat2,'dd-mm-yyyy') ;

    Update TMP_CRTX t set ref= (select nvl(Sum( -(2*dk-1)*s ) ,0) from opldok where acc=t.acc and tt='PVP' and fdat=t.fdat);

    Update TMP_CRTX t set acc= (select nls from accounts where acc=t.acc);

/*   insert into TMP_CRTX ( fdat, acc, ref)
    select  q.FDAT, c.nls,   Sum( -(2*q.dk-1)*q.s ) PVP
    from opldok q,  accounts c
    where q.tt ='PVP' and   q.acc=c.acc and c.nbs='3801' AND q.fdat>=TRUNC(p_dat1,'YEAR') AND q.fdat<= p_dat1
    group by  q.FDAT, c.nls ;
*/

  For k in (select distinct ACC from TMP_CRTX order by acc )
  LOOP
    For p in (select fdat, ref from TMP_CRTX  where acc=k.Acc order by fdat)
    Loop
      update TMP_CRTX set ref=ref + p.ref where acc=k.acc and fdat> p.fdat;
    End Loop;
  END Loop;
-------------------------------
  end if;

  commit;

end  PR_OB529;
/
show err;

PROMPT *** Create  grants  PR_OB529 ***
grant EXECUTE                                                                on PR_OB529        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PR_OB529        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PR_OB529.sql =========*** End *** 
PROMPT ===================================================================================== 
