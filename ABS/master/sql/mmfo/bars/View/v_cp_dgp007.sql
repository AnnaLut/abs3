CREATE OR REPLACE FORCE VIEW BARS.V_CP_DGP007 as
select * from cp_dgp_zv c where c.type_id = 7;

comment on table V_CP_DGP007 is 'Інвестиції в боргові цінні папери, окрім державних';

grant SELECT,UPDATE                                                          on V_CP_DGP007       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CP_DGP007       to CP_ROLE;
grant SELECT                                                                 on V_CP_DGP007       to START1;
