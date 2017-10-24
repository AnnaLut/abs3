

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_TABN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_TABN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_TABN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TABN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TABN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_TABN ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_TABN 
   (	ID NUMBER(38,0), 
	TABN VARCHAR2(10), 
	GRANTOR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_TABN ***
 exec bpa.alter_policies('STAFF_TABN');


COMMENT ON TABLE BARS.STAFF_TABN IS 'Табельн_ номера користувач_в для п_дтвердження';
COMMENT ON COLUMN BARS.STAFF_TABN.ID IS '_д. користувачв';
COMMENT ON COLUMN BARS.STAFF_TABN.TABN IS 'Табельний номер';
COMMENT ON COLUMN BARS.STAFF_TABN.GRANTOR IS '_д. користувача, що зм_нив атрибут';




PROMPT *** Create  constraint PK_STAFFTABN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TABN ADD CONSTRAINT PK_STAFFTABN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTABN_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TABN ADD CONSTRAINT FK_STAFFTABN_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTABN_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TABN ADD CONSTRAINT FK_STAFFTABN_STAFF2 FOREIGN KEY (GRANTOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTABN_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TABN MODIFY (ID CONSTRAINT CC_STAFFTABN_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFTABN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFTABN ON BARS.STAFF_TABN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_TABN ***
grant SELECT                                                                 on STAFF_TABN      to ABS_ADMIN;
grant SELECT                                                                 on STAFF_TABN      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_TABN      to BARS_DM;



PROMPT *** Create SYNONYM  to STAFF_TABN ***

  CREATE OR REPLACE PUBLIC SYNONYM STAFF_TABN FOR BARS.STAFF_TABN;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_TABN.sql =========*** End *** ==
PROMPT ===================================================================================== 
