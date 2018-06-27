begin
bc.go('/');
update op_field
  set default_value = 'select country from V_PER_NL_ where ref = :reqv_REF92'
  where trim(tag) = 'n';
bc.home;
end;
/
