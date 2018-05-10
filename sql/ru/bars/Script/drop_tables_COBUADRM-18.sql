SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- drop table ADR_HOUSES
prompt -- ======================================================

begin
  execute immediate 'drop table ADR_HOUSES';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- drop table ADR_STREETS
prompt -- ======================================================

begin
  execute immediate 'drop table ADR_STREETS';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- drop table ADR_STREET_TYPES
prompt -- ======================================================

begin
  execute immediate 'drop table ADR_STREET_TYPES';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/


prompt -- ======================================================
prompt -- drop table ADR_SUBURBS
prompt -- ======================================================

begin
  execute immediate 'drop table ADR_SUBURBS';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- drop table ADR_CITY_DISTRICTS
prompt -- ======================================================

begin
  execute immediate 'drop table ADR_CITY_DISTRICTS';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- drop table SETTLEMENTS_MATCH
prompt -- ======================================================

begin
  execute immediate 'drop table SETTLEMENTS_MATCH';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- drop table STREETS_MATCH
prompt -- ======================================================

begin
  execute immediate 'drop table STREETS_MATCH';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- drop table ADR_SETTLEMENTS
prompt -- ======================================================

begin
  execute immediate 'drop table ADR_SETTLEMENTS';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- drop sequence for table ADR_CITY_DISTRICTS
prompt -- ======================================================

begin
  execute immediate 'DROP SEQUENCE BARS.S_DISTRICTS';
  dbms_output.put_line('Sequence dropped.');
exception
  when OTHERS then
    if (sqlcode = -02289)
    then dbms_output.put_line('Sequence "S_DISTRICTS" does not exist.');
    else raise;
    end if;
end;
/


prompt -- ======================================================
prompt -- drop table ADR_SETTLEMENT_TYPES
prompt -- ======================================================

begin
  execute immediate 'drop table ADR_SETTLEMENT_TYPES';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/


prompt -- ======================================================
prompt -- drop sequence for table ADR_SETTLEMENTS
prompt -- ======================================================

begin
  execute immediate 'DROP SEQUENCE BARS.S_SETTLEMENTS';
  dbms_output.put_line('Sequence dropped.');
exception
  when OTHERS then
    if (sqlcode = -02289)
    then dbms_output.put_line('Sequence "S_SETTLEMENTS" does not exist.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- drop table AREAS_MATCH
prompt -- ======================================================

begin
  execute immediate 'drop table AREAS_MATCH';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/



prompt -- ======================================================
prompt -- drop table ADR_AREAS
prompt -- ======================================================

begin
  execute immediate 'drop table ADR_AREAS';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- drop sequence for table ADR_AREAS
prompt -- ======================================================

begin
  execute immediate 'DROP SEQUENCE BARS.S_AREAS';
  dbms_output.put_line('Sequence dropped.');
exception
  when OTHERS then
    if (sqlcode = -02289)
    then dbms_output.put_line('Sequence "S_AREAS" does not exist.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- drop table REGIONS_MATCH
prompt -- ======================================================

begin
  execute immediate 'drop table REGIONS_MATCH';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/


prompt -- ======================================================
prompt -- drop table ADR_REGIONS
prompt -- ======================================================

begin
  execute immediate 'drop table ADR_REGIONS';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/


prompt -- ======================================================
prompt -- drop table ADR_PHONE_CODES
prompt -- ======================================================

begin
  execute immediate 'drop table ADR_PHONE_CODES';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if (sqlcode = -00942)
    then dbms_output.put_line('Table does not exist.');
    else raise;
    end if;
end;
/


SET FEEDBACK     ON
