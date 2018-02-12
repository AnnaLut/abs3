prompt Устанавливаем значение кода блокировки ФМ в 98
begin
    branch_attribute_utl.set_attribute_value(p_branch_code     => '/',
                                             p_attribute_code  => 'FM_BLK',
                                             p_attribute_value => '98');

commit;
end;
/
