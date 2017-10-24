create or replace view bars.v_tmp_static_layout_detail_a
as
  select v.id,
            v.nd,
            v.kv,
            v.branch,
            v.branch_name,
            v.nls_a,
            v.nama,
            v.okpoa,
            v.mfob,
            v.mfob_name,
            v.nls_b,
            v.namb,
            v.okpob,
            v.percent,
            v.summ_a / 100 as summ_a,
            v.summ_b / 100 as summ_b,
            v.delta / 100 delta,
            v.tt,
            v.vob,
            nvl (m.nazn, v.nazn) nazn,
            v.ref,
            v.nls_count,
            m.ord,
            v.userid
       from bars.tmp_dynamic_layout_detail v, mf1 m
      where v.userid = bars.user_id and v.nls_count = m.grp and v.id = m.id
   order by m.ord;
/
grant select on bars.v_tmp_static_layout_detail_a to bars_access_defrole;
/