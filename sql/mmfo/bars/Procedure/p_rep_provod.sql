

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REP_PROVOD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REP_PROVOD ***

  CREATE OR REPLACE PROCEDURE BARS.P_REP_PROVOD 
          (p_dat    varchar2,
           p_isp    varchar2,
           p_par    number default 1 )   IS
l_nazn   varchar2(160);
l_nlsb   varchar2(15);
l_namtt  varchar2(70);
l_id     number;
MODCODE   constant varchar2(3) := 'REP';
/*
  12.11.2012 qwa  Добавили парметр p_par для отбора данных отчета "Реестр проводок" (63 отчет)
                  для банка Надра=2 - эквивалент расчетный  по курсу даты формирования
                  +сортировка бранчей при выборе параметра
                  Переключевала запрос - вместо \BRS\SBM\REP\578 - \BRS\NDR\REP\578
  28.07.2010 QWA  В выборку добавлено поле BRANCH для того,
                  чтобы можно было отбирать информацию
                  от заданного пользователя по разным бранчам
                  (с учетом того, что список бранчей - только мой и все подчиненнные)
  29.07.2009 DG  оптимизация селекта
  14.07.2009 QWA процедура отбора данных для реестра проводок
                 по исполнителю за дату
*/
begin
   delete from tmp_rep_provod;

   if replace(replace(p_isp,'%',' '),' ','') is null
       then bars_error.raise_nerror(MODCODE, '32');
   end if;
   begin
      select id   into l_id
        from staff$base
       where id=to_number(p_isp);
    exception when no_data_found then bars_error.raise_nerror(MODCODE, '33');

   end;



   for i in (select p.ref,p.tt, p.nlsa,p.nlsb,p.nazn,p.userid,p.branch
                from oper p,
                     (select
                      distinct ref
                        from opldok o, saldoa s
                       where s.fdat = to_date(p_dat, 'dd-mm-yyyy')  and sos in (4,5)  and o.fdat = s.fdat and o.acc = s.acc and o.dk = 0
                     ) t
               where p.ref = t.ref
                 and p.userid=to_number(trunc(replace(p_isp,'%',' ')))
			 )

   loop


        for d in (select d1.TT,   d1.REF,  d2.KV,  d2.NLS NLSA,  d1.S,  d1.SQ, k2.NLS NLSB, d1.TXT, k2.TIP
                    from   opldok d1, opldok k1, accounts d2, accounts k2
                   WHERE d1.REF  = i.ref
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
                     AND nvl(d2.nbs,'0000') not like '8%'
                     AND nvl(K2.nbs,'0000') not like '8%'
                 )
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



          if p_par=1 then   -- эквивалент как в opldok
              insert into tmp_rep_provod (TT,     REF,   KV,   NLSA,    S,   SQ,  NLSB,   NAZN, PDAT, NAMTT,  ISP,BRANCH)
              values (d.TT,   d.REF,   d.KV, d.NLSA,  d.S, d.SQ, l_NLSB, l_nazn, to_date(p_dat,'dd-mm-yyyy'), l_namtt, i.USERID,i.branch) ;

         elsif p_par=2 then -- эквивалент расчетный
              insert into tmp_rep_provod        (TT,     REF,   KV,   NLSA,    S,   SQ,  NLSB,   NAZN,  PDAT, NAMTT,  ISP,BRANCH)
              values       (d.TT,   d.REF,   d.KV, d.NLSA,  d.S,   decode(d.kv,980,d.s,gl.p_icurval(d.kv,d.s,to_date(p_dat,'dd-mm-yyyy'))), l_NLSB, l_nazn,
                      to_date(p_dat,'dd-mm-yyyy'), l_namtt, i.USERID,i.branch) ;
         end if;
    end loop;

end loop;
commit;
end p_rep_provod;
/
show err;

PROMPT *** Create  grants  P_REP_PROVOD ***
grant EXECUTE                                                                on P_REP_PROVOD    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_REP_PROVOD    to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REP_PROVOD.sql =========*** End 
PROMPT ===================================================================================== 
