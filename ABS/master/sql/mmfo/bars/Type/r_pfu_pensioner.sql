
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/r_pfu_pensioner.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.R_PFU_PENSIONER as object (
  kf            varchar2(6),
  branch        varchar2(30),
  rnk           number(38),
  nmk           varchar2(70),
  okpo          varchar2(14),
  adr           varchar2(70),
  date_on       date,
  date_off      date,
  passp         integer,
  ser           varchar2(10),
  numdoc        varchar2(20),
  pdate         date,
  organ         varchar2(70),
  bday          date,
  bplace        varchar2(70),
  cellphone     varchar2(20),
  last_idupd    number,
  last_chgdate  date
)
/

 show err;
 
PROMPT *** Create  grants  R_PFU_PENSIONER ***
grant EXECUTE                                                                on R_PFU_PENSIONER to PFU;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/r_pfu_pensioner.sql =========*** End **
 PROMPT ===================================================================================== 
 