begin
  insert into ow_trans_mask
    (mask, comm)
    select '2924%015', null
      from dual
     where not exists (select 1 from ow_trans_mask where mask = '2924%015');

  insert into ow_trans_mask
    (mask, comm)
    select '2924%016', null
      from dual
     where not exists (select 1 from ow_trans_mask where mask = '2924%016');

  insert into ow_trans_mask
    (mask, comm)
    select '2924%029', null
      from dual
     where not exists (select 1 from ow_trans_mask where mask = '2924%029');

  insert into ow_trans_mask
    (mask, comm)
    select '2920%001', null
      from dual
     where not exists (select 1 from ow_trans_mask where mask = '2920%001');

  insert into ow_trans_mask
    (mask, comm)
    select '2920%002', null
      from dual
     where not exists (select 1 from ow_trans_mask where mask = '2920%002');
commit;
end;
/

