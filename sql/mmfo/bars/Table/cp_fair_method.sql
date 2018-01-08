BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_FAIR_METHOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_FAIR_METHOD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_FAIR_METHOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

begin 
  execute immediate '
  CREATE TABLE BARS.CP_FAIR_METHOD
   (	ID NUMBER(2), 
	TITLE VARCHAR2(100)
   ) TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin   
 execute immediate 'create unique index U_CP_FAIR_METHOD on CP_FAIR_METHOD (id)
  tablespace BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table CP_FAIR_METHOD
  add constraint PK_CP_FAIR_METHOD primary key (ID)
USING INDEX U_CP_FAIR_METHOD';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




 exec bpa.alter_policies('CP_FAIR_METHOD');

COMMENT ON TABLE BARS.CP_FAIR_METHOD IS 'Метод розрахунку справедливої вартості';

