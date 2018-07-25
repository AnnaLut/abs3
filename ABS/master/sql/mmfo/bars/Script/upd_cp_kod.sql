begin
  bc.go(300465);
  update cp_kod set cena_start = 0.00009920123 where id = 303;
  bc.home;
  exception
    when others then
      bc.home;
      dbms_output.put_line('Не вдалося встановити значення стартовоъ цыни для ЦП 303');
end;
/
commit;