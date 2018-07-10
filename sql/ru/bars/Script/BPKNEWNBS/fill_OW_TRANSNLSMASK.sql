prompt ... FILL OW_TRANSNLSMASK


prompt Importing table OW_TRANSNLSMASK...
set feedback off
set define off
begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2202%'', ''ACC_OVR'', ''OB_OVR'', ''2203'', ''KSS'', ''����. #NMS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2203%'', ''ACC_OVR'', ''OB_OVR'', ''2203'', ''KSS'', ''����. #NMS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2062%'', ''ACC_OVR'', ''OB_OVR'', ''2063'', ''KSS'', ''����. #NMS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2063%'', ''ACC_OVR'', ''OB_OVR'', ''2063'', ''KSS'', ''����. #NMS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2208%'', ''ACC_2208'', ''OB_2208'', ''2208'', ''KKN'', ''�����.���.�� ����. #NMS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2068%'', ''ACC_2208'', ''OB_2208'', ''2068'', ''KKN'', ''�����.���.�� ����. #NMS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_3570%'', ''ACC_3570'', ''OB_3570'', ''3570'', ''KK0'', ''�����.���. #NMK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2628%'', ''ACC_2628'', ''OB_2628'', ''2628'', ''KDN'', ''�����.������� #NMS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2608%'', ''ACC_2628'', ''OB_2628'', ''2608'', ''KDN'', ''�����.������� #NMS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2658%'', ''ACC_2628'', ''OB_2628'', ''2658'', ''KDN'', ''�����.������� #NMS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2528%'', ''ACC_2628'', ''OB_2628'', ''2528'', ''KDN'', ''�����.������� #NMS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2548%'', ''ACC_2628'', ''OB_2628'', ''2548'', ''KDN'', ''�����.������� #NMS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2627%'', ''ACC_2627'', ''OB_2627'', ''2627'', ''KON'', ''�����.���. #NMK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2607%'', ''ACC_2627'', ''OB_2627'', ''2607'', ''KON'', ''�����.���. #NMK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2657%'', ''ACC_2627'', ''OB_2627'', ''2657'', ''KON'', ''�����.���. #NMK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2627X%'', ''ACC_2627X'', ''OB_2627X'', ''2627'', ''KXN'', ''�����.���. �� �������.��������� #NMK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2625D%'', ''ACC_2625D'', ''OB_2625D'', ''2620'', ''KW4'', ''���.��. #NMK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2207%'', ''ACC_2207'', ''OB_2207'', ''2203'', ''KSP'', ''������.������. �� ����. #NMK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2067%'', ''ACC_2207'', ''OB_2207'', ''2063'', ''KSP'', ''������.������. �� ����. #NMK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2209%'', ''ACC_2209'', ''OB_2209'', ''2208'', ''KPN'', ''������.�����.���. �� ����. #NMK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_2069%'', ''ACC_2209'', ''OB_2209'', ''2068'', ''KPN'', ''������.�����.���. �� ����. #NMK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_3579%'', ''ACC_3579'', ''OB_3579'', ''3570'', ''KK9'', ''������.�����.���.(����.) #NMK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into OW_TRANSNLSMASK (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS)
values (''NLS_9129%'', ''ACC_9129'', ''OB_9129'', ''9129'', ''KR9'', ''�������.��� #NLS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

prompt Done.;

