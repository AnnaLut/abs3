
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/function/is_suitable_lcr.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARSAQ.IS_SUITABLE_LCR (p_obj in sys.anydata, p_table_list varchar2) return number is
l_typenm     varchar2(61);
l_obj_owner  varchar2(30);
l_obj_name   varchar2(30);
l_rowlcr     sys.lcr$_row_record;
l_res        number;
begin
bars.bars_audit.trace('is_suitable_lcr():'||chr(10)||substr(f_lcr_to_char(p_obj),1,3900));
if p_obj is null then
    return 0;
else
    l_typenm := p_obj.gettypename();
    if l_typenm = 'SYS.LCR$_ROW_RECORD' then
        l_res := p_obj.getobject(l_rowlcr);
        l_obj_owner := l_rowlcr.get_object_owner();
        if l_obj_owner='BARS' then
            l_obj_name := l_rowlcr.get_object_name();
            if instr(p_table_list, ''''||l_obj_name||'''')>0 then
                return 1;
            else
                return 0;
            end if;
        else
            return 0;
        end if;
    else
        return 0;
    end if;
end if;
end is_suitable_lcr;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/function/is_suitable_lcr.sql =========*** 
 PROMPT ===================================================================================== 
 