PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/data/fill_table/ins_object_types.sql ==========*** Run ***
PROMPT ===================================================================================== 

  merge into bars.ins_object_types ot
       using (select 'CL' as id, '����������' as name from dual
              union all
              select 'GRT' as id, '�������' as name from dual
              union all
              select 'ANY' as id, '�������� ��`��� �����������' as name from dual
              union all
              select 'RNK' as id, '������������ �����' as name from dual
              ) t
          on (ot.id = t.id)
  when not matched then
     insert (id, name)
     values (t.id, t.name)
  when matched then
     update set ot.name = t.name;

  commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/data/fill_table/ins_object_types.sql ==========*** End ***
PROMPT ===================================================================================== 
