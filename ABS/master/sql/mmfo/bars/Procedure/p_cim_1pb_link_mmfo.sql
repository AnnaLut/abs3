

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CIM_1PB_LINK_MMFO.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CIM_1PB_LINK_MMFO ***

  CREATE OR REPLACE PROCEDURE BARS.P_CIM_1PB_LINK_MMFO 
is
   l_dat date;
   l_date_begin date;
   l_date_end date;
   l_date_max date;
   l_mfo varchar2(6);
   l_2909 varchar2(15);
   l_2909_f varchar2(15);
   l_2909_mask varchar2(15);
begin
  l_dat:=trunc(sysdate); l_mfo:=f_ourmfo(); l_2909_mask:='2909%'; 
  case l_mfo 
    when '300465' then l_2909:='373980501061'; l_2909_f:='373980501061'; l_2909_mask:='373980501061';
    when '322669' then l_2909:='29096100260000'; l_2909_f:='29092100260082';--Київ
    when '351823' then l_2909:='29094100200000'; l_2909_f:='29090100200082';--Харків
    when '304665' then l_2909:='29094000120000'; l_2909_f:='29097100120082';--Луганськ
    when '335106' then l_2909:='29097100040000'; l_2909_f:='29097100040000';--Донецьк
    else bars_audit.info('P_CIM_1PB_LINK_MMFO ERRORS: Wrong user MFO: '||l_mfo||' Date: '||l_dat||'.'); return;
  end case;  
  l_date_begin:=trunc(last_day(add_months(l_dat-5,-1))+1); l_date_end:=trunc(last_day(l_dat-5)+1); l_date_max:=trunc(last_day(l_dat-5)+5);

  delete from bars.cim_1pb_2909_doc_tmp;
  insert into bars.cim_1pb_2909_doc_tmp (kf, ref, vdat, kv, s, mfoa, mfob, nlsa, nlsb, nam_a, nam_b, nazn)
  ( select o.kf, o.ref, o.vdat, o.kv, o.s, o.mfoa, o.mfob, o.nlsa,
           case when o.nlsb is null then ( select ( select nls from bars.accounts a where a.acc=p.acc and a.kf=p.kf) from bars.opldok p where p.dk=1 and p.ref=o.ref ) else o.nlsb end,
           o.nam_a, o.nam_b, o.nazn
      from ( select x.*, nvl(ra.ob22,'xx') as ob22a, nvl(rb.ob22, 'xx') as ob22b
                 from bars.oper x
                      left outer join bars.accounts ra on ra.kv=x.kv and ra.nls=x.nlsa and ra.kf=x.mfoa  
                      left outer join bars.accounts rb on rb.kv=x.kv and rb.nls=x.nlsb and rb.kf=x.mfob 
                where x.dk=1 and x.sos=5 and ( x.nlsa like l_2909_mask or x.nlsb like l_2909_mask )--(x.nlsa like '2909%' or x.nlsb like '2909%') 
                      and x.vdat between l_date_begin and l_date_max and x.kf=l_mfo ) o
     where  o.ob22a='56' or o.ob22b='56' or o.nlsa in (l_2909, l_2909_f) or o.nlsb in (l_2909, l_2909_f) );  
  delete from bars.cim_1pb_2909_doc_tmp where ref in (select ref_ru from bars.cim_1pb_ru_doc where changed_ru=2 and vdat between l_date_begin and l_date_end and kf=l_mfo );
  
  update bars.cim_1pb_2909_doc_tmp o set
    o.n=(select n from
           ( select row_number() over (partition by x.mfoa, x.nlsa, x.kv, x.s  order by x.vdat, x.ref) as n, x.ref
               from bars.cim_1pb_2909_doc_tmp x where x.vdat<l_date_end and nlsa not like '3720%' and x.nlsb in (l_2909, l_2909_f) ) a
          where a.ref=o.ref)
  where o.nlsb in (l_2909, l_2909_f);
  
  update bars.cim_1pb_2909_doc_tmp o set o.ref1=
   ( select b.ref from
     ( select row_number() over (partition by o.mfob, o.nlsb, o.kv, o.s order by o.vdat, o.ref) as n, o.kv, o.s, o.mfob, o.nlsb, o.ref
         from bars.cim_1pb_2909_doc_tmp o where o.vdat<l_date_end and substr(o.nlsb, 1, 4) in ('2909', '3720', '3739') ) a
      left outer join
     ( select row_number() over (partition by o.mfoa, o.nlsa, o.kv, o.s order by o.vdat, o.ref) as n, o.kv, o.s, o.mfoa, o.nlsa, o.ref
         from bars.cim_1pb_2909_doc_tmp o where substr(o.nlsa, 1, 4) in ('2909', '3720', '3739') ) b
     on a.n=b.n and b.mfoa=a.mfob and b.nlsa=a.nlsb and a.kv=b.kv and a.s=b.s
    where a.ref=o.ref)
  where substr(o.nlsb, 1, 4) in ('2909', '3720', '3739');
  update bars.cim_1pb_2909_doc_tmp o set o.ref2= ( select a.ref1 from bars.cim_1pb_2909_doc_tmp a where a.ref=o.ref1 )
   where o.ref1 is not null;
  update bars.cim_1pb_2909_doc_tmp o set o.ref3= ( select a.ref1 from bars.cim_1pb_2909_doc_tmp a where a.ref=o.ref2 )
   where o.ref2 is not null;
  commit; 

  merge into bars.cim_1pb_ru_doc r
  using ( select a.ref_ca, a.vdat, a.kv, a.s, a.mfoa, a.mfob, a.nlsa, a.kod_n_ca,                
                 nvl(d.kf, a.mfob) as kf, d.ref as ref_ru, d.nlsb, d.nazn as nazn_ru, w.value as kod_n_ru,
                 decode(c.custtype, 2, 'U', 3, CASE WHEN c.sed = '91' THEN 'S' ELSE 'F' END) AS cl_type,
                 c.okpo as cl_ipn, DECODE (c.custtype, 2, c.nmkk, '') AS cl_name
            from ( select row_number() over (partition by o.mfoa, o.nlsa, o.kv, o.s order by o.vdat, o.ref_ca) as n,
                          o.ref_ca, o.vdat, o.kv, o.s, o.mfoa, o.mfob, o.nlsa, o.nlsb, o.kod_n_ca, u.ref_ru as ref_ru_x, u.changed_ru                       
                     from bars.cim_1pb_out_doc o
                          left outer join bars.cim_1pb_ru_doc u on u.ref_ca=o.ref_ca
                    where o.vdat<l_date_end and o.vdat>=l_date_begin and o.mfob=l_mfo ) a
                 left outer join bars.cim_1pb_2909_doc_tmp t on t.n=a.n and t.mfoa=a.mfoa and t.nlsa=a.nlsa and t.kv=a.kv and t.s=a.s       
                 left outer join bars.cim_1pb_2909_doc_tmp d on d.ref=nvl(t.ref3,nvl(t.ref2, nvl(t.ref1, a.ref_ru_x)))
                 left outer join bars.operw w on w.tag='KOD_N' and w.ref=d.ref 
                 left outer join bars.accounts r on r.kv = a.kv AND r.nls = d.nlsb and r.kf=a.mfob
                 left outer join bars.customer c on c.rnk=r.rnk and c.kf=a.mfob 
           where a.changed_ru!=2 or a.changed_ru is null         
               ) i
   on (r.ref_ca=i.ref_ca)
  when matched then
    update set r.kf=i.kf, r.ref_ru=i.ref_ru, r.nlsb=i.nlsb, r.nazn_ru=i.nazn_ru, r.kod_n_ru=i.kod_n_ru, r.md=case when r.kod_n_ru<>i.kod_n_ru then null else r.md end, 
               r.cl_type=i.cl_type, r.cl_ipn=i.cl_ipn, r.cl_name=i.cl_name
  when not matched then  
    insert (ref_ca, vdat, kv, s, mfoa, mfob, nlsa, kod_n_ca, kf, ref_ru, nlsb, nazn_ru, kod_n_ru, cl_type, cl_ipn, cl_name) 
    values (i.ref_ca, i.vdat, i.kv, i.s, i.mfoa, i.mfob, i.nlsa, i.kod_n_ca, i.kf, i.ref_ru, i.nlsb, i.nazn_ru, i.kod_n_ru, i.cl_type, i.cl_ipn, i.cl_name);

  bars_audit.info('P_CIM_1PB_LINK_MMFO Success. MFO: '||l_mfo||' Date: '||l_dat||'.');  commit;
end p_cim_1pb_link_mmfo;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CIM_1PB_LINK_MMFO.sql =========*
PROMPT ===================================================================================== 
