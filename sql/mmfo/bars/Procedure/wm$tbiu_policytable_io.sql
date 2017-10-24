

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/WM$TBIU_POLICYTABLE_IO.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure WM$TBIU_POLICYTABLE_IO ***

  CREATE OR REPLACE PROCEDURE BARS.WM$TBIU_POLICYTABLE_IO 
                      ( N$TABLE_NAME IN OUT  VARCHAR2, O$TABLE_NAME VARCHAR2, N$SELECT_POLICY IN OUT VARCHAR2, O$SELECT_POLICY VARCHAR2, N$INSERT_POLICY IN OUT VARCHAR2, O$INSERT_POLICY VARCHAR2, N$UPDATE_POLICY IN OUT VARCHAR2, O$UPDATE_POLICY VARCHAR2, N$DELETE_POLICY IN OUT VARCHAR2, O$DELETE_POLICY VARCHAR2, N$REPL_TYPE IN OUT VARCHAR2, O$REPL_TYPE VARCHAR2, N$POLICY_GROUP IN OUT VARCHAR2, O$POLICY_GROUP VARCHAR2, N$OWNER IN OUT VARCHAR2, O$OWNER VARCHAR2, N$POLICY_COMMENT IN OUT VARCHAR2, O$POLICY_COMMENT VARCHAR2, N$CHANGE_TIME IN OUT DATE, O$CHANGE_TIME DATE, N$APPLY_TIME IN OUT DATE, O$APPLY_TIME DATE, N$WHO_ALTER IN OUT VARCHAR2, O$WHO_ALTER VARCHAR2, N$WHO_CHANGE IN OUT VARCHAR2, O$WHO_CHANGE VARCHAR2, N$ROWID rowid, O$ROWID rowid)  is 
                 function inserting return boolean is
         begin
           if (wmsys.lt_ctx_pkg.dml_flag.count=0) then return dbms_standard.inserting; end if ;
           if (wmsys.lt_ctx_pkg.dml_flag.exists('I') and wmsys.lt_ctx_pkg.dml_flag('I')=1) then return true; else return false; end if ;
         end ;

         function updating(v varchar2 default null) return boolean is
         begin
           if (wmsys.lt_ctx_pkg.dml_flag.count=0) then
             if(v is null) then return dbms_standard.updating; else return dbms_standard.updating(v); end if ;
           end if ;
           if ((wmsys.lt_ctx_pkg.triggerOpCtx!='DML') or (wmsys.lt_ctx_pkg.dml_flag.exists(nvl(v, 'U')) and wmsys.lt_ctx_pkg.dml_flag(nvl(v, 'U'))=1)) then return true; else return false; end if ;
         end ;

         function deleting return boolean is
         begin
           if (wmsys.lt_ctx_pkg.dml_flag.count=0) then return dbms_standard.deleting; end if ;
           if (wmsys.lt_ctx_pkg.dml_flag.exists('D') and wmsys.lt_ctx_pkg.dml_flag('D')=1) then return true; else return false; end if ;
         end ; 
       begin
         begin
           if (updating('OWNER') or updating('TABLE_NAME') or updating('POLICY_GROUP') or updating('SELECT_POLICY') or updating('INSERT_POLICY') or updating('UPDATE_POLICY') or updating('DELETE_POLICY')) then
             begin
  N$change_time := sysdate;
  N$who_change := substr('TERMINAL: '||sys_context('USERENV','TERMINAL')||', '||
          	       'HOST: '||sys_context('USERENV','HOST')||', '||
          	       'OS_USER: '||sys_context('USERENV','OS_USER')||', '||
          	       'IP_ADDRESS: '||sys_context('USERENV','IP_ADDRESS'),1,256);
end; 
           end if;
         end; 
       end;
 
/
show err;

PROMPT *** Create  grants  WM$TBIU_POLICYTABLE_IO ***
grant EXECUTE                                                                on WM$TBIU_POLICYTABLE_IO to WMSYS;
grant EXECUTE                                                                on WM$TBIU_POLICYTABLE_IO to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/WM$TBIU_POLICYTABLE_IO.sql =======
PROMPT ===================================================================================== 
