create or replace view bars.v_edeal_nd_acc
as
   (select nd, 'ACC26' as name, acc26 as acc from e_deal$base
    union
    select nd, 'ACC36' as name, acc36 as acc from e_deal$base
    union
    select nd, 'ACCD' as name, accd as acc from e_deal$base
    union
    select nd, 'ACCP' as name, accp as acc from e_deal$base);

show errors;

grant select on bars.v_edeal_nd_acc to bars_access_defrole;
