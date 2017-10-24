-- АРМ
begin
insert into applist(codeapp, name, frontend)
values ('CLB1', 'АРМ Адміністратора CorpLight',1);
exception when others then null;
end;
/

begin
insert into applist(codeapp, name, frontend)
values ('CLBO', 'АРМ Користувача БЕК офісу',1);
exception when others then null;
end;
/

commit;
/

set define off;

declare

  l_id number;
  l_child_id number;
  -- прописать связь арм <-> функция
  procedure func2arm(p_arm_name in varchar2, p_func_id in number) is
  begin
    insert into operapp (codeapp, codeoper, approve)
    values (p_arm_name, p_func_id, 1);
  exception when dup_val_on_index then 
    null;
  end;  
  
  procedure func2acspub(p_url in varchar2) is 
  begin
    insert into OPERLIST_ACSPUB (funcname, frontend)
    values (p_url, 1);
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
      (l_id, p_ftext, 'N/A', p_fname , '', p_runable, '', 1, 0);    
      
    return l_id;   
  end;
  
begin 

func2acspub('/barsroot/clientregister/registration.aspx\S*');

l_id := add_func('/barsroot/corplight/accounts/index/', 'Доступ до рахунків CorpLight', 1);
func2arm('CLB1', l_id);

l_id := add_func('/barsroot/corplight/users/index/?clmode=base', 'Підключення до CorpLight', 1);
func2arm('CLB1', l_id);
l_child_id := add_func('/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)', 'Картка контрагента', 3);
add2deps(l_id, l_child_id);
l_id := add_func('/barsroot/corplight/relatedcustomers/index?custid=\d+', 'Картка контрагента', 3);
add2deps(l_child_id, l_id);
l_id := add_func('/barsroot/corplight/relatedcustomers/index?custid=\d+&clmode=base', 'Картка контрагента', 3);
add2deps(l_child_id, l_id);
l_id := add_func('/barsroot/corplight/users/validatemobilephone\S*', 'Підключення до CorpLight', 3);
add2deps(l_child_id, l_id);
l_id := add_func('/barsroot/corplight/users/validateonetimepass\S*', 'Підключення до CorpLight', 3);
add2deps(l_child_id, l_id);

l_id := add_func('/barsroot/corplight/users/index/?clmode=base', 'Підключення до CorpLight', 1);
l_child_id := add_func('/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)*(clmode=\w+)', 'Картка контрагента', 3);
add2deps(l_id, l_child_id);
l_id := add_func('/barsroot/corplight/relatedcustomers/index?custid=\d+', 'Картка контрагента', 3);
add2deps(l_child_id, l_id);
l_id := add_func('/barsroot/corplight/relatedcustomers/index?custid=\d+&clmode=base', 'Картка контрагента', 3);
add2deps(l_child_id, l_id);
l_id := add_func('/barsroot/corplight/users/validatemobilephone\S*', 'Підключення до CorpLight', 3);
add2deps(l_child_id, l_id);
l_id := add_func('/barsroot/corplight/users/validateonetimepass\S*', 'Підключення до CorpLight', 3);
add2deps(l_child_id, l_id);

l_id := add_func('/barsroot/corplight/users/index/?clmode=visa', 'Підтвердження підключення до CorpLight', 1);
func2arm('CLBO', l_id);
l_child_id := add_func('/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)', 'Картка контрагента', 3);
add2deps(l_id, l_child_id);
l_id := add_func('/barsroot/corplight/relatedcustomers/index?custid=\d+&clmode=visa', 'Картка контрагента', 3);
add2deps(l_child_id, l_id);

l_id := add_func('/barsroot/corplight/users/index/?clmode=visa', 'Підтвердження підключення до CorpLight', 1);
l_child_id := add_func('/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)*(clmode=\w+)', 'Картка контрагента', 3);
add2deps(l_id, l_child_id);
l_id := add_func('/barsroot/corplight/relatedcustomers/index?custid=\d+&clmode=visa', 'Картка контрагента', 3);
add2deps(l_child_id, l_id);

 end;  
/
commit;
/
