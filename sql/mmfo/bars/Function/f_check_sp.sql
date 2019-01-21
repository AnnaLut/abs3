
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_sp.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE FUNCTION f_check_sp(
 p_nbs        VARCHAR2,
 p_spid       VARCHAR2,
 p_val        VARCHAR2
)
RETURN NUMBER IS
res          NUMBER;
sql_str      varchar2(1000);
p_nsiname    sparam_list.nsiname%type;
p_tabcolumn_check  sparam_list.tabcolumn_check%type;
BEGIN
   res := 0;

   select nsiname, tabcolumn_check into p_nsiname, p_tabcolumn_check from sparam_list where spid=p_spid;

   if p_nsiname is null or p_tabcolumn_check is null or p_val is null
   then
   		res := 1;
   		return res;
   end if;
   --- check IFRS,SPPI parameters
  if (p_nsiname in('IFRS','SPPI')) then 
       if p_nsiname ='IFRS' then
          p_tabcolumn_check:='IFRS_ID';
       elsif p_nsiname ='SPPI' then
             p_tabcolumn_check:='SPPI_ID';
       end if; 
       sql_str := 'select count(*) from ' || p_nsiname || ' where ' || p_tabcolumn_check || '=:val';
     begin
     if instr(sql_str,':NBS') > 0 then
       execute immediate sql_str into res using p_val, p_nbs;
     else
       execute immediate sql_str into res using p_val;
     end if;
     exception when no_data_found then res := 0;
     end;
   ----- check IFRS,SPPI parameters
  else
  
   sql_str := 'select count(*) from ' || p_nsiname || ' where ' || p_tabcolumn_check || '=:val';
   begin
     if instr(sql_str,':NBS') > 0 then
       execute immediate sql_str into res using p_val, p_nbs;
     else
       execute immediate sql_str into res using p_val;
     end if;
   exception when no_data_found then res := 0;
   end;
  end if ;

   RETURN res;
END f_check_sp;
/
 show err;
 
PROMPT *** Create  grants  F_CHECK_SP ***
grant EXECUTE                                                                on F_CHECK_SP      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CHECK_SP      to WR_VIEWACC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_sp.sql =========*** End ***
 PROMPT ===================================================================================== 
 