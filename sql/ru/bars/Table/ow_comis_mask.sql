

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_COMIS_MASK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_COMIS_MASK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_COMIS_MASK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_COMIS_MASK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_COMIS_MASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_COMIS_MASK 
   (	SYNTHCODE VARCHAR2(30), 
	NLS_MASK VARCHAR2(30), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_COMIS_MASK ***
 exec bpa.alter_policies('OW_COMIS_MASK');


COMMENT ON TABLE BARS.OW_COMIS_MASK IS 'OpenWay. �������� ����� ������ � ��������� ��� �������� ��������';
COMMENT ON COLUMN BARS.OW_COMIS_MASK.NLS_MASK IS '����� �����';
COMMENT ON COLUMN BARS.OW_COMIS_MASK.BRANCH IS '';
COMMENT ON COLUMN BARS.OW_COMIS_MASK.SYNTHCODE IS '��� ������������� �������� (SynthCode)';




PROMPT *** Create  constraint PK_OWCOMISMASK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_COMIS_MASK ADD CONSTRAINT PK_OWCOMISMASK PRIMARY KEY (SYNTHCODE, NLS_MASK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCOMISMASK_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_COMIS_MASK MODIFY (BRANCH CONSTRAINT CC_OWCOMISMASK_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCOMISMASK_NLSMASK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_COMIS_MASK MODIFY (NLS_MASK CONSTRAINT CC_OWCOMISMASK_NLSMASK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCOMISMASK_SYNTHCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_COMIS_MASK MODIFY (SYNTHCODE CONSTRAINT CC_OWCOMISMASK_SYNTHCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWCOMISMASK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWCOMISMASK ON BARS.OW_COMIS_MASK (SYNTHCODE, NLS_MASK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_COMIS_MASK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_COMIS_MASK   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_COMIS_MASK   to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_COMIS_MASK.sql =========*** End ***
PROMPT ===================================================================================== 
