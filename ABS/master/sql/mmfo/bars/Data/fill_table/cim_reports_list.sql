begin
insert into cim_reports_list(report_id,
                             name,
                             proc,
                             template,
                             file_type,
                             file_name,
                             use_in_tvbv)
      values(15,
             'Відсутні документи в банку для вал.нагляду',
             null,
             'contracts_vmd_without_doc.frx',
             'excel',
             'contracts_vmd_without_doc.xlsx',
             1);
exception when dup_val_on_index then 
  null;
end;
/


commit;