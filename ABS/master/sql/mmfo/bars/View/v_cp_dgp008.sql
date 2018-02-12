CREATE OR REPLACE FORCE VIEW BARS.V_CP_DGP008 as
select * from cp_dgp_zv c where c.type_id = 8;

comment on table V_CP_DGP008 is 'Інвестиції у державні цінні папери';

grant SELECT,UPDATE                                                          on V_CP_DGP008       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CP_DGP008       to CP_ROLE;
grant SELECT                                                                 on V_CP_DGP008       to START1;
