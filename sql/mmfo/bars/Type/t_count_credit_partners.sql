
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_count_credit_partners.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_COUNT_CREDIT_PARTNERS as object(
type_id varchar2(100),
type_name varchar2(100),
partner_id number,
partner_name varchar2(100),
partner_okpo varchar2(100),
prod varchar2(100),
partner_id_mather number,
partner_name_mather varchar2(200),
cnt_crd number,
sum_crd varchar2(100),
sum_crdmathers varchar2(100),
involved varchar2(400),
ru varchar2(100),
branch_name varchar2(100));
/

 show err;
 
PROMPT *** Create  grants  T_COUNT_CREDIT_PARTNERS ***
grant EXECUTE                                                                on T_COUNT_CREDIT_PARTNERS to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_count_credit_partners.sql =========**
 PROMPT ===================================================================================== 
 