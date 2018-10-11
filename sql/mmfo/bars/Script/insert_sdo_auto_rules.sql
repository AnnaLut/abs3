begin
   delete from sdo_autopay_rules_desc;
   delete from sdo_autopay_rules_fields;
   delete from sdo_autopay_rules;
end;
/

begin
  insert into sdo_autopay_rules(rule_id, rule_desc, is_active  )
  values(1, 'Внутрішні платежі в рамках ощадного банку з рахунків 26* на 26*', 1);
exception when dup_val_on_index then null;
end;
/
  

begin 
   insert into sdo_autopay_rules(rule_id, rule_desc, is_active  )
   values(2, 'Платежі на казначейство з рахунків 26*', 1);
exception when dup_val_on_index then null;
end;
/

commit;


begin
    begin insert into  sdo_autopay_rules_fields(field_id, field_dbname_copr2, field_dbname_cl, field_desc) values(1, 'substr(:nls_a,1,4)' , 'substr(:nls_a,1,4)',  'Баласовий рахунок відправника'); exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_fields(field_id, field_dbname_copr2, field_dbname_cl, field_desc) values(2, ':mfo_a'             , ':mfo_a'		,  'МФА А')                        ; exception when dup_val_on_index then null; end;        
    begin insert into  sdo_autopay_rules_fields(field_id, field_dbname_copr2, field_dbname_cl, field_desc) values(3, 'substr(:nls_b,1,4)' , 'substr(:nls_b,1,4)',  'Баласовий рахунок отрримувача'); exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_fields(field_id, field_dbname_copr2, field_dbname_cl, field_desc) values(4, ':mfo_b'             , ':mfo_b'		,  'МФО Б')                        ; exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_fields(field_id, field_dbname_copr2, field_dbname_cl, field_desc) values(5, ':s'                 , ':s'		,  'Сума(коп.)')                   ; exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_fields(field_id, field_dbname_copr2, field_dbname_cl, field_desc) values(6, ':nazn'              , ':nazn'		,  'Призначення')                  ; exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_fields(field_id, field_dbname_copr2, field_dbname_cl, field_desc) values(7, ':id_a'              , ':id_a'		,  'ЗКПО відправника')             ; exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_fields(field_id, field_dbname_copr2, field_dbname_cl, field_desc) values(8, ':id_b'              , ':id_b'		,  'ЗКПО отримувача')              ; exception when dup_val_on_index then null; end;
    commit;
exception when dup_val_on_index then null;
end;
/

                                                                                                                                                
begin
    begin insert into  sdo_autopay_rules_desc (rule_id, field_id, field_operator, rule_text) values(1, 1, 'in'              ,  '(''2600'',''2606'', ''2650'', ''2654'', ''2560'')');  exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_desc (rule_id, field_id, field_operator, rule_text) values(1, 2, 'member of'       ,  'bars.sdo_autopay.g_oschad_mfo_list');                 exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_desc (rule_id, field_id, field_operator, rule_text) values(1, 3, 'in'              ,  '(''2600'',''2606'', ''2650'', ''2654'', ''2560'')');  exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_desc (rule_id, field_id, field_operator, rule_text) values(1, 4, 'member of'       ,  'bars.sdo_autopay.g_oschad_mfo_list');                 exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_desc (rule_id, field_id, field_operator, rule_text) values(1, 5, '<='              ,  '10000');                                              exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_desc (rule_id, field_id, field_operator, rule_text) values(1, 6, 'not like in list',  'bars.sdo_autopay.G_FM_FORBIDEN_WORDS_LIST');          exception when dup_val_on_index then null; end;
	begin insert into  sdo_autopay_rules_desc (rule_id, field_id, field_operator, rule_text) values(1, 7, '='               ,  ':id_b');                                              exception when dup_val_on_index then null; end;
    
    begin insert into  sdo_autopay_rules_desc (rule_id, field_id, field_operator, rule_text) values(2, 1, 'in'              ,   '(''2600'',''2604'', ''2606'', ''2650'', ''2654'')'); exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_desc (rule_id, field_id, field_operator, rule_text) values(2, 4, 'like'            ,   '''8%''');                                            exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_desc (rule_id, field_id, field_operator, rule_text) values(2, 5, '<='              ,   '1000');                                              exception when dup_val_on_index then null; end;
    begin insert into  sdo_autopay_rules_desc (rule_id, field_id, field_operator, rule_text) values(2, 6, 'not like in list',   'bars.sdo_autopay.G_FM_FORBIDEN_WORDS_LIST');         exception when dup_val_on_index then null; end;
commit;
end;
/  