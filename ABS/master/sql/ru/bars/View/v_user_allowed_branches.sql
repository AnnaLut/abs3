-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 12.03.2017
-- ======================================================================================
-- create view V_USER_ALLOWED_BRANCHES
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_USER_ALLOWED_BRANCHES
prompt -- ======================================================

create or replace view BARS.V_USER_ALLOWED_BRANCHES
( BRANCH
) as
select BRANCH
  from branch
 where branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
   and DATE_CLOSED Is Null
 minus
select BRANCH
  from ( select BRANCH
           from VIP_MGR_USR_LST
          minus
         select BRANCH
           from STAFF$BASE ul
          where ID = USER_ID()
       )
;

/*
select t1.BRANCH
  from ( select BRANCH
           from BRANCH
          where BRANCH LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
            and DATE_CLOSED Is Null
       ) t1
  left
  join ( select BRANCH
           from ( select bl.BRANCH
                    from VIP_MGR_USR_LST bl
                    left
                    join STAFF$BASE ul
                      on ( ul.BRANCH = bl.BRANCH and ul.ID = USER_ID() )
                   where ul.BRANCH Is Null
                )
       ) t2
    on ( t2.BRANCH = t1.BRANCH )
 where t2.BRANCH Is Null
*/

show errors

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.V_USER_ALLOWED_BRANCHES IS 'Дозволенні користувачу бранчі';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.V_USER_ALLOWED_BRANCHES TO START1;
GRANT SELECT ON BARS.V_USER_ALLOWED_BRANCHES TO BARS_ACCESS_DEFROLE;
