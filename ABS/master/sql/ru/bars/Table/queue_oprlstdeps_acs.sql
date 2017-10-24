

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/QUEUE_OPRLSTDEPS_ACS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to QUEUE_OPRLSTDEPS_ACS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''QUEUE_OPRLSTDEPS_ACS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''QUEUE_OPRLSTDEPS_ACS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table QUEUE_OPRLSTDEPS_ACS ***
begin 
  execute immediate '
  CREATE TABLE BARS.QUEUE_OPRLSTDEPS_ACS 
   (	CODEOPER NUMBER, 
	 CONSTRAINT PK_QOPRLSTDEPSACS PRIMARY KEY (CODEOPER) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to QUEUE_OPRLSTDEPS_ACS ***
 exec bpa.alter_policies('QUEUE_OPRLSTDEPS_ACS');


COMMENT ON TABLE BARS.QUEUE_OPRLSTDEPS_ACS IS '������� �� ���������� ����������� ���-�������';
COMMENT ON COLUMN BARS.QUEUE_OPRLSTDEPS_ACS.CODEOPER IS '��� �������';




PROMPT *** Create  constraint PK_QOPRLSTDEPSACS ***
begin   
 execute immediate '
  ALTER TABLE BARS.QUEUE_OPRLSTDEPS_ACS ADD CONSTRAINT PK_QOPRLSTDEPSACS PRIMARY KEY (CODEOPER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001985283 ***
begin   
 execute immediate '
  ALTER TABLE BARS.QUEUE_OPRLSTDEPS_ACS MODIFY (CODEOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_QOPRLSTDEPSACS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_QOPRLSTDEPSACS ON BARS.QUEUE_OPRLSTDEPS_ACS (CODEOPER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/QUEUE_OPRLSTDEPS_ACS.sql =========*** 
PROMPT ===================================================================================== 
