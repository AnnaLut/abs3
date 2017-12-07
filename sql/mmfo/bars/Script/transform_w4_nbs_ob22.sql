declare
  l_sql    varchar2(32000);
  l_new_ob varchar2(2);
begin
  for i in (select *
              from w4_nbs_ob22 unpivot(atr_vallue for attribute_name in("OB_9129",
                                                                        "OB_OVR",
                                                                        "OB_2207",
                                                                        "OB_2208",
                                                                        "OB_2209",
                                                                        "OB_3570",
                                                                        "OB_3579",
                                                                        "OB_2627",
                                                                        "OB_2625X",
                                                                        "OB_2627X",
                                                                        "OB_2625D",
                                                                        "OB_2628"))) loop
    if i.attribute_name in ('OB_2207', 'OB_2209', 'OB_3579', 'OB_3570') then
      l_sql := null;
      begin
        select t.ob_new
          into l_new_ob
          from transfer_2017 t
         where t.r020_old = substr(i.attribute_name, 4, 4)
           and t.ob_old = i.atr_vallue;
      exception
        when no_data_found then
          continue;
      end;
      l_sql := 'update w4_nbs_ob22 set '||i.attribute_name||' = '''||l_new_ob||''' where nbs = :nbs2 and ob22 = :ob222 and tip = :tip2';
      execute immediate l_sql
        using substr(i.attribute_name, 4, 4), i.ob22, i.tip;
    elsif i.tip = 'W4C' and i.attribute_name = 'OB_OVR' then
      l_sql := null;
      begin
        select t.ob_new
          into l_new_ob
          from transfer_2017 t
         where t.r020_old = '2202'
           and t.ob_old = i.atr_vallue;
      exception
        when no_data_found then
          continue;
      end;
      l_sql := 'update w4_nbs_ob22 set '||i.attribute_name||' = '''||l_new_ob||''' where nbs = :nbs2 and ob22 = :ob222 and tip = :tip2';
      execute immediate l_sql
        using substr(i.attribute_name, 4, 4), i.ob22, i.tip;
    end if;

  end loop;
end;
/
commit;