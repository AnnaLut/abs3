------------------------------------
-- MMFO
------------------------------------

begin
Insert into BARS.TMP_TTS_REGION
   (TT, NLS_TYPE, KF, NLS_STMT)
 Values
   ('CL0', 'NLSK', '0', '#(get_proc_nls(''T00'',#(KVA)))');
   exception when dup_val_on_index then null;
end;
/   

begin
Insert into BARS.TMP_TTS_REGION
   (TT, NLS_TYPE, KF, NLS_STMT)
 Values
   ('CLS', 'NLSK', '0', '#(get_proc_nls(''T00'',#(KVA)))');
   exception when dup_val_on_index then null;
end;
/   

begin
   Insert into BARS.TMP_TTS_REGION
   (TT, NLS_TYPE, KF, NLS_STMT)
 Values
   ('CLB', 'NLSK', '0', '#(get_proc_nls(''T00'',#(KVA)))');
   exception when dup_val_on_index then null;
end;
/      
COMMIT
/
