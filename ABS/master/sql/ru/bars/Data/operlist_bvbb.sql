--------------------------------------------
-- Добавить функцию в АРМ
declare
  l_id_web number;
  procedure func2arm(p_func_id in number, p_codeapp in varchar2) is
  begin
    insert into operapp (codeapp, codeoper, approve)
    values (p_codeapp, p_func_id, 1);
  exception when dup_val_on_index then 
    null;
  end;
   
  
  procedure add2deps(p_idpar in number, p_idchild in number) is
  begin
    insert into operlist_deps (id_parent, id_child) values (p_idpar, p_idchild);
  exception when dup_val_on_index then 
    null;
  end;    
 
  function add_func(
    p_fname in varchar2, 
    p_ftext in varchar2,
    p_runable in number,
    p_frontend in number) return number
  is
   l_id number;
  begin

  
    select codeoper into l_id from operlist where funcname = p_fname;
    return l_id;
    
  exception when no_data_found then
  
    select OperListNextId into l_id from dual;
  
    insert into operlist
      (codeoper, name, dlgname, funcname, semantic, runable, rolename, frontend, usearc)
    values
      (l_id, p_ftext, 'N/A', p_fname , '', p_runable, '', p_frontend, 0);    
      
    return l_id;  
   
  end;

begin 
 
l_id_web := add_func('/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_605[NSIFUNCTION]'||'[showDialogWindow=>false]', 'Ф-605.Розрахунок простроч.заборгов. за КД, в тч за пенею та 3% річних', 1,1);

func2arm(l_id_web,'WCCK');
func2arm(l_id_web,'UCCK');
 
end;  
/
commit;
/
