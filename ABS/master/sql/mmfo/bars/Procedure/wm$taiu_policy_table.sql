

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/WM$TAIU_POLICY_TABLE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure WM$TAIU_POLICY_TABLE ***

  CREATE OR REPLACE PROCEDURE BARS.WM$TAIU_POLICY_TABLE 
                      ( N$TABLE_NAME VARCHAR2, O$TABLE_NAME VARCHAR2, N$SELECT_POLICY VARCHAR2, O$SELECT_POLICY VARCHAR2, N$INSERT_POLICY VARCHAR2, O$INSERT_POLICY VARCHAR2, N$UPDATE_POLICY VARCHAR2, O$UPDATE_POLICY VARCHAR2, N$DELETE_POLICY VARCHAR2, O$DELETE_POLICY VARCHAR2, N$REPL_TYPE VARCHAR2, O$REPL_TYPE VARCHAR2, N$POLICY_GROUP VARCHAR2, O$POLICY_GROUP VARCHAR2, N$OWNER VARCHAR2, O$OWNER VARCHAR2, N$POLICY_COMMENT VARCHAR2, O$POLICY_COMMENT VARCHAR2, N$CHANGE_TIME DATE, O$CHANGE_TIME DATE, N$APPLY_TIME DATE, O$APPLY_TIME DATE, N$WHO_ALTER VARCHAR2, O$WHO_ALTER VARCHAR2, N$WHO_CHANGE VARCHAR2, O$WHO_CHANGE VARCHAR2, N$ROWID rowid, O$ROWID rowid)  is 
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
           if (updating('SELECT_POLICY') or updating('INSERT_POLICY') or updating('UPDATE_POLICY') or updating('DELETE_POLICY')) then
             begin
    check_policy_list(N$select_policy);
    check_policy_list(N$insert_policy);
    check_policy_list(N$update_policy);
    check_policy_list(N$delete_policy);
end;
           end if;
         end; 
       end;
 
/
show err;

PROMPT *** Create  grants  WM$TAIU_POLICY_TABLE ***
grant EXECUTE                                                                on WM$TAIU_POLICY_TABLE to WMSYS;
grant EXECUTE                                                                on WM$TAIU_POLICY_TABLE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/WM$TAIU_POLICY_TABLE.sql =========
PROMPT ===================================================================================== 
