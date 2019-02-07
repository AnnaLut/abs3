BEGIN
  DBMS_SCHEDULER.DROP_PROGRAM (program_name => 'EDS_INTG_FILL_DATA_ASINC');
exception when others then
if sqlcode = -27476 then null; else raise; end if;
END;
/
begin
dbms_scheduler.create_program
(
program_name=>'EDS_INTG_FILL_DATA_ASINC',
program_action=>'BARS.EDS_INTG.FILL_DATA',
program_type=>'STORED_PROCEDURE',
number_of_arguments=>1, 
enabled=>FALSE,
comments=> 'Программа для асинхронного формування Є-декларацій з ВЕБ') ;
exception when others then
if sqlcode = -27477 then null; else raise; end if;
end;
/
begin
dbms_scheduler.DEFINE_PROGRAM_ARGUMENT(
program_name=>'EDS_INTG_FILL_DATA_ASINC',
argument_position=>1,
argument_type=>'VARCHAR2');
end;
/
begin
dbms_scheduler.enable('EDS_INTG_FILL_DATA_ASINC');
end;
/