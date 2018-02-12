begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS add constraint FK_CUSTOMERADR_HOUSES foreign key (HOUSE_ID) REFERENCES ADR_HOUSES (HOUSE_ID)]';
  dbms_output.put_line('Foreign key "FK_CUSTOMERADR_HOUSES" created.');
exception
  when OTHERS then
    if (sqlcode = -02275)
    then dbms_output.put_line('Such a referential constraint already exists in the table.');
    else raise;
    end if;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS add constraint FK_CUSTOMERADR_REGIONS foreign key (REGION_ID) REFERENCES ADR_REGIONS (REGION_ID)]';
  dbms_output.put_line('Foreign key "FK_CUSTOMERADR_REGIONS" created.');
exception
  when OTHERS then
    if (sqlcode = -02275)
    then dbms_output.put_line('Such a referential constraint already exists in the table.');
    else raise;
    end if;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS add constraint FK_CUSTOMERADR_AREAS foreign key (AREA_ID) REFERENCES ADR_AREAS (AREA_ID)]';
  dbms_output.put_line('Foreign key "FK_CUSTOMERADR_AREAS" created.');
exception
  when OTHERS then
    if (sqlcode = -02275)
    then dbms_output.put_line('Such a referential constraint already exists in the table.');
    else raise;
    end if;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS add constraint FK_CUSTOMERADR_SETTLEMENTS foreign key (SETTLEMENT_ID) REFERENCES ADR_SETTLEMENTS (SETTLEMENT_ID)]';
  dbms_output.put_line('Foreign key "FK_CUSTOMERADR_SETTLEMENTS" created.');
exception
  when OTHERS then
    if (sqlcode = -02275)
    then dbms_output.put_line('Such a referential constraint already exists in the table.');
    else raise;
    end if;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS add constraint FK_CUSTOMERADR_STREETS foreign key (STREET_ID) REFERENCES ADR_STREETS (STREET_ID)]';
  dbms_output.put_line('Foreign key "FK_CUSTOMERADR_STREETS" created.');
exception
  when OTHERS then
    if (sqlcode = -02275)
    then dbms_output.put_line('Such a referential constraint already exists in the table.');
    else raise;
    end if;
end;
/

-- HOME_TYPE
begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS add constraint FK_CUSTOMERADR_HOMETYPE foreign key (HOME_TYPE) REFERENCES ADR_HOME_TYPE (ID)]';
  dbms_output.put_line('Foreign key "FK_CUSTOMERADR_HOMETYPE " created.');
exception
  when OTHERS then
    if (sqlcode = -02275)
    then dbms_output.put_line('Such a referential constraint already exists in the table.');
    else raise;
    end if;
end;
/

-- HOMEPART_TYPE
begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS add constraint FK_CUSTOMERADR_HOMEPARTTYPE foreign key (HOMEPART_TYPE) REFERENCES ADR_HOMEPART_TYPE (ID)]';
  dbms_output.put_line('Foreign key "FK_CUSTOMERADR_HOMEPARTTYPE" created.');
exception
  when OTHERS then
    if (sqlcode = -02275)
    then dbms_output.put_line('Such a referential constraint already exists in the table.');
    else raise;
    end if;
end;
/

-- ROOM_TYPE
begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS add constraint FK_CUSTOMERADR_ROOMTYPE foreign key (ROOM_TYPE) REFERENCES ADR_ROOM_TYPE (ID)]';
  dbms_output.put_line('Foreign key "FK_CUSTOMERADR_ROOMTYPE" created.');
exception
  when OTHERS then
    if (sqlcode = -02275)
    then dbms_output.put_line('Such a referential constraint already exists in the table.');
    else raise;
    end if;
end;
/
