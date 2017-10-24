

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F42_CP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F42_CP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F42_CP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F42_CP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F42_CP ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_F42_CP 
   (	FDAT DATE, 
	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	SUM_ZAL NUMBER, 
	DAT_ZAL DATE, 
	RNK NUMBER, 
	KODP VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F42_CP ***
 exec bpa.alter_policies('OTCN_F42_CP');


COMMENT ON TABLE BARS.OTCN_F42_CP IS '�� ��i � ���������� ��������� 870000-910000 42 �����';
COMMENT ON COLUMN BARS.OTCN_F42_CP.FDAT IS '��i��� ����';
COMMENT ON COLUMN BARS.OTCN_F42_CP.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_F42_CP.NLS IS '�������� �������';
COMMENT ON COLUMN BARS.OTCN_F42_CP.KV IS '������';
COMMENT ON COLUMN BARS.OTCN_F42_CP.SUM_ZAL IS '���� ���������';
COMMENT ON COLUMN BARS.OTCN_F42_CP.DAT_ZAL IS '���� ���������';
COMMENT ON COLUMN BARS.OTCN_F42_CP.RNK IS '��� ��i����';
COMMENT ON COLUMN BARS.OTCN_F42_CP.KODP IS '��� ���������';




PROMPT *** Create  constraint SYS_C002020488 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_CP MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002020487 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_CP MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTCN_F42_CP ***
begin   
 execute immediate '
  CREATE INDEX BARS.PK_OTCN_F42_CP ON BARS.OTCN_F42_CP (FDAT, NLS, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F42_CP ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F42_CP     to BARS_ACCESS_DEFROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F42_CP     to RPBN002;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F42_CP     to SALGL;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F42_CP     to START1;



PROMPT *** Create SYNONYM  to OTCN_F42_CP ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_F42_CP FOR BARS.OTCN_F42_CP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F42_CP.sql =========*** End *** =
PROMPT ===================================================================================== 
