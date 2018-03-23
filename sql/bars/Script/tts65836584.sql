
begin
	----------------  COBUSUPABS-6584  -------------------------


	-- 1).  ������ ������� ���� 7 �� �������� 024:


	UPDATE chklist_tts set 
	sqlval =  '( ( substr(nlsa,1,4) in (''2909'',''3739'') and substr(nlsb,1,4) in (''2620'',''2625'') or substr(nlsb,1,4) in (''2513'',''2525'',''2600'',''2602'',''2603'',''2604'',''2650'',''2650'',''2620'',''2909'') ) and mfob=300465 or mfob<>300465 ) and kv<>980  and not ( substr(nlsa,1,4) in (''2658'',''2608'',''2528'',''2518'',''2568'') and substr(nlsb,1,2) in (''25'',''26'') )'
	where  idchk=7 and TT='024' and priority=2;


	-- 2).  ������� ���� 7 �� �������� DU7:


	DELETE from chklist_tts where idchk=7  and  TT='DU7' ;

	commit;
end;
/

----------------   ������ COBUSUPABS-6583   -------------------


--  1). ���������� ���.����. ED_VN � �������� '00E':                             

begin
  insert into op_rules(TAG,     TT  , OPT, USED4INPUT, ORD, VAL , NOMODIFY)
             values   ('ED_VN','00E', 'M',  1,          0 , '0' , null    );

exception WHEN dup_val_on_index THEN 

  update op_rules set OPT='M', VAL='0' where TT='00E' and TAG='ED_VN';

end;
/

-------------------------------------------------------------

--  2). ��������� � �������� '00�' �������� '!ZP':

begin
  insert into ttsap ( ttap,   tt  , dk )
            values  ( '!ZP', '00E',  0 );
exception when dup_val_on_index then 
  null;
end;
/

--------------------------------------------------------------

-- 3). ������� �������� 00E �� ������� � ������ ��������� ������� ����.  


update tts set
  flags='1000100000000000000000000000000000010300000000000000000000000100'
where tt = '00E' ;


begin
  insert into ttsap(ttap, tt, dk)
  values ('��1', '00E', 0);
exception
  when dup_val_on_index then null;
  when others then 
    if ( sqlcode = -02291 ) then
      dbms_output.put_line('�� ������� �������� ������ (ttsap: ''��1'', ''00E'', 0) - ��������� ���� �� ������!');
    else raise;
    end if;
end;
/

-----------------------------------------------------------------

-- 4). ������. ���������� ���������� � �������� 101,D66,00E


begin
  insert into ps_tts(nbs, tt, dk, ob22)
  values ('3739', '101', 1, null);
exception
  when dup_val_on_index then null;
  when others then 
    if ( sqlcode = -02291 ) then
      dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''3739'', ''101'', 1, null) - ��������� ���� �� ������!');
    else raise;
    end if;
end;
/


begin
  insert into ps_tts(nbs, tt, dk, ob22)
  values ('2902', 'D66', 0, null);
exception
  when dup_val_on_index then null;
  when others then 
    if ( sqlcode = -02291 ) then
      dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2902'', ''D66'', 0, null) - ��������� ���� �� ������!');
    else raise;
    end if;
end;
/


begin
  insert into ps_tts(nbs, tt, dk, ob22)
  values ('2620', '00E', 0, '32');
exception
  when dup_val_on_index then null;
  when others then 
    if ( sqlcode = -02291 ) then
      dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2620'', ''00E'', 0, ''32'') - ��������� ���� �� ������!');
    else raise;
    end if;
end;
/

commit;








