prompt Создаем параметры - имена технических пользователей СБОНа для регионов ММФО (без Луганска)
begin
    branch_attribute_utl.add_new_attribute(p_attr_code => 'STO_USER', p_attr_desc => 'Logname користувача СБОН для регіону');

    branch_attribute_utl.set_attribute_value(p_branch_code     => '/300465/',
                                             p_attribute_code  => 'STO_USER',
                                             p_attribute_value => 'SBON01');
    branch_attribute_utl.set_attribute_value(p_branch_code     => '/322669/',
                                             p_attribute_code  => 'STO_USER',
                                             p_attribute_value => 'SBON01');
    branch_attribute_utl.set_attribute_value(p_branch_code     => '/324805/',
                                             p_attribute_code  => 'STO_USER',
                                             p_attribute_value => 'SBON01');
    branch_attribute_utl.set_attribute_value(p_branch_code     => '/351823/',
                                             p_attribute_code  => 'STO_USER',
                                             p_attribute_value => 'SBON01');
    begin
    branch_attribute_utl.set_attribute_value(p_branch_code     => '/304665/',
                                             p_attribute_code  => 'STO_USER',
                                             p_attribute_value => 'SBON01');
    exception
        when others then
            dbms_output.put_line('ERROR: '||sqlerrm);
    end;
commit;
end;
/
