---===============================================================================================
----
----                                    COBUMMFO-6465
----
----   1).  ������� � OP_FIELD ����� ���.��������� ��������:   S_MIN - "��� �� �����",  S_MAX - "��� �� �����"                            
----   2).  ������� ������ VOB=147 ��� �������� 470,471,472
----
---===============================================================================================
--
--  ������� ����� ���.��������� ��������:   S_MIN - "��� �� �����",  S_MAX - "��� �� �����"                            
--
Begin
  INSERT INTO OP_FIELD 
      ( TAG, NAME, 
        FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH
      )
  VALUES  
      ( 'S_MIN', '��� �� �����',  
        NULL, NULL, NULL, NULL, NULL, NULL, 'N', 0 
      ); 
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/

Begin
  INSERT INTO OP_FIELD 
      ( TAG, NAME, 
        FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH
      )
  VALUES  
      ( 'S_MAX', '��� �� �����',  
        NULL, NULL, NULL, NULL, NULL, NULL, 'N', 0 
      ); 
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/
COMMIT;

-----------------------------------------------------------------------------------------------

SET DEFINE OFF;
PROMPT  ---- �������� ������� �147 ��� �������� 470,471,472!!!
exec bc.go('/');
begin
Insert into BARS.VOB
   (VOB, NAME, FLV, REP_PREFIX)
 Values
   (147, '����� �� ��� ���+���.���', 1, 'ORDERN');
   exception when dup_val_on_index then  null;
end;
/
begin
delete from TTS_VOB where tt in('470','471','472') 
   exception when dup_val_on_index then  null;
end;
/
begin
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'TT_470', 'select tt from oper where ref=:nRecID and tt=''470''', '��� ���������� 470', 'TIC');
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'TT_471', 'select tt from oper where ref=:nRecID and tt=''471''', '��� ���������� 471', 'TIC');
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'TT_472','select tt from oper where ref=:nRecID and tt=''472''', '��� ���������� 472', 'TIC');
   Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'NLS_470','select substr(a.nls,1,14) from opldok o, accounts a where o.ref=:nRecID and o.acc=a.acc and o.tt in(''470'',''471'',''472'') order by a.nls desc', '������� � ��� TT 470,471,472', 'TIC');
   Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, MOD_CODE)
 Values
   ('DEFAULT', 'NAME_K76', 'select trim(substr(a.nms,1,50)) from opldok o, accounts a where o.ref=:nRecID and a.acc=o.acc and a.nls like ''3570%''and o.dk=0 and o.tt in(''K76'',''K70'')', 'TIC');
   exception when dup_val_on_index then  null;
end;
/
begin
Insert into BARS.TTS_VOB
   (TT, VOB, ORD)
 Values
   ('470', 147, 1);
Insert into BARS.TTS_VOB
   (TT, VOB, ORD)
 Values
   ('471', 147, 1);
Insert into BARS.TTS_VOB
   (TT, VOB, ORD)
 Values
   ('472', 147, 1);
   exception when dup_val_on_index then  null;
end;
/
COMMIT;

