
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_count_credit_partners_ru.sql ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_COUNT_CREDIT_PARTNERS_RU (dat1 date, dat2 date, p_prt_type varchar2) return t_credit_partners_table
is
  l_crd_par t_credit_partners_table;
begin

       execute immediate 'select t_count_credit_partners(pt.id,
                                pt.name,
                                p.id,
                                p.NAME,
                                p.PTN_OKPO,
                                sp.prod,
                                pm.ID,
                                pm.NAME,
                                sum((select count(1)
                                   from cc_v d,
                                        wcs_partners_all spt
                                  where
                                        spt.id = sp.id
                                    and    d.nd = sp.nd
                                    and d.prod = sp.prod
                                    and d.branch = sp.branch
                                    and d.AWDATE >= :dat1 and d.AWDATE <= :dat2)),
                                trim(to_char(sum((select sum(d.sdog)
                                   from cc_v d,
                                        wcs_partners_all spt
                                  where sp.nd = d.nd
                                    and spt.id = p.id
                                    and d.prod = sp.prod
                                    and d.branch = sp.branch
                                    and d.AWDATE >= :dat1 and d.AWDATE <= :dat2)),''9999999990D00'')),
                                 null,
                                listagg((select ''Дог: ''||sp.nd||'' залучений ''||txt from nd_txt where nd = sp.nd and tag = ''PAR_I''),'', ''||chr(13)||chr(10)) within group (order by sp.nd),
                                (select VAL from params$base where par = ''NAME''),
                                br.name)
                           from wcs_partners_all p,
                                wcs_partner_types pt,
                                (select      spt.TYPE_ID as pi_partner_id,
                                             d.acckred,
                                             spt.id,
                                             spt.name,
                                             spt.type_id,
                                             d.nd as nd,
                                             d.branch as branch,
                                             d.prod
                                        from cc_v d,
                                             wcs_partners_all spt,
                                 (select nd,txt from nd_txt where  tag = ''PAR_N'') rekv
                                       where rekv.txt = spt.id and rekv.nd = d.nd and d.sos in (10,11,13,15)  and d.AWDATE >= :dat1 and d.AWDATE <= :dat2) sp,
                                wcs_partners_mather pm,
                                branch br
                          where p.TYPE_ID = pt.id
                            and p.TYPE_ID = sp.pi_partner_id
                            and p.ID_MATHER = pm.ID
                           and sp.id = p.id
                            and sp.branch = br.branch
                            and pt.id = :p_prt_type
                          group by pt.id, pt.name, p.id, p.NAME, p.PTN_OKPO, sp.prod, pm.NAME, br.name, sp.branch, pm.id, sp.id'
       bulk collect into l_crd_par
       using dat1, dat2, dat1, dat2, dat1, dat2, p_prt_type;

  return l_crd_par;
end;
/
 show err;
 
PROMPT *** Create  grants  GET_COUNT_CREDIT_PARTNERS_RU ***
grant EXECUTE                                                                on GET_COUNT_CREDIT_PARTNERS_RU to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_count_credit_partners_ru.sql ==
 PROMPT ===================================================================================== 
 