

set define off
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/200_arm_teller.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Step 2 ***
declare 
  v_num integer;
begin
  -- Call the function
  v_num := user_role_adm_ui.create_role(p_role_code => 'RTELLER',
                                        p_role_name => 'Роль Теллера');
exception
  when others then null;    
end;

/

declare 
  -- Local variables here
  v_role_id number;
  v_arm_id number;
begin
  -- Test statements here
  select sr.id 
    into v_role_id
    from staff_role sr
    where sr.role_code = 'RTELLER';
  
  select ap.id 
    into v_arm_id
    from applist ap
    where ap.codeapp  = 'TELL';
  resource_utl.set_resource_access_mode(p_grantee_type_id  => resource_utl.get_resource_type_id('STAFF_ROLE'),
                                        p_grantee_id       => v_role_id,
                                        p_resource_type_id => resource_utl.get_resource_type_id('ARM_WEB'),
                                        p_resource_id      => v_arm_id,
                                        p_access_mode_id   => 1,
                                        p_approve          => true);
end;
/

PROMPT *** Step 3 ***
declare 
  v_num number;
begin
  begin
    insert into typeref  values (70,'Налаштування АРМ "Теллер"');
  exception when others then null;
  end;
  select count(1) into v_num
    from typeref 
    where type = 70 and name like '%Тел%';
  if v_num>0 then
    insert into references (tabid, type,role2edit)
      select tabid, 70, 'BARS_ACCESS_DEFROLE'
        from meta_tables m
        where tabname like '%TELLER%'
          and not exists (select 1 from references where tabid = m.tabid)
	  and not tabname in ('V_TELLER_NEED_REQ_DICT','TELLER_USERS');
  end if;
exception
  when others then null;    
end;
/


PROMPT *** Step 4 ***
begin
  -- Test statements here
     
  for r in (select tabid from meta_tables where tabname like '%TELLER%') loop
    resource_utl.set_resource_access_mode(p_grantee_type_id => user_menu_utl.get_arm_resource_type_id(p_application_type_id => 1),
                                          p_grantee_id => user_menu_utl.get_arm_id(p_arm_code => 'TELL'),
                                          p_resource_type_id => user_menu_utl.get_reference_resource_type_id,
                                          p_resource_id => r.tabid,
                                          p_access_mode_id => 2,
                                          p_approve => true);

    resource_utl.set_resource_access_mode(p_grantee_type_id => user_menu_utl.get_arm_resource_type_id(p_application_type_id => 1),
                                          p_grantee_id => user_menu_utl.get_arm_id(p_arm_code => 'TELL'),
                                          p_resource_type_id => 5,
                                          p_resource_id => r.tabid,
                                          p_access_mode_id => 2,
                                          p_approve => true);
    

  end loop;
exception
  when others then null;    
end;
/

PROMPT *** Step 5 ***
begin
  insert into TELLER_EQUIP_USERS (EQUIP_REF,
                                  USERROLE,
                                  USERLOGIN,
                                  USERPASSW,
                                  POSITION)
  select  10,'teller','USER_L','12345678','L' from dual where not exists (select 1 from teller_equip_users where userlogin = 'USER_L');

  insert into TELLER_EQUIP_USERS (EQUIP_REF,
                                  USERROLE,
                                  USERLOGIN,
                                  USERPASSW,
                                  POSITION)
  select  10,'teller','USER_R','12345678','R' from dual where not exists (select 1 from teller_equip_users where userlogin = 'USER_R');

exception
  when others then null;    
end;
/

PROMPT *** Step 6 ***

begin
  for r in (select tabid from meta_tables where tabname in ('V_TELLER_USERS','TELLER_STATIONS','TELLER_EQUIPMENT_DICT','TELLER_OPER_DEFINE','TELLER_BOSS_ROLES','V_TELLER_C_TYPE'))
  loop
    user_menu_utl.add_reference2arm(p_reference_id => r.tabid,
                                    p_arm_code => '$RM_MAIN',
                                    p_access_mode_id => 2,
                                    p_approve => 1);
  end loop;
exception when others then null;
end;
/


PROMPT *** Step 7 ***


begin
  for r in (select tabid from meta_tables where tabname in ('TELLER_USERS'))
  loop
    user_menu_utl.remove_reference_from_arm(p_reference_id => r.tabid,
                                            p_arm_code     => '$RM_MAIN',
                                            p_approve      => 1);
    
  end loop;

  for r in (select tabid from meta_tables where tabname in ('TELLER_STAFF','TELLER_TT','TELLER_USERS'))
  loop
    bars_metabase.delete_metatables(r.tabid);
    delete from references where tabid = r.tabid;
    delete from meta_tables where tabid = r.tabid;
  end loop;

exception when others then null;
end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/200_arm_teller.sql =========*** End
PROMPT ===================================================================================== 
