

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REP_PROVOD_OPL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REP_PROVOD_OPL ***

  CREATE OR REPLACE PROCEDURE BARS.P_REP_PROVOD_OPL 
          (p_dat    varchar2,
           p_isp    varchar2 )   IS
l_nazn   varchar2(160);
l_nlsb   varchar2(15);
l_namtt  varchar2(70);
l_id     number;
l_isp    number;
MODCODE   constant varchar2(3) := 'REP';

begin
delete from tmp_rep_provod;
if replace(replace(p_isp,'%',' '),' ','') is null
   then bars_error.raise_nerror(MODCODE, '32');
end if;
begin
    select id   into l_id
     from staff$base
    where id=to_number(p_isp);
    exception when no_data_found
              then bars_error.raise_nerror(MODCODE, '33');

end;
begin
    select id into l_id from staff$base where id=to_number(p_isp);
    exception when no_data_found
              then bars_error.raise_nerror(MODCODE, '33');
end;

for i in (

select /*+ INDEX(v)*/  o.*, v.userid as user_op, v.status, v.groupid
  from (
         select /*+ INDEX(p)*/
                 p.ref,p.tt, p.nlsa,p.nlsb,p.nazn,p.userid,p.branch
            from oper p,
                 (select /*+ INDEX(opldok)*/
                         distinct ref
                    from opldok
                   where fdat = to_date(p_dat, 'dd-mm-yyyy')
                     and fdat between to_date(p_dat, 'dd-mm-yyyy')  and to_date(p_dat, 'dd-mm-yyyy') +0.999
                     and sos in (4,5)
                     ) t
           where p.ref = t.ref) o, oper_visa v
 where v.ref = o.ref
   and v.status =2
   and groupid not in (77, 80, 81, 30)
             )
loop

/*
    begin
    select userid
      into l_isp
      from oper_visa
     where ref = i.ref
       and status =2
       and groupid not in (77, 80, 81, 30);
       --and rownum = 1 order by sqnc desc;
     EXCEPTION WHEN NO_DATA_FOUND THEN

       CONTINUE;  -- ???? тільки оплата візою?

                  begin
                        select userid
                          into l_isp
                          from oper_visa
                         where ref = i.ref
                           and status =0 and rownum = 1;
                         EXCEPTION WHEN NO_DATA_FOUND THEN  l_isp := 0;
                 end;
    end;

      CONTINUE WHEN l_isp != p_isp;
  */



      if (    i.user_op = p_isp  and
              i.status =2        and
              i.groupid not in (77, 80, 81, 30)    )
      then    null;
      else    CONTINUE;
      end if;


    for d in (select
                     d1.TT,   d1.REF,  d2.KV,  d2.NLS NLSA,  d1.S,  d1.SQ,
                     k2.NLS NLSB, d1.TXT, k2.TIP
              from   opldok d1, opldok k1, accounts d2, accounts k2
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
                 AND d1.fdat = to_date(p_dat,'dd-mm-yyyy')
                 AND k1.fdat = to_date(p_dat,'dd-mm-yyyy')
                 AND nvl(d2.nbs,'8888') not like '8%'
                 AND nvl(K2.nbs,'8888') not like '8%')
    loop
      if i.tt=d.tt  then l_nazn:=i.nazn;
                    else l_nazn:=d.TXT;
      end if;
      if d.tip='T00' then l_nlsb:=i.NLSB;
                     else l_nlsb:= d.NLSB;
      end if;
      begin
        select  name into l_namtt  from  tts   where tt=d.tt;
        exception when no_data_found then  l_namtt:=d.txt;
      end;
      insert into  tmp_rep_provod
       (TT,     REF,   KV,   NLSA,    S,   SQ,  NLSB,   NAZN,
        PDAT, NAMTT,  ISP,BRANCH)
      values
       (d.TT,   d.REF,   d.KV, d.NLSA,  d.S, d.SQ, l_NLSB, l_nazn,
        to_date(p_dat,'dd-mm-yyyy'), l_namtt, i.user_op, i.branch) ;
    end loop;
end loop;
commit;
end p_rep_provod_opl;
/
show err;

PROMPT *** Create  grants  P_REP_PROVOD_OPL ***
grant EXECUTE                                                                on P_REP_PROVOD_OPL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_REP_PROVOD_OPL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REP_PROVOD_OPL.sql =========*** 
PROMPT ===================================================================================== 
