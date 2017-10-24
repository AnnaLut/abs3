

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MWAY_ERRORS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MWAY_ERRORS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MWAY_ERRORS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MWAY_ERRORS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MWAY_ERRORS ***
begin 
  execute immediate '
  CREATE TABLE BARS.MWAY_ERRORS 
   (	ERR_CODE NUMBER, 
	ERR_NAME VARCHAR2(100), 
	ERR_MESSAGE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MWAY_ERRORS ***
 exec bpa.alter_policies('MWAY_ERRORS');


COMMENT ON TABLE BARS.MWAY_ERRORS IS '���������� ����� ������ ���������� ��.���� WAY';
COMMENT ON COLUMN BARS.MWAY_ERRORS.ERR_CODE IS '��� ������';
COMMENT ON COLUMN BARS.MWAY_ERRORS.ERR_NAME IS '��������� ��� ������';
COMMENT ON COLUMN BARS.MWAY_ERRORS.ERR_MESSAGE IS '����� ������';




PROMPT *** Create  constraint SYS_C002638764 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_ERRORS ADD PRIMARY KEY (ERR_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002638763 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_ERRORS MODIFY (ERR_MESSAGE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002638762 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_ERRORS MODIFY (ERR_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002638761 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_ERRORS MODIFY (ERR_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C002638764 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C002638764 ON BARS.MWAY_ERRORS (ERR_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MWAY_ERRORS.sql =========*** End *** =
PROMPT ===================================================================================== 
