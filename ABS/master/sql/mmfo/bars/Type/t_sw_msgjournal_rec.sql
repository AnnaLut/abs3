
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_sw_msgjournal_rec.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_SW_MSGJOURNAL_REC is object(
    msg_trn               varchar2(16),
    msg_customer_name     varchar2(35),
    msg_customer_accnum   varchar2(35),
    msg_amount            number(20),
    msg_currency          number(3),
    msg_beneficiary_name  varchar2(35),
    msg_beneficiary_bank  varchar2(35),
    msg_value_date        date,
    msg_receiver          varchar2(35),
    msg_out_date          date,
    num                   number );
/

 show err;
 
PROMPT *** Create  grants  T_SW_MSGJOURNAL_REC ***
grant EXECUTE                                                                on T_SW_MSGJOURNAL_REC to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_sw_msgjournal_rec.sql =========*** En
 PROMPT ===================================================================================== 
 