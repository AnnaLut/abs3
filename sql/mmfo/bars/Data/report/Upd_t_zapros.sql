begin
update zapros z
set z.bindvars = ':sFdat1='''',:sFdat2='''',:corporation_id=''� ����������'',:okpo=''������'',:nbs=''�/�(��i-%)'',:kod_analyt=''��� ����������� �����(��i-%)'',:SRT=''����������(������/��� ��������)'',:in_trkk=''� ����� ����''',
z.bind_sql = ':corporation_id=''V_ROOT_CORPORATION|EXTERNAL_ID|CORPORATION_NAME|ORDER BY ID'''
where z.kodz in (select substr (r.param, 1, instr (r.param, ',')-1) from reports r where r.id = 5050);
dbms_output.put_line(' Updated: '||sql%rowcount);
commit;
exception when others then
raise;
end;
/
