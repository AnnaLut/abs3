begin                            
 dbms_scheduler.create_program(program_name=> 'RUN_ALL_601_OBJECTS',
                                               program_type        => 'STORED_PROCEDURE',
                                               program_action      =>' bars.nbu_601_migrate.run_all_data_requests',
                                               number_of_arguments => 2,
                                               enabled             => false,
                                               comments            => 'Запрос на запуск всех процедур по сбору информации с РУ по 601 форме');
        
 dbms_scheduler.define_program_argument(program_name    =>'RUN_ALL_601_OBJECTS',
                                               argument_position => 1,
                                               argument_name     => 'p_report_id',
                                               argument_type     => 'integer');
 
 dbms_scheduler.define_program_argument(program_name    => 'RUN_ALL_601_OBJECTS',
                                                argument_position => 2,
                                               argument_name     => 'P_KF',
                                               argument_type     => 'varchar2');
        
 sys.dbms_scheduler.enable(name => 'RUN_ALL_601_OBJECTS');      
exception when others then 
  if sqlcode=-955 then null;
  end if;
end;
/
