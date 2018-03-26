begin
  dbms_scheduler.drop_job(job_name =>'RUN_FORMATED_XML');
  dbms_scheduler.drop_program(program_name => 'RUN_FORMATED_XML_OBJECTS');
   exception 
   when others then
     if sqlcode=-27475 then null;
        end if;
end;

/
begin                            
 dbms_scheduler.create_program(program_name=> 'RUN_FORMATED_XML_OBJECTS',
                                               program_type        => 'STORED_PROCEDURE',
                                               program_action      =>' bars.nbu_601_formed_xml.run_formated_xml_job',
                                               number_of_arguments => 2,
                                               enabled             => false,
                                               comments            => 'Запрос на запуск отправки даних на ЦА');
        
 dbms_scheduler.define_program_argument(program_name    =>'RUN_FORMATED_XML_OBJECTS',
                                               argument_position => 1,
                                               argument_name     => 'p_kf',
                                               argument_type     => 'varchar2');
                                               
 dbms_scheduler.define_program_argument(program_name    =>'RUN_FORMATED_XML_OBJECTS',
                                               argument_position => 2,
                                               argument_name     => 'p_user_id',
                                               argument_type     => 'number');                                              
 

        
 sys.dbms_scheduler.enable(name => 'RUN_FORMATED_XML_OBJECTS');      
exception when others then 
  if sqlcode=-955 then null;
  end if;
end;
/