declare
  l_tabid number:=get_tabid('V_OW_IIC_MSGCODE');
begin   
 Insert into BARS.REFERENCES
   (TABID, TYPE, ROLE2EDIT)
 Values
   (l_tabid, 29, 'OW');
exception when dup_val_on_index then null;
End;
/
commit;


declare
  l_tabid number:=get_tabid('V_OW_IIC_MSGCODE');
begin 
Insert into BARS.REFAPP
   (TABID, CODEAPP, ACODE, APPROVE, REVOKED, 
    GRANTOR)
 Values
   (l_tabid, '$RM_WVIP', 'RW', 1, 0, 1);
exception when dup_val_on_index then null;
end;
/
commit;

exec bpa.alter_policy_info( 'V_OW_IIC_MSGCODE', 'WHOLE' , 'M', 'M', 'M', 'M' ); 
exec bpa.alter_policy_info( 'V_OW_IIC_MSGCODE', 'FILIAL', 'M', 'M', 'M', 'M' );

commit;




