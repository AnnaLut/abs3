

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_W4_BPK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_W4_BPK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_W4_BPK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_W4_BPK'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_W4_BPK ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_W4_BPK 
   (	ND NUMBER(*,0), 
	ACC_PK NUMBER(*,0), 
	RNK NUMBER(*,0), 
	ACC NUMBER(*,0), 
	NBS CHAR(4), 
	OB22 CHAR(2), 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0), 
	TIP CHAR(3), 
	TIP_KART NUMBER(*,0), 
	SDATE DATE, 
	WDATE DATE, 
	FIN23 NUMBER(*,0), 
	S250 NUMBER(*,0), 
	GRP NUMBER(*,0), 
	VKR VARCHAR2(3), 
	RESTR NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_W4_BPK ***
 exec bpa.alter_policies('REZ_W4_BPK');


COMMENT ON TABLE BARS.REZ_W4_BPK IS '�������� ��������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.KF IS '';
COMMENT ON COLUMN BARS.REZ_W4_BPK.ND IS '���. �����';
COMMENT ON COLUMN BARS.REZ_W4_BPK.ACC_PK IS '';
COMMENT ON COLUMN BARS.REZ_W4_BPK.RNK IS '���.����� �볺���';
COMMENT ON COLUMN BARS.REZ_W4_BPK.ACC IS '��.����� �������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.NBS IS '���.�������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.OB22 IS '��22 �������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.NLS IS '����� �������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.KV IS '��� ������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.TIP IS '��� �������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.TIP_KART IS '��� ������ 41 - BPK, 42 - W4';
COMMENT ON COLUMN BARS.REZ_W4_BPK.SDATE IS '���� ������� ��������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.WDATE IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.FIN23 IS 'Գ�.���� �� 23 ��������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.S250 IS 's250 = 8 - �������� �� ����������� �����';
COMMENT ON COLUMN BARS.REZ_W4_BPK.GRP IS '������ ������������ ������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.VKR IS '���������� ��������� �������';
COMMENT ON COLUMN BARS.REZ_W4_BPK.RESTR IS '���������������� ��� ����������� ������������ ������';




PROMPT *** Create  constraint PK_REZ_W4_BPK ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_W4_BPK ADD CONSTRAINT PK_REZ_W4_BPK PRIMARY KEY (ND, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZW4BPK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_W4_BPK MODIFY (KF CONSTRAINT CC_REZW4BPK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZ_W4_BPK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_W4_BPK ON BARS.REZ_W4_BPK (ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_REZ_W4_BPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_REZ_W4_BPK ON BARS.REZ_W4_BPK (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_REZ_W4_BPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_REZ_W4_BPK ON BARS.REZ_W4_BPK (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_W4_BPK ***
grant SELECT                                                                 on REZ_W4_BPK      to BARSREADER_ROLE;
grant SELECT                                                                 on REZ_W4_BPK      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_W4_BPK      to RCC_DEAL;
grant SELECT                                                                 on REZ_W4_BPK      to START1;
grant SELECT                                                                 on REZ_W4_BPK      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_W4_BPK.sql =========*** End *** ==
PROMPT ===================================================================================== 
