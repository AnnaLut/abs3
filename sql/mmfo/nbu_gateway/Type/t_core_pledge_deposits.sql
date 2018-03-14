create or replace type t_core_pledge_deposit force as object
(
       numDogDp  varchar2(50),
       dogDayDp  date,
       r030Dp    varchar2(3),
       sumDp     number(32)
);
/
create or replace type t_core_pledge_deposits force is table of t_core_pledge_deposit;
/
