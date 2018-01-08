

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTARY_QUEUE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTARY_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTARY_QUEUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NOTARY_QUEUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTARY_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTARY_QUEUE 
   (	OBJECT_TYPE VARCHAR2(30 CHAR), 
	OBJECT_ID NUMBER(38,0), 
	KF VARCHAR2(6 CHAR) DEFAULT sys_context(''bars_context'', ''user_mfo''), 
	 CONSTRAINT PK_NOTARY_QUEUE PRIMARY KEY (OBJECT_ID, OBJECT_TYPE, KF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTARY_QUEUE ***
 exec bpa.alter_policies('NOTARY_QUEUE');


COMMENT ON TABLE BARS.NOTARY_QUEUE IS 'Черга ідентифікаторів документів та клієнтів для передачі даних до ЦА';
COMMENT ON COLUMN BARS.NOTARY_QUEUE.OBJECT_TYPE IS 'Тип об'єкту ('REF' - документ, 'RNK' - клієнт)';
COMMENT ON COLUMN BARS.NOTARY_QUEUE.OBJECT_ID IS 'Ідентифікатор об'єкту зазначеного типу';
COMMENT ON COLUMN BARS.NOTARY_QUEUE.KF IS 'МФО регіонального управління';




PROMPT *** Create  constraint SYS_C0060796 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_QUEUE MODIFY (OBJECT_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NOTARY_QUEUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_QUEUE ADD CONSTRAINT PK_NOTARY_QUEUE PRIMARY KEY (OBJECT_ID, OBJECT_TYPE, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0060798 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_QUEUE MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0060797 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_QUEUE MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NOTARY_QUEUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NOTARY_QUEUE ON BARS.NOTARY_QUEUE (OBJECT_ID, OBJECT_TYPE, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOTARY_QUEUE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NOTARY_QUEUE    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTARY_QUEUE.sql =========*** End *** 
PROMPT ===================================================================================== 
