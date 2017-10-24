

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_FORW.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_FORW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_FORW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_FORW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_FORW ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_FORW 
   (	REF NUMBER(38,0), 
	TT CHAR(3), 
	DK NUMBER(38,0), 
	ACC NUMBER, 
	FDAT DATE, 
	S NUMBER(24,0), 
	SQ NUMBER(24,0), 
	TXT VARCHAR2(70), 
	STMT NUMBER(38,0), 
	SOS NUMBER(38,0), 
	ID NUMBER, 
	OTM NUMBER(*,0), 
	SS NUMBER, 
	SSQ NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_FORW ***
 exec bpa.alter_policies('CP_FORW');


COMMENT ON TABLE BARS.CP_FORW IS '�i����i� �������/�����i����� �����i� �� (�� ACC)';
COMMENT ON COLUMN BARS.CP_FORW.REF IS 'ref ���-�� (������ OPLDOK)';
COMMENT ON COLUMN BARS.CP_FORW.TT IS '������ OPLDOK';
COMMENT ON COLUMN BARS.CP_FORW.DK IS '������ OPLDOK';
COMMENT ON COLUMN BARS.CP_FORW.ACC IS '������ OPLDOK';
COMMENT ON COLUMN BARS.CP_FORW.FDAT IS '������ OPLDOK';
COMMENT ON COLUMN BARS.CP_FORW.S IS '������ OPLDOK';
COMMENT ON COLUMN BARS.CP_FORW.SQ IS '������ OPLDOK';
COMMENT ON COLUMN BARS.CP_FORW.TXT IS '����-� �������i� ������� ������';
COMMENT ON COLUMN BARS.CP_FORW.STMT IS '������ OPLDOK';
COMMENT ON COLUMN BARS.CP_FORW.SOS IS '������ OPLDOK';
COMMENT ON COLUMN BARS.CP_FORW.ID IS '������ OPLDOK';
COMMENT ON COLUMN BARS.CP_FORW.OTM IS '������ OPLDOK';
COMMENT ON COLUMN BARS.CP_FORW.SS IS '���� ������ ��� �������-�������';
COMMENT ON COLUMN BARS.CP_FORW.SSQ IS '����-��� ������ ��� �������-�������';




PROMPT *** Create  constraint XPK_CP_FORW ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_FORW ADD CONSTRAINT XPK_CP_FORW PRIMARY KEY (REF, STMT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_FORW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_FORW ON BARS.CP_FORW (REF, STMT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_FORW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_FORW         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_FORW.sql =========*** End *** =====
PROMPT ===================================================================================== 
