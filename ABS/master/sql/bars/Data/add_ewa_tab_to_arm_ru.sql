declare

procedure l_add_reference2arm(p_tabname meta_tables.tabname%type, p_application_code applist.CODEAPP%type, p_acode number, p_APPROVE number) is 
l_tabid       meta_tables.tabid%type;
l_is_ex          number;
l_arm_name    applist.name%type;
l_tab_sem     meta_tables.semantic%type;
type t_acc_codes  is table of varchar2(10) index by pls_integer;
l_acc_codes t_acc_codes;
begin

l_tabid := bars_metabase.get_tabid(p_tabname);

l_acc_codes(1):='RO';
l_acc_codes(2):='RW';

select count(*) into l_is_ex from REFAPP where codeapp = p_application_code and tabid =l_tabid;

begin
select name into l_arm_name from applist where CODEAPP = p_application_code;
exception when no_data_found then 
dbms_output.put_line('АРМ "'||p_application_code||'" не існує');
return;
end;

begin
select semantic into l_tab_sem from meta_tables where tabid = l_tabid;
exception when no_data_found then 
dbms_output.put_line('Довідник "'||p_tabname||'" не існує');
return;
end;

if l_is_ex = 0 then 

insert into  bars.REFAPP (  TABID, CODEAPP,  ACODE,  APPROVE ) values (l_tabid, p_application_code, l_acc_codes(p_acode), p_APPROVE);
dbms_output.put_line('Довідник "'||l_tab_sem||'" додано до АРМу "'||l_arm_name||'"');

else

update bars.REFAPP q set
q.ACODE = l_acc_codes(p_acode),
q.APPROVE = p_APPROVE
where q.codeapp = p_application_code
and q.tabid =l_tabid;
dbms_output.put_line('Довідник "'||l_tab_sem||'" оновлено в АРМі "'||l_arm_name||'"');

end if;

end;

begin

l_add_reference2arm('INS_EWA_PURP_MVAL','WIAU',2,1);
l_add_reference2arm('INS_EWA_PURP_M','WIAU',2,1);
l_add_reference2arm('INS_EWA_PURP_MASK','WIAU',1,1);
l_add_reference2arm('INS_EWA_PURP','WIAU',2,1);
l_add_reference2arm('INS_EWA_PART_OKPO','WIAU',2,1);
l_add_reference2arm('INS_EWA_PROD_PACK','WIAU',2,1);
l_add_reference2arm('INS_EWA_DOCUMENT_TYPES','WIAU',2,1);

l_add_reference2arm('INS_EWA_PURP_MVAL','WIAF',2,1);
l_add_reference2arm('INS_EWA_PURP_M','WIAF',2,1);
l_add_reference2arm('INS_EWA_PURP_MASK','WIAF',1,1);
l_add_reference2arm('INS_EWA_PURP','WIAF',2,1);
l_add_reference2arm('INS_EWA_PART_OKPO','WIAF',2,1);
l_add_reference2arm('INS_EWA_PROD_PACK','WIAF',2,1);
l_add_reference2arm('INS_EWA_DOCUMENT_TYPES','WIAU',2,1);

COMMIT;
end;
/