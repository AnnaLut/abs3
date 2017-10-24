

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_LOG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_LOG 
   (	KOD NUMBER(*,0), 
	ROW_ID NUMBER, 
	USER_ID NUMBER, 
	CHGDATE DATE, 
	TXT VARCHAR2(100), 
	FDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_LOG ***
 exec bpa.alter_policies('REZ_LOG');


COMMENT ON TABLE BARS.REZ_LOG IS '������ ������� �������';
COMMENT ON COLUMN BARS.REZ_LOG.KOD IS '��� �������';
COMMENT ON COLUMN BARS.REZ_LOG.ROW_ID IS '���������� �����';
COMMENT ON COLUMN BARS.REZ_LOG.USER_ID IS '������������';
COMMENT ON COLUMN BARS.REZ_LOG.CHGDATE IS '����� ����������';
COMMENT ON COLUMN BARS.REZ_LOG.TXT IS '����������� � ����������';
COMMENT ON COLUMN BARS.REZ_LOG.FDAT IS '';




PROMPT *** Create  constraint PK_REZLOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_LOG ADD CONSTRAINT PK_REZLOG PRIMARY KEY (ROW_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZLOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZLOG ON BARS.REZ_LOG (ROW_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_LOG ***
grant SELECT                                                                 on REZ_LOG         to RCC_DEAL;
grant SELECT                                                                 on REZ_LOG         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_LOG.sql =========*** End *** =====
PROMPT ===================================================================================== 
