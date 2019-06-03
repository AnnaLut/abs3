begin
  begin insert into F045(F045, txt, d_open) values('1', 'Гарантований кредит', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into F045(F045, txt, d_open) values('2', 'Негарантований кредит', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into F045(F045, txt, d_open) values('3', 'кредит у гривнях вiд ЇБРР, МФК, НЕФКО', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/


begin
  begin insert into F045(F045, txt, d_open) values('#', 'Розріз відсутній', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/

commit;