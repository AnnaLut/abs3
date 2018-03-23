create or replace view v_swi_mti_list as
select "NUM","ID","NAME","DESCRIPTION","OB22_2909","OB22_2809","OB22_KOM","CDOG","DDOG","KOD_NBU" from SWI_MTI_LIST t;

grant SELECT                                                on v_swi_mti_list    to BARS_ACCESS_DEFROLE;
