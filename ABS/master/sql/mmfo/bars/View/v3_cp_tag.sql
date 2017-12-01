PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v3_cp_tag .sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view v3_cp_tag ***
create or replace view v3_cp_tag as
select tag, name, dict_name from cp_tag where id=3;


PROMPT *** Create  grants  v3_cp_tag ***
grant SELECT on v3_cp_tag to BARS_ACCESS_DEFROLE;
grant SELECT on v3_cp_tag to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v3_cp_tag.sql =========*** End *** ==========
PROMPT ===================================================================================== 
