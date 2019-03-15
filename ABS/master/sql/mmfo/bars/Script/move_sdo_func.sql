declare
   l_codeoper number;
begin 

   select codeoper
     into l_codeoper
     from operlist
    where name = '���: ����������� ������ ��� ����������' ;

   for c in ( select codeapp
                from operapp oa
               where codeoper = l_codeoper
             ) loop

            umu.remove_func_from_arm(
                 p_func_id   => l_codeoper,
                 p_arm_code  => c.codeapp ,
                 p_approve   => 1) ;
   end loop;   
   
    -- �������� �������� ���
   umu.add_func2arm(l_codeoper, '$RM_VIZA', 1 );        -- '��� ��������� �������� (���)'

exception when no_data_found then null;
end;
/
commit;