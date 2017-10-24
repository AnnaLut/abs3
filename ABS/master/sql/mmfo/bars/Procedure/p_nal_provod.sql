

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NAL_PROVOD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NAL_PROVOD ***

  CREATE OR REPLACE PROCEDURE BARS.P_NAL_PROVOD (p_dat1    varchar2, p_dat2   varchar2, p_tt varchar2)   IS
l_nazn   varchar2(160);
l_namtt  varchar2(70);
l_tt     varchar2(3);
l_dd     number;
MODCODE   constant varchar2(3) := 'REP';
/*
  qwa  верс  18.10.2011
       Добавила параметр  p_tt='000'
       - реєстр проводок по рахунках неповязаних з декларац_єю (\BRS\SBM\NAL\4)
  QWA  верс. 04.03.2010
       добавила индексы ао аналог с p_rep_provod
  QWA  верс. 16.07.2009
  процедура  отбора данных     для реестра проводок по
  налоговому учету  за период
  условия:
        работает только по кодам операции  (PO1, PO3)
        период больше месяца не позволяем задать
*/
begin
 execute immediate 'truncate table tmp_rep_provod';

 if ltrim(rtrim(p_tt)) not in ('PO1','PO3','000')
   then  bars_error.raise_nerror(MODCODE, '34');
 end if;

 l_dd:=to_date(p_dat2,'dd-mm-yyyy') -  to_date(p_dat1,'dd-mm-yyyy') ;

 if l_dd>30
     then  bars_error.raise_nerror(MODCODE, '38');
 end if;

 if p_tt in ('PO1','PO3') then  -- реєстр проводок по рахунках ПО (8 клас)  \BRS\SBM\NAL\5

   for i in (select /*-+ INDEX(p)*/
                 p.ref,p.tt, p.nlsa,p.nlsb,p.nazn,p.userid
           from  oper p
          where   exists
             (select /*-+ INDEX(opldok)*/
                1
                from    opldok
                where   tt = p_tt
                    and ref=p.ref
                    and fdat>=to_date(p_dat1,'dd-mm-yyyy')
                    and fdat<=to_date(p_dat2,'dd-mm-yyyy')
                    and sos in (4,5)))
   loop
    for d in (with opp as (select * from opldok where fdat BETWEEN p_dat1 AND p_dat2)
              select d1.fdat,d1.TT,   d1.REF,  d2.KV,  d2.NLS NLSA,  d1.S,  d1.SQ,
                     k2.NLS NLSB, d1.TXT, k2.TIP
              from   opp d1, opp k1, accounts d2, accounts k2
              WHERE  d1.REF  = i.ref
                 AND d1.tt   = p_tt
                 AND d1.sos  in (4,5)
                 AND d1.fdat = k1.fdat
                 AND k1.sos  in (4,5)
                 AND d1.REF  = k1.REF
                 AND d1.tt   = k1.tt
                 AND d1.acc  = d2.acc
                 AND k1.acc  = k2.acc
                 AND d2.kv   = k2.kv
                 AND d1.stmt = k1.stmt
                 AND d1.dk   = 0    AND   k1.dk   = 1
                 AND d1.s    = k1.s
                 AND d1.sq   = k1.sq
                 AND d2.nbs  like '8%'
                 AND k2.nbs  like '8%')
    loop
      l_nazn:=i.nazn;
      begin
        select  name into l_namtt  from  tts   where tt=d.tt;
        exception when no_data_found then  l_namtt:=d.txt;
      end;
      insert into tmp_rep_provod
       (TT,     REF,   KV,   NLSA,    S,   SQ,  NLSB,   NAZN,
        PDAT, NAMTT,  ISP)
      values
       (d.TT,   d.REF,   d.KV, d.NLSA,  d.S, d.SQ, d.NLSB, l_nazn,
        d.fdat, l_namtt, i.USERID) ;
    end loop;
   end loop;
 else   -- реєстр проводок по рахунках неповязаних з декларац_єю \BRS\SBM\NAL\4
  for i in (select     /*-+ INDEX(p)*/
                 p.ref,p.tt, p.nlsa,p.nlsb,p.nazn,p.userid
           from  oper p
          where   exists
             (select /*-+ INDEX(opldok)*/
                1
                from    opldok
                where   ref=p.ref
                    and fdat>=to_date(p_dat1,'dd-mm-yyyy')
                    and fdat<=to_date(p_dat2,'dd-mm-yyyy')
                    and sos in (4,5)
                    and acc in (select acc from v_ob22_nn)
              )
           )
  loop
    for d in (with opp as (select * from opldok where fdat BETWEEN p_dat1 AND p_dat2)
              select d1.fdat,d1.TT,   d1.REF,  d2.KV,  d2.NLS NLSA,  d1.S,  d1.SQ,
                     k2.NLS NLSB, d1.TXT, k2.TIP
              from   opp d1, opp k1, accounts d2, accounts k2
              WHERE  d1.REF  = i.ref
                 AND d1.sos  in (4,5)
                 AND d1.fdat = k1.fdat
                 AND k1.sos  in (4,5)
                 AND d1.REF  = k1.REF
                 AND d1.tt   = k1.tt
                 AND d1.acc  = d2.acc
                 AND k1.acc  = k2.acc
                 AND d2.kv   = k2.kv
                 AND d1.stmt = k1.stmt
                 AND d1.dk   = 0    AND   k1.dk   = 1
                 AND d1.s    = k1.s
                 AND d1.sq   = k1.sq
                 AND (d1.acc in (select acc from v_ob22_nn)
                      or
                      k1.acc in (select acc from v_ob22_nn)
                     ))
    loop
      l_nazn:=i.nazn;
      begin
        select  name into l_namtt  from  tts   where tt=d.tt;
        exception when no_data_found then  l_namtt:=d.txt;
      end;
      insert into tmp_rep_provod
       (TT,     REF,   KV,   NLSA,    S,   SQ,  NLSB,   NAZN,
        PDAT, NAMTT,  ISP)
      values
       (d.TT,   d.REF,   d.KV, d.NLSA,  d.S, d.SQ, d.NLSB, l_nazn,
        d.fdat, l_namtt, i.USERID) ;
    end loop;
  end loop;

 end if;
commit;
end p_nal_provod;
/
show err;

PROMPT *** Create  grants  P_NAL_PROVOD ***
grant EXECUTE                                                                on P_NAL_PROVOD    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_NAL_PROVOD    to NALOG;
grant EXECUTE                                                                on P_NAL_PROVOD    to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NAL_PROVOD.sql =========*** End 
PROMPT ===================================================================================== 
