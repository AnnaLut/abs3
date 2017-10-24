set define off;


declare

  l_id number;
l_id_1 number;
l_id_2 number;
l_id_3 number;
l_id_4 number;
l_id_5 number;
l_id_6 number;
l_id_7 number;
l_id_8 number;
l_id_9 number;  
l_id_10 number; 
l_id_11 number; 
l_id_12 number; 
l_id_13 number; 



 procedure func2arm(p_func_id in number) is
  begin
    insert into operapp (codeapp, codeoper, approve)
    values ('AVVV', p_func_id, 1);
  exception when dup_val_on_index then 
    null;
  end;  
  
    procedure add2deps(p_idpar in number, p_idchild in number) is
  begin
	  begin
		insert into operlist_deps (id_parent, id_child) values (p_idpar, p_idchild);
	  exception when dup_val_on_index then 
		null;
	  end;

  end;  
    
  function add_func(
    p_fname in varchar2, 
    p_ftext in varchar2,
    p_runable in number) return number
  is
   l_id number;
  begin
  
 l_id :=
      abs_utils.add_func (
         p_name       => p_ftext,
         p_funcname   => p_fname,
         p_rolename   => 'START1',
         p_frontend   => 0);
   
      
    return l_id;  
   
  end;
  



begin 

 DELETE from operlist_deps WHERE id_child = id_parent;
 commit; 

  l_id := add_func('FunNSIEdit("[PROC=>OP_BR_SXO(:sPar1,:sPar2)][PAR=>:sPar1(SEM=Бранч,TYPE=S,REF=V_SXO),:sPar2(SEM=Цiннiсть,TYPE=S,REF=VALUABLES)][MSG=>OK OP_BR_SXO !]")', 
                   'Автовідкриття рахунків по 1-й цінності для бранчу 2,2+3 рівня (кущ)', 1);
  func2arm(l_id);


   
  
end;  
/
commit;
 