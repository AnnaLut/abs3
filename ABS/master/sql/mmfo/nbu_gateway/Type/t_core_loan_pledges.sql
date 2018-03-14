create or replace type t_core_loan_pledge force as object
(
       codzastava   number(20),
       sumpledge    number(32),
       pricepledge  number(32)
);
/

create or replace type t_core_loan_pledges force is table of t_core_loan_pledge;
/
