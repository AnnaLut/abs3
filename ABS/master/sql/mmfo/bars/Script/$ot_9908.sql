--------------------------------------------------------------------------
-- 
--                         COBUMMFO-9908
--
--------------------------------------------------------------------------



begin
  for k in ( Select tt 
             From   TTS 
             Where  TT in ('00C','064','065','066','067','405','408') 
           )
  Loop

    BEGIN
      update op_rules set VAL = '������� ��.������ � ������ ������' where TT = k.tt and TAG = 'PASP ';
    EXCEPTION WHEN OTHERS then
      null;
    END;

  End Loop;

end;
/

commit;



