create or replace force view bars.v_e_deal_tarif_nd
(
   otm,
   id,
   name,
   dat_beg,
   dat_end,
   days,
   n_sumt,
   n_sumt1,
   e_sumt,
   e_sumt1,
   dat_lb,
   dat_le,
   s_porog,
   s_tar_por1,
   s_tar_por2
)
as
   (select nvl (n.otm, 0) as otm,
           e.id,
           e.name,
           n.dat_beg,
           n.dat_end,
           elt.rab_dni (
              greatest (n.dat_beg,
                        to_date ('01' || pul.get ('ADAT'), 'ddmmyyyy')),
              least (
                 nvl (n.dat_end,
                      last_day (to_date (pul.get ('ADAT'), 'mmyyyy'))),
                 last_day (to_date (pul.get ('ADAT'), 'mmyyyy'))))
              as days,
           n.sumt/100 as n_sumt,
           n.sumt1/100 as n_sumt1,
           e.sumt/100 as e_sumt,
           e.sumt1/100 as e_sumt1,
           n.dat_lb,
           n.dat_le,
           n.s_porog,
           n.s_tar_por1,
           n.s_tar_por2
      from e_tar_nd n, e_tarif e
     where n.id(+) = e.id and n.nd(+) = to_number (pul.get ('DEAL_ND')));

show errors;

grant select on bars.v_e_deal_tarif_nd to bars_access_defrole;
