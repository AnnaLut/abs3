begin
insert into cim_report_params(report_id,
                              param_id,
                              name,
                              type_id,
                              param_name,
                              default_value,
                              required)
      values(15,
             0,
             'Дата з',
             'Date',
             'p_fdat1',
             'bankdate',
             1);
exception when dup_val_on_index then 
  null;
end;
/
begin
insert into cim_report_params(report_id,
                              param_id,
                              name,
                              type_id,
                              param_name,
                              default_value,
                              required)
      values(15,
             1,
             'Дата по',
             'Date',
             'p_fdat2',
             'bankdate',
             1);
exception when dup_val_on_index then 
  null;
end;
/


commit;