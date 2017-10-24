

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CIM_1PB_LINK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CIM_1PB_LINK ***

  CREATE OR REPLACE PROCEDURE BARS.P_CIM_1PB_LINK (p_dat in varchar2 --Дата звіту
                                             )
is
   l_dat date;
   l_date_begin date;
   l_date_end date;
   l_date_max date;
   l_2909 varchar2(15);
   l_txt varchar2(100);
   l_err_txt varchar2(4000);
begin
  l_dat:=to_date(p_dat, 'dd/mm/yyyy'); l_date_begin:=trunc(last_day(add_months(l_dat,-2))+1);
  l_date_end:=trunc(last_day(add_months(l_dat,-1))+1); l_date_max:=trunc(last_day(add_months(l_dat,-1))+5);
  select distinct o.nlsb into l_2909 from oper o where o.nlsb like '2909%' and o.nlsa like '1500%' and o.pdat < l_date_end and o.pdat >= l_date_begin;

  delete from cim_1pb_2909_doc_tmp;
  insert into cim_1pb_2909_doc_tmp (kf, ref, vdat, kv, s, mfoa, mfob, nlsa, nlsb, nam_a, nam_b, nazn)
  ( /* select o.kf, o.ref, o.vdat, o.kv, o.s, o.mfoa, o.mfob, o.nlsa,
           case when o.nlsb is null then ( select ( select nls from accounts a where a.acc=p.acc) from opldok p where p.dk=1 and p.ref=o.ref ) else o.nlsb end,
           o.nam_a, o.nam_b, o.nazn
      from oper o
           join
             ( select distinct x.ref
                 from oper x
                where x.dk=1 and x.sos=5 and
                      ( (select a.ob22 from accounts a where a.kf=x.mfoa and a.kv=x.kv and a.nls=x.nlsa)='56' and x.nlsa like '2909%' or
                        (select a.ob22 from accounts a where a.kf=x.mfob and a.kv=x.kv and a.nls=x.nlsb)='56' and x.nlsb like '2909%' or
                        l_2909 in (x.nlsa, x.nlsb) ) and
                      x.vdat < l_date_max and x.vdat >= l_date_begin ) z
             on o.ref=z.ref*/

    select o.kf, o.ref, o.vdat, o.kv, o.s, o.mfoa, o.mfob, o.nlsa,
           case when o.nlsb is null then ( select ( select nls from accounts a where a.acc=p.acc) from opldok p where p.dk=1 and p.ref=o.ref ) else o.nlsb end,
           o.nam_a, o.nam_b, o.nazn
      from ( select x.*, nvl(ra.ob22,'xx') as ob22a, nvl(rb.ob22, 'xx') as ob22b
                 from oper x
                      left outer join accounts ra on ra.kf=x.mfoa and ra.kv=x.kv and ra.nls=x.nlsa
                      left outer join accounts rb on rb.kf=x.mfob and rb.kv=x.kv and rb.nls=x.nlsb
                where x.dk=1 and x.sos=5 and (x.nlsa like '2909%' or x.nlsb like '2909%') and x.vdat < l_date_max and x.vdat >= l_date_begin ) o
     where  o.ob22a='56' or o.ob22b='56' or l_2909 in (o.nlsa, o.nlsb) );

  update cim_1pb_2909_doc_tmp o set
    o.n=(select n from
           ( select row_number() over (partition by x.mfoa, x.nlsa, x.kv, x.s  order by x.vdat, x.ref) as n, x.ref
               from cim_1pb_2909_doc_tmp x where x.vdat<l_date_end and x.nlsb=l_2909 ) a
          where a.ref=o.ref)
  where o.nlsb=l_2909;

  update cim_1pb_2909_doc_tmp o set o.ref1=
   ( select b.ref from
     ( select row_number() over (partition by o.mfob, o.nlsb, o.kv, o.s order by o.vdat, o.ref) as n, o.kv, o.s, o.mfob, o.nlsb, o.ref
         from cim_1pb_2909_doc_tmp o where o.vdat<l_date_end and substr(o.nlsb, 1, 4) in ('2909', '3720') ) a
      left outer join
     ( select row_number() over (partition by o.mfoa, o.nlsa, o.kv, o.s order by o.vdat, o.ref) as n, o.kv, o.s, o.mfoa, o.nlsa, o.ref
         from cim_1pb_2909_doc_tmp o where substr(o.nlsa, 1, 4) in ('2909', '3720') ) b
     on a.n=b.n and b.mfoa=a.mfob and b.nlsa=a.nlsb and a.kv=b.kv and a.s=b.s
    where a.ref=o.ref)
  where substr(o.nlsb, 1, 4) in ('2909', '3720');

  update cim_1pb_2909_doc_tmp o set o.ref2=
    ( select a.ref1 from cim_1pb_2909_doc_tmp a where a.ref=o.ref1)
   where o.ref1 is not null;

  update cim_1pb_2909_doc_tmp o set o.ref3=
    ( select a.ref1 from cim_1pb_2909_doc_tmp a where a.ref=o.ref2)
   where o.ref2 is not null;

  delete from sync_errors; delete from sync_params; delete from cim_1pb_ru_doc_tmp;
  insert into sync_params (params, type, value) values (':p_date_begin', 'DATE', to_char(l_date_begin, 'dd/mm/yyyy'));
  insert into sync_params (params, type, value) values (':p_date_end', 'DATE', to_char(l_date_end, 'dd/mm/yyyy'));
  insert into sync_params (params, type, value) values (':p_nls', 'STR', l_2909);
  commit;
  l_txt:=SYNC.F_SYNC_TRANSMIT('2909_DOC');

  if l_txt='Обмін даними успішно завершений.' then
    insert into cim_1pb_ru_doc (ref, ref_ca, vdat, kv, s, mfoa, nlsa, kod_n_ca, nam_a, ref_ru, kf, kod_n_ru)
      select t.ref, a.ref_ca, a.vdat, a.kv, a.s, a.mfoa, a.nlsa,
             case when not exists ( select transcode from bopcode where transcode=a.kod_n_ca) then null else a.kod_n_ca end as kod_n_ca, t.nam_a, d.ref, f_ourmfo,
             case when exists ( select transcode from bopcode where transcode=w.value) then w.value
                  when not exists ( select transcode from bopcode where transcode=a.kod_n_ca) or a.kod_n_ca like '8273%' then null
                  else a.kod_n_ca end as kod_n_ru
        from
        ( select t.ref_ca, t.vdat, t.kv, t.s, t.mfoa, t.nlsa, t.kod_n_ca,
                 row_number() over (partition by t.mfoa, t.nlsa, t.kv, t.s order by t.vdat, t.ref_ca) as n
            from cim_1pb_ru_doc_tmp t
           where not exists (select d.ref_ca from cim_1pb_ru_doc d where d.ref_ca=t.ref_ca) ) a
          left outer join cim_1pb_2909_doc_tmp t on t.n=a.n and t.mfoa=a.mfoa and t.nlsa=a.nlsa and t.kv=a.kv and t.s=a.s
          left outer join cim_1pb_2909_doc_tmp d on d.ref=nvl(t.ref3,nvl(t.ref2, t.ref1))
          left outer join operw w on w.tag='KOD_N' and w.ref=d.ref;
  else
    select concatstr(component||' - '||err_txt||chr(13)) into l_err_txt from sync_errors;
    bars_audit.info('SYNC SERVISE 2909_DOC ERRORS:'||chr(13)||l_txt||chr(13)||l_err_txt);
  end if;
  commit;

end p_cim_1pb_link;
/
show err;

PROMPT *** Create  grants  P_CIM_1PB_LINK ***
grant EXECUTE                                                                on P_CIM_1PB_LINK  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_CIM_1PB_LINK  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CIM_1PB_LINK.sql =========*** En
PROMPT ===================================================================================== 
