

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/VALICON.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure VALICON ***

  CREATE OR REPLACE PROCEDURE BARS.VALICON is
  n_  number;
  e_  number;
begin
  bars_audit.info('VALICON: start');
  n_ := 0;
  e_ := 0;
  for k in (select *
            from   user_constraints
            where  status='ENABLED'          and
                   validated='NOT VALIDATED' and
                   CONSTRAINT_TYPE not in ('O','S','C','P','V')
           )
  loop
    begin
      execute immediate ('alter table '||k.table_name||
                         ' modify constraint '||k.constraint_name||' enable');
      n_ := n_+1;
    exception when others then
      bars_audit.error('VALICON: error modify constraint '||k.constraint_name||' enable on table '||k.table_name);
      e_ := e_+1;
    end;
  end loop;
  bars_audit.info('VALICON: done, validated '||n_||' constraints, NOT validated '||e_||' constraints');
exception when OTHERS then
  rollback;
  bars_audit.error('VALICON: '||sqlerrm||' - '||dbms_utility.format_error_backtrace);
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/VALICON.sql =========*** End *** =
PROMPT ===================================================================================== 
