create or replace force view V_OPEN_BANKDATES
( FDAT
) as
select FDAT
  from ( select FDAT
           from FDAT
          where nvl(STAT, 0) = 0
          minus
         select DAT_NEXT_U(to_date(BRANCH_ATTRIBUTE_UTL.GET_ATTRIBUTE_VALUE('/','BANKDATE'),'mm/dd/yyyy'),-1)
           from DUAL
          where TMS_UTL.CHECK_ACCESS(sys_context('bars_context','user_mfo')) = 0
) with read only;

grant SELECT on V_OPEN_BANKDATES to BARS_ACCESS_DEFROLE;
grant SELECT on V_OPEN_BANKDATES to START1;
