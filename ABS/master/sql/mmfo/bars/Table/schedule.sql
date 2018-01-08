

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SCHEDULE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SCHEDULE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SCHEDULE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SCHEDULE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SCHEDULE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SCHEDULE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SCHEDULE 
   (	INST_NUM NUMBER, 
	EVENT NUMBER(*,0), 
	EVENT_DATE DATE DEFAULT SYSDATE, 
	FREQ NUMBER(*,0), 
	BR_ID NUMBER, 
	RATE NUMBER(9,4)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SCHEDULE ***
 exec bpa.alter_policies('SCHEDULE');


COMMENT ON TABLE BARS.SCHEDULE IS '';
COMMENT ON COLUMN BARS.SCHEDULE.INST_NUM IS '';
COMMENT ON COLUMN BARS.SCHEDULE.EVENT IS '';
COMMENT ON COLUMN BARS.SCHEDULE.EVENT_DATE IS '';
COMMENT ON COLUMN BARS.SCHEDULE.FREQ IS '';
COMMENT ON COLUMN BARS.SCHEDULE.BR_ID IS '';
COMMENT ON COLUMN BARS.SCHEDULE.RATE IS '';




PROMPT *** Create  constraint XPK_SCHEDULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEDULE ADD CONSTRAINT XPK_SCHEDULE PRIMARY KEY (INST_NUM, EVENT, EVENT_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_EVENT_SCHEDULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEDULE ADD CONSTRAINT R_EVENT_SCHEDULE FOREIGN KEY (EVENT)
	  REFERENCES BARS.EVENT (EVENT) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FREQ_SCHEDULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEDULE ADD CONSTRAINT R_FREQ_SCHEDULE FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009658 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEDULE MODIFY (INST_NUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009659 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEDULE MODIFY (EVENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009660 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEDULE MODIFY (EVENT_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SCHEDULE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SCHEDULE ON BARS.SCHEDULE (INST_NUM, EVENT, EVENT_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SCHEDULE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SCHEDULE        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SCHEDULE        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SCHEDULE.sql =========*** End *** ====
PROMPT ===================================================================================== 
