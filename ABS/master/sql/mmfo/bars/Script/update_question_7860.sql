
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_QUESTION.sql =========**
PROMPT ===================================================================================== 

Begin
   update FIN_QUESTION
      set name = '���� ������������� ����� ����� � 2 (2-�, 2-��) ���� ��� �������� ���������� (����� 2000) �� �������� ������ �� ���� ��������� ������',
	  descript = '���� ������������� ����� ����� � 2 (2-�, 2-��) ���� ��� �������� ���������� (����� 2000) �� �������� ������ �� ���� ��������� ������'
    where kod = 'PD20'
      and idf = 53;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_QUESTION.sql =========**
PROMPT ===================================================================================== 