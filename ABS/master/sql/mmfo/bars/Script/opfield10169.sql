update op_field set name = 'SWT.33B Валюта/Сума(для типу BEN)' where tag='33B';
update op_field set name = 'SWT.52A Банк відправника' where tag='52A';
update op_field set name = 'SWT.56D Банк посеред(без BIC-коду)' where tag='56D';
update op_field set name = 'SWT.56A Банк посеред(є BIC-код)' where tag='56A';
update op_field set name = 'SWT.57A Банк отримув(є BIC-код)' where tag='57A';
update op_field set name = 'SWT.57D Банк отримув(без BIC-коду)' where tag='57D';
update op_field set name = 'SWT.59 Отримувач(Бенефіціар)' where tag='59';
update op_field set name = 'SWT.70 Призначення переказу' where tag='70';
update op_field set name = 'SWT.77B Рекв.для звітн(іноз.банків)' where tag='77B';
delete from op_rules where tag in ('23E','23B','26T','32A','36','50K','50A','51A','52D','53B','53D','53A','54A','54D','54B','55B','55A','55D','56C','57B','57C','59A','71G','72')
and  tt in ( 'CVB', 'CVO', 'CVS','CFO', 'CFS', 'CFB');
/
commit; 


update op_rules set opt='O' 
where tt in ('CVS','CFS') and tag='57A';
/
begin
Insert into BARS.OP_RULES
   (TT, TAG, OPT, USED4INPUT, ORD)
 Values
   ('CVS', '77B  ', 'O', 1, 38);
exception when dup_val_on_index then null;
end;
/
begin
Insert into BARS.OP_RULES
   (TT, TAG, OPT, USED4INPUT, ORD)
 Values
   ('CVB', '56D', 'O', 1, 19);
exception when dup_val_on_index then null;
end;
/
begin
Insert into BARS.OP_RULES
   (TT, TAG, OPT, USED4INPUT, ORD)
 Values
   ('CVB', '77B  ', 'O', 1, 38);
exception when dup_val_on_index then null;
end;
/
begin
Insert into BARS.OP_RULES
   (TT, TAG, OPT, USED4INPUT, ORD)
 Values
   ('CFS', '77B  ', 'O', 1, 38);
exception when dup_val_on_index then null;
end;   
/
begin
Insert into BARS.OP_RULES
   (TT, TAG, OPT, USED4INPUT, ORD)
 Values
   ('CFB', '77B  ', 'O', 1, 38);
exception when dup_val_on_index then null;
end;   
/
COMMIT;