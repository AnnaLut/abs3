
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cim_2c_p73.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CIM_2C_P73 (p_dat in date,
                                              p_rnk in number,
                                              p_benef_id in number) return number
is
  p73 number;
begin
  select nvl(sum( case when q.kv=840 then q.z else p_ncurval( 840, p_icurval( q.kv, q.z, q.open_date ), q.open_date ) end ), 0) into p73
    from
    ( select max(y.open_date) as open_date, max(y.kv) as kv,
             max(y.s) - sum( case when y.vdat <= nvl(vv.allow_dat, a.allow_date) or vv.allow_dat is null and a.allow_date is null then 0 else round(y.s*l.s/y.s_cv, 0) end ) as z
        from
        ( select x.*
            from
            ( with c as ( select contr_id, trunc(open_date) as open_date from cim_contracts where contr_type=1 and benef_id=p_benef_id and rnk=p_rnk )
              select /*+ ORDERED c, p, o) */
                     c.open_date, 0 as t, p.bound_id, trunc( NVL( (SELECT MAX (fdat) FROM opldok WHERE REF = o.REF), o.vdat ) ) as vdat, o.kv, p.s, p.s_cv
                from c
                     join cim_payments_bound p on p.delete_date is null and p.pay_flag=0 and p.contr_id=c.contr_id
                     join oper o on o.ref=p.ref
                union all
                select /*+ ORDERED c, fb, f) */
                       c.open_date, 1 as t, fb.bound_id, f.val_date as vdat, f.kv, fb.s, fb.s_cv
                  from c
                       join cim_fantoms_bound fb on fb.delete_date is null and fb.pay_flag=0 and fb.contr_id=c.contr_id
                       join cim_fantom_payments f on f.fantom_id=fb.fantom_id ) x
                 where x.vdat between to_date('01/'||to_char(trunc(p_dat), 'mm/yyyy'), 'dd/mm/yyyy')
                                  and add_months(to_date('01/'||to_char(trunc(p_dat), 'mm/yyyy'), 'dd/mm/yyyy'), 1)
        ) y
        left outer join cim_link l on l.delete_date is null and decode(y.t, 0, l.payment_id, l.fantom_id)=y.bound_id
        left outer join cim_vmd_bound vb on vb.bound_id=l.vmd_id
        left outer join v_cim_customs_decl vv on vv.cim_id=vb.vmd_id
        left outer join cim_act_bound ab on ab.bound_id=l.act_id
        left outer join cim_acts a on a.act_id=ab.act_id
        group by y.t, y.bound_id ) q;
  return p73;
end f_cim_2c_p73;
/
 show err;
 
PROMPT *** Create  grants  F_CIM_2C_P73 ***
grant EXECUTE                                                                on F_CIM_2C_P73    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CIM_2C_P73    to CIM_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cim_2c_p73.sql =========*** End *
 PROMPT ===================================================================================== 
 