BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''cust_access_userid'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''cust_access_userid'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


begin 
  execute immediate '  
  CREATE TABLE cust_access_userid
 ( userid          number,
   field_code       varchar2(50),
   access_type_code varchar2(50)
   )
TABLESPACE brsmdld';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

 exec bpa.alter_policies('cust_access_userid');


COMMENT ON TABLE BARS.cust_access_userid IS 'Связка кода пользователя с доступностьбю полей в карточке клиента';
COMMENT ON COLUMN BARS.cust_access_userid.userid IS 'Код пользоватля';
COMMENT ON COLUMN BARS.cust_access_userid.field_code IS 'Код поля карточки клиента';
COMMENT ON COLUMN BARS.cust_access_userid.access_type_code IS 'Код доступа';

begin   
 execute immediate 'ALTER TABLE BARS.cust_access_userid ADD CONSTRAINT FK_custaccess_userid FOREIGN KEY (userid) REFERENCES BARS.staff$base (id) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


begin   
 execute immediate 'ALTER TABLE BARS.cust_access_userid ADD CONSTRAINT FK_custaccess_cust_field  FOREIGN KEY (field_code) REFERENCES BARS.cust_access_fields (field_code) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


begin   
 execute immediate 'ALTER TABLE BARS.cust_access_userid ADD CONSTRAINT FK_custaccess_access_code  FOREIGN KEY (access_type_code) REFERENCES BARS.cust_access_types (access_type_code) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


begin   
 execute immediate 'ALTER TABLE BARS.cust_access_userid ADD CONSTRAINT XPK_custaccess_userid primary KEY (userid, field_code) USING INDEX TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



grant DELETE,INSERT,SELECT,UPDATE                                            on cust_access_userid        to BARS_ACCESS_DEFROLE;
