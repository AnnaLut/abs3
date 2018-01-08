

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_BRANCH_TAGS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEPRICATED_BRANCH_TAGS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEPRICATED_BRANCH_TAGS ("TAG", "NAME", "NBS", "OB22") AS 
  with t  as (     -- костыли в виде двух колонок  nbs, ob22
        select ba.attribute_code tag, ba.attribute_desc name,
               case when substr(bav.attribute_value, 1, 4) = 'xxxx' then null else substr(bav.attribute_value, 1, 4) end nbs,
               case when substr(bav.attribute_value, 6, 2) = 'xx'   then null else substr(bav.attribute_value, 6, 2) end ob22
          from branch_attribute ba,
               branch_attribute_value bav
         where length(bav.attribute_value) = 7
           and substr(bav.attribute_value, 5, 1) = ':'
           and ba.attribute_code = bav.attribute_code
          )
select "TAG","NAME","NBS","OB22" from t
union
select ba.attribute_code tag, ba.attribute_desc name, null, null
  from branch_attribute ba
 where  ba.attribute_code not in (select tag from t);

PROMPT *** Create  grants  V_DEPRICATED_BRANCH_TAGS ***
grant SELECT                                                                 on V_DEPRICATED_BRANCH_TAGS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DEPRICATED_BRANCH_TAGS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DEPRICATED_BRANCH_TAGS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_BRANCH_TAGS.sql =========*
PROMPT ===================================================================================== 
