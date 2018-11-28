
begin
  delete from bars.ps_tts pt where pt.tt='PKX' and pt.nbs='2560' and dk=0;
  insert into bars.ps_tts( TT, NBS, DK, OB22) 
         (
          select 'PKX' tt, R020, 0 ,OB22 
            from sb_ob22 sb 
           where sb.r020=2560 
                 and d_close is null 
                 and OB22 <> 03
         );
  exception  
    when dup_val_on_index 
      then null;
     when others then
       if ( sqlcode = -02291 ) then
         dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2560'', ''PKX'', 0) - Foreign ���� ��������� �� ������������� ������ !');
       else raise;
       end if;
end;
/

commit;
/

