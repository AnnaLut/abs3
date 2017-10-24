create or replace view v_crca_pays as
select id_compen,
          idm,
          sumop / 100 sumop,
          ost / 100 ost,
          zpr / 100 zpr,
          datp,
          prea,
          oi,
          ol,
          dk,
          datl,
          typo,
          mark,
          ver,
          stat,
          (select txt from compen_asvotypo where cm.typo=typo) txt,
          null ref,
          null id_compen_bound,
          null user_login,
          null msg,
          null user_login_viza,
          null user_visa_date
     from compen_motions cm
union all
select o.compen_id,
          null,
          o.amount / 100,
          null,
          null,
          o.changedate,
          null,
          null,
          null,
          null,
          o.regdate,
          t.oper_code,
          null,
          null,
          s.state_name,
          t.text,
          nvl(o.ref_id, pr.ref_oper),
          o.compen_bound,
          (select t.logname from staff$base t where t.id = o.user_id),
          o.msg,
          (select t.logname from staff$base t where t.id = o.visa_user_id), 
          o.visa_date 
  from compen_oper o
  join compen_oper_types t on (o.oper_type = t.type_id)
  join compen_oper_states s on (o.state = s.state_id)
  left join compen_payments_registry pr on (pr.reg_id = o.reg_id)
order by datl desc, datp desc, ver desc;

  GRANT SELECT ON v_crca_pays TO BARS_ACCESS_DEFROLE;