create or replace force view V_NOT_EXISTS_BRANCH_CUR 
(branch,
 name,
 date_opened)
as
SELECT branch, name , date_opened
  FROM branch
 WHERE     date_closed IS NULL
       AND branch NOT IN (SELECT branch
                            FROM cur_rates$base
                           WHERE vdate = NVL(TO_DATE (
                                            pul.get_mas_ini_val (
                                               'sFdat1'),
                                            'dd.mm.yyyy'),
                                         gl.bd))
                           and branch <> '/';
                          
grant select on v_not_exists_branch_cur to bars_access_defrole;