---- �� ������������ (����������) �� ����� ���� �� ���������� ��� ��������� (���������, ����������) 
---� ������� �������� ������� ������ ������ ���� ������ � ������ ��������� 
---�� �������� �������� ������������� ����� ������ �� 02.01.2019 �1 �� �2 (����� � 07.02.2019); COBUMMFO-10624
-- tts ������������   ���� ����������� ��������
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/scripts/upd_tts_aa.sql COBUMMFO-10624 =========*** Run ***
 PROMPT  ������������ ���� ����������� ��������
begin
  bc.go('/');
    FOR op IN (select tt from tts where tt in ('AA7','AA9','AAK','AAM','AAN','AA0','AA8')) 
     LOOP
          begin
             bars_ttsadm.set_flag_on_index ( p_tt    => op.tt,
                                              p_index =>  0,
                                              p_value => '0');
           end;
    END LOOP;
   commit;
end;
/

--staff_tts �������� �������� � ������������
 PROMPT �������� �������� � ������������
-----------------------------------------------------------------------------------

begin
 bc.go('/');
 delete from staff_tts where tt in ('AA7','AA9','AAK','AAM','AAN','AA0','AA8');
 commit;
end;
/

 -- op_rules  ��� ������� �������� ���������� �� ������ �� �����������, �� ��������������� ��� �����
PROMPT  ��� ������� �������� ���������� �� ������ �� �����������, �� ��������������� ��� �����
---------------------------------------------------------------------------------------

begin
    FOR op IN (select tt from tts where tt in ('AA3','AA5','AAB','AAC','AA4','AA6','AAE','AAL')) 
     LOOP
        FOR tags IN (select tag from op_field where tag in ('REZID'))
         LOOP
           begin
             execute immediate 'update op_rules set opt=''O'',USED4INPUT = 1 where tag = :p_tag and tt = :p_tt' using tags.tag, op.tt;
            exception when others then 
             dbms_output.put_line ('ERROR for TT='||op.tt||' TAG='||tags.tag);
           end;
        END LOOP;
    END LOOP;
    commit;
end;
/