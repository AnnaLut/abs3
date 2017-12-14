set define off;
declare
  l_id number;
  l_codeapp varchar2(6) := 'WESR'; 
 procedure func2arm(p_codeapp in varchar2,p_func_id in number) is
 begin
    insert into operapp (codeapp, codeoper, approve)
    values (p_codeapp, p_func_id, 1);
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
  
      l_id :=
      abs_utils.add_func (
         p_name       => p_ftext,
         p_funcname   => p_fname,
         p_rolename   => null,
         p_frontend   => 1);
   
      
    return l_id;  
   
  end;
  
begin 
  l_id := add_func('/barsroot/escr/PortfolioData/RefList', 
                   'ESCR:Картотека відшкодувань по енергокредитам', 1);
  func2arm(l_codeapp,l_id);
end;  
/
commit;
