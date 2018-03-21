begin                            
 dbms_scheduler.create_program(program_name=> 'RUN_FORMATED_XML_OBJECTS',
                                               program_type        => 'STORED_PROCEDURE',
                                               program_action      =>' bars.nbu_601_formed_xml.run_formated_xml_job',
                                               number_of_arguments => 1,
                                               enabled             => false,
                                               comments            => 'Запрос на запуск отправки даних на ЦА');
        
 dbms_scheduler.define_program_argument(program_name    =>'RUN_FORMATED_XML_OBJECTS',
                                               argument_position => 1,
                                               argument_name     => 'p_kf',
                                               argument_type     => 'varchar2');
 

        
 sys.dbms_scheduler.enable(name => 'RUN_FORMATED_XML_OBJECTS');      
exception when others then 
  if sqlcode=-955 then null;
  end if;
end;
/