begin
  -- видалення корплайтовських відомостей з таблиці на синхронізацію із КОРП2
  delete from zp_payroll_log lg where exists (select 1 from zp_payroll p where p.id = lg.id and p.source != 5);
  commit;
end;
/
