begin 
   begin insert into bars.t00_stats_desc values(1, 1, 'DB', '������ ���. ������� ��-����������');         exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(2, 2, 'DB', '�������� �� �볺����� ������� �� ���/���');  exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(3, 3, 'DB', '�������� ����i� ��� ����� $A � ���/���');     exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(4, 4, 'DB', '�������� ��� ������������ ����� $A');        exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(5, 5, 'DB', '���� (��������������) ��������');            exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(6, 1, 'KR', '������ ����. ������� ��-����������');        exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(7, 2, 'KR', '����������� �������� ��������� � $A:');      exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(8, 3, 'KR', '����������� ������� ��������� $B');          exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(9, 4, 'KR', '����������� ������������� ��������� $A');    exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(10, 5,'KR', '���� (��������������) �����������');         exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(22, 1, 'OST_BLKIN', '�����');                              exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(23, 2, 'OST_BLKIN', '0');                                  exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(24, 3, 'OST_BLKOUT', '�����');                             exception when dup_val_on_index then null; end;   
   begin insert into bars.t00_stats_desc values(25, 4, 'OST_BLKOUT', '1');                                 exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(26, 5, 'OST_OTHER', '������ ����');                      exception when dup_val_on_index then null; end;
end;
/

commit;




