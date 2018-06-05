declare
l_id number;
begin
select FILTER_ID into l_id from BARS.DYN_FILTER where TABID = bars_metabase.get_tabid('CUSTOMER') and 
                                                      WHERE_CLAUSE = '($~~ALIAS~~$.RNK IN (Select RNK from CustomerW where TAG=''BUSSL'' and VALUE=''2''))';
dbms_output.put_line('Գ���� "������-�������� �볺��� = ����(2)" ��� ���� � ��:'||to_char(l_id));
exception when no_data_found then                                    
insert into BARS.DYN_FILTER(FILTER_ID, 
                            TABID,
                            SEMANTIC, 
                            WHERE_CLAUSE, 
                            BRANCH)
                     values(s_dyn_filter.nextval,
                            bars_metabase.get_tabid('CUSTOMER'), 
                            '������-�������� �볺��� = ����(2)', 
                            '($~~ALIAS~~$.RNK IN (Select RNK from CustomerW where TAG=''BUSSL'' and VALUE=''2''))', 
                            '/') returning FILTER_ID into l_id;
if sql%rowcount>0 then                            
dbms_output.put_line('Գ���� "������-�������� �볺��� = ����(2)" �������� � ��:'||to_char(l_id));
else
dbms_output.put_line('Գ���� "������-�������� �볺��� = ����(2)" �� ��������');
end if;
end;
/
commit;
/
declare
l_id number;
begin
select FILTER_ID into l_id from BARS.DYN_FILTER where TABID = bars_metabase.get_tabid('CUSTOMER') and 
                                                      WHERE_CLAUSE = '($~~ALIAS~~$.RNK IN (Select RNK from CustomerW where TAG=''BUSSL'' and VALUE=''1''))';
dbms_output.put_line('Գ���� "������-�������� �볺��� = ���(1)" ��� ���� � ��:'||to_char(l_id));
exception when no_data_found then
insert into BARS.DYN_FILTER(FILTER_ID, 
                            TABID,SEMANTIC, 
                            WHERE_CLAUSE, 
                            BRANCH)
                     values(s_dyn_filter.nextval,
                            bars_metabase.get_tabid('CUSTOMER'), 
                            '������-�������� �볺��� = ���(1)', 
                            '($~~ALIAS~~$.RNK IN (Select RNK from CustomerW where TAG=''BUSSL'' and VALUE=''1''))', 
                            '/') returning FILTER_ID into l_id;
if sql%rowcount>0 then                            
dbms_output.put_line('Գ���� "������-�������� �볺��� = ���(1)" �������� � ��:'||to_char(l_id));
else
dbms_output.put_line('Գ���� "������-�������� �볺��� = ���(1)" �� ��������');
end if;
end;
/
commit;
/
declare
l_id number;
begin
select FILTER_ID into l_id from BARS.DYN_FILTER where TABID = bars_metabase.get_tabid('CUSTOMER') and 
                                                      WHERE_CLAUSE = '($~~ALIAS~~$.RNK NOT IN (Select RNK from CustomerW where TAG=''BUSSL''))';
dbms_output.put_line('Գ���� "������-�������� �볺��� = �� ������������" ��� ���� � ��:'||to_char(l_id));
exception when no_data_found then
insert into BARS.DYN_FILTER(FILTER_ID, 
                            TABID,SEMANTIC, 
                            WHERE_CLAUSE, 
                            BRANCH)
                     values(s_dyn_filter.nextval,
                            bars_metabase.get_tabid('CUSTOMER'), 
                            '������-�������� �볺��� = �� ������������', 
                            '($~~ALIAS~~$.RNK NOT IN (Select RNK from CustomerW where TAG=''BUSSL''))', 
                            '/') returning FILTER_ID into l_id;
if sql%rowcount>0 then                            
dbms_output.put_line('Գ���� "������-�������� �볺��� = �� ������������" �������� � ��:'||to_char(l_id));
else
dbms_output.put_line('Գ���� "������-�������� �볺��� = �� ������������" �� ��������');
end if;
end;
/
commit;
/                            