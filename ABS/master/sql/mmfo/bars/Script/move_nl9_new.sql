begin   
    operlist_adm.modify_func_by_path('/barsroot/barsweb/dynform.aspx?form=frm_nl__kart'||chr(38)||'nls_tip=nl9','/barsroot/gl/nl/index?tip=nl9'||chr(38)||'ttList=NL9');
    commit;
end;
/

begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('NL9', '310');
exception when dup_val_on_index then  null;
end;

/

begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('NL9', 'PS1');
exception when dup_val_on_index then  null;
end;
/

begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('NL9', 'PS2');
exception when dup_val_on_index then  null;
end;
/
begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('NL9', '009');
exception when dup_val_on_index then  null;
end;
/
begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('NL9', 'PKR');
exception when dup_val_on_index then  null;
end;
/
begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('NL9', 'PKS');
exception when dup_val_on_index then  null;
end;
/
begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('NL9', 'PKX');
exception when dup_val_on_index then  null;
end;
/
begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('NL9', '024');
exception when dup_val_on_index then  null;
end;
/

commit;