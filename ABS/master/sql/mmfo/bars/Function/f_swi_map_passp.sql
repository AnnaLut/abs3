
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_swi_map_passp.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SWI_MAP_PASSP (p_doc_name varchar2)  return varchar2 is
/* Приведение произвольного типа документа к допустимым через таблицу мапинга swi_passp_map */
 l_name     passp.name%type;
 l_passp_id passp.passp%type := 99;
begin
 -- проверяем сначала в общем справочнике
 begin
    select passp into l_passp_id from passp where upper(name) = trim(upper(p_doc_name));
 exception when no_data_found then
 	begin
 		-- если не нашли, ищем в таблице мапинга
		 begin
		    select map_passp_id into l_passp_id from swi_passp_map where upper(doc_name) = trim(upper(p_doc_name));
		 exception when no_data_found then l_passp_id := 99;
		 end;
 	end;
 end;
 select name into l_name from passp where passp = l_passp_id;
 return l_name;
end;
/
 show err;
 
PROMPT *** Create  grants  F_SWI_MAP_PASSP ***
grant EXECUTE                                                                on F_SWI_MAP_PASSP to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_swi_map_passp.sql =========*** En
 PROMPT ===================================================================================== 
 