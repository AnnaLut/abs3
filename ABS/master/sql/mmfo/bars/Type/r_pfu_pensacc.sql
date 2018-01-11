
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/r_pfu_pensacc.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.R_PFU_PENSACC as object (
  kf            varchar2(6),
  branch        varchar2(30),
  rnk           number(38),
  acc           number(38),
  nls           varchar2(15),
  kv            number(3),
  ob22          char(2),
  daos          date,
  dapp          date,
  dazs          date,
  last_idupd    number,
  last_chgdate  date
)
/

 show err;
 
PROMPT *** Create  grants  R_PFU_PENSACC ***
grant EXECUTE                                                                on R_PFU_PENSACC   to PFU;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/r_pfu_pensacc.sql =========*** End *** 
 PROMPT ===================================================================================== 
 