set define off;

--  prompt -- Скрипт загрузки ресурсов АРМа NLKW

begin
  insert into applist (codeapp, name, frontend)
  values ('NLKW', 'АРМ Картотека рахунків WEB', 1);
exception when dup_val_on_index then
  update applist
     set name = 'АРМ Картотека рахунків WEB',
         frontend = 1
   where codeapp = 'NLKW';
end;
/

commit;


declare

  l_id number;
l_id_1 number;
l_id_2 number;
l_id_3 number;
l_id_4 number;
  
 procedure func2arm(p_func_id in number) is
  begin
    insert into operapp (codeapp, codeoper, approve)
    values ('NLKW', p_func_id, 1);
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
    p_runable in number) return number
  is
   l_id number;
  begin
  
    select codeoper into l_id from operlist where funcname = p_fname and rownum = 1;
    return l_id;
    
  exception when no_data_found then
  
    select OperListNextId into l_id from dual;
  
    insert into operlist
      (codeoper, name, dlgname, funcname, semantic, runable, rolename, frontend, usearc)
    values
      (l_id, p_ftext, 'N/A', p_fname , '', p_runable, 'START1', 1, 0);    
      
    return l_id;  
   
  end;
  



begin 


 DELETE from operlist_deps WHERE id_child = id_parent;
 commit; 
 
  l_id := add_func('/barsroot/barsweb/dynform.aspx?form=frm_per_excess_cash_atm', 'Картотека рах. надлишки готівки, які не отримані з ПТКС 2924/07(NLY)', 1);
  func2arm(l_id);

   
  l_id_1 := add_func('/barsroot/documentview/default.aspx?ref=\S+',' ',3);
  add2deps (l_id, l_id_1); 
  
  
  l_id_2 := add_func('/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',' ',1);
  add2deps (l_id, l_id_2); 
  
   l_id_3 := add_func('/barsroot/docinput/docinput.aspx?\S*',' ',1);
  add2deps (l_id, l_id_3); 
  
   l_id_4 := add_func('/barsroot/tools/nlk/kartoteka_hist.aspx?\S*',' ',1);
  add2deps (l_id, l_id_4); 
    


end;  
/
commit;

