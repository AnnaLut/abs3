begin
    branch_attribute_utl.create_attribute('RIXML_PATH_OUT', 'Шлях для формування квитанцій про обробку реєстрів інсайдерів', 'C');
    branch_attribute_utl.set_attribute_value('/', 'RIXML_PATH_IN' , '\\mqclsvc-00-01\MIGRATED\INSIDERS\OPR.0001\IN\');
    branch_attribute_utl.set_attribute_value('/', 'RIXML_PATH_OUT', '\\mqclsvc-00-01\MIGRATED\INSIDERS\OPR.0001\OUT\');
    branch_attribute_utl.set_attribute_value('/', 'RIXML_PATH_ARC', '\\oschadbank.ua\dfs\AppSys\MMFO\Exchange\bars\RI\300465\arc\');

    branch_attribute_utl.set_attribute_value('/300465/', 'RIXML_PATH_IN', '');
    branch_attribute_utl.set_attribute_value('/322669/', 'RIXML_PATH_IN', '');
    branch_attribute_utl.set_attribute_value('/324805/', 'RIXML_PATH_IN', '');

    branch_attribute_utl.set_attribute_value('/300465/', 'RIXML_PATH_OUT', '');
    branch_attribute_utl.set_attribute_value('/322669/', 'RIXML_PATH_OUT', '');
    branch_attribute_utl.set_attribute_value('/324805/', 'RIXML_PATH_OUT', '');

    branch_attribute_utl.set_attribute_value('/300465/', 'RIXML_PATH_ARC', '');
    branch_attribute_utl.set_attribute_value('/322669/', 'RIXML_PATH_ARC', '');
    branch_attribute_utl.set_attribute_value('/324805/', 'RIXML_PATH_ARC', '');
 
    update tms_task t
    set    t.branch_processing_mode = 1,
           t.task_statement = 'begin tms_webservices.load_insiders(); end;'
    where  t.task_code = '14';

    commit;
end;
/

