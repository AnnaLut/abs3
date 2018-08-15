PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/data/fill_table/ins_attrs.sql ==========*** Run ***
PROMPT ===================================================================================== 

  merge into bars.ins_attrs a
       using (select 'EXT_SYSTEM' as id, 'Договір із зовнішньої системи' as name, 'S' type_id from dual
              union all 
              select 'ANY_DATA' as id, 'Текст договору довільного об`єкта страхування' as name, 'S' type_id from dual
              ) t
          on (a.id = t.id)
  when not matched then
     insert (id, name)
     values (t.id, t.name)
  when matched then
     update set a.name    = t.name,
                a.type_id = t.type_id;

  commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/data/fill_table/ins_attrs.sql ==========*** End ***
PROMPT ===================================================================================== 
