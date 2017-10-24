

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_STAFF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_STAFF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TELLER_STAFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_STAFF 
   (	ID NUMBER(38,0), 
	BEGIN_DATE DATE, 
	END_DATE DATE, 
	STATUS NUMBER GENERATED ALWAYS AS (BARS.DATE_IS_INTERVAL(BEGIN_DATE,END_DATE)) VIRTUAL VISIBLE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_STAFF ***
 exec bpa.alter_policies('TELLER_STAFF');


COMMENT ON TABLE BARS.TELLER_STAFF IS '';
COMMENT ON COLUMN BARS.TELLER_STAFF.ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.TELLER_STAFF.BEGIN_DATE IS 'Дата начала действия статуса';
COMMENT ON COLUMN BARS.TELLER_STAFF.END_DATE IS 'Дата окончания действия статуса';
COMMENT ON COLUMN BARS.TELLER_STAFF.STATUS IS 'Признак активности';




PROMPT *** Create  constraint FK_STAFF_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_STAFF ADD CONSTRAINT FK_STAFF_ID FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TELLER_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_STAFF ADD CONSTRAINT PK_TELLER_STAFF PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TLLR_BGNDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_STAFF ADD CONSTRAINT CC_TLLR_BGNDATE CHECK (BEGIN_DATE <= END_DATE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TLLR_STAFF_ED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_STAFF MODIFY (END_DATE CONSTRAINT CC_TLLR_STAFF_ED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TLLR_STAFF_BD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_STAFF MODIFY (BEGIN_DATE CONSTRAINT CC_TLLR_STAFF_BD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TLLR_STAFF_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_STAFF MODIFY (ID CONSTRAINT CC_TLLR_STAFF_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TELLER_STAFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TELLER_STAFF ON BARS.TELLER_STAFF (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TELLER_STAFF ***
grant INSERT,SELECT,UPDATE                                                   on TELLER_STAFF    to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on TELLER_STAFF    to START1;
grant FLASHBACK,SELECT                                                       on TELLER_STAFF    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_STAFF.sql =========*** End *** 
PROMPT ===================================================================================== 
