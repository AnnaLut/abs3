

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_VAL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_VAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_VAL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ND_VAL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_VAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_VAL 
   (	FDAT DATE, 
	ND NUMBER(*,0), 
	TIPA NUMBER(*,0), 
	KOL NUMBER, 
	RNK NUMBER(*,0), 
	FIN NUMBER(*,0), 
	TIP_FIN NUMBER(*,0), 
	ISTVAL NUMBER(*,0), 
	S080 VARCHAR2(1), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	S180 VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ND_VAL ***
 exec bpa.alter_policies('ND_VAL');


COMMENT ON TABLE BARS.ND_VAL IS '��������� �� ��������';
COMMENT ON COLUMN BARS.ND_VAL.S180 IS '�������� s180';
COMMENT ON COLUMN BARS.ND_VAL.FDAT IS '����� ����';
COMMENT ON COLUMN BARS.ND_VAL.ND IS '���. ��������';
COMMENT ON COLUMN BARS.ND_VAL.TIPA IS '��� ������ ';
COMMENT ON COLUMN BARS.ND_VAL.KOL IS '�-�� ��� ����������';
COMMENT ON COLUMN BARS.ND_VAL.RNK IS '���';
COMMENT ON COLUMN BARS.ND_VAL.FIN IS 'Գ�. ����';
COMMENT ON COLUMN BARS.ND_VAL.TIP_FIN IS '��� ��� �����: 0 - ���.���� 1-2,  1 - ���.���� 1-5, 0 - ���.���� 1-10';
COMMENT ON COLUMN BARS.ND_VAL.ISTVAL IS '�������� �������� �������';
COMMENT ON COLUMN BARS.ND_VAL.S080 IS '�������� s080';
COMMENT ON COLUMN BARS.ND_VAL.KF IS '';




PROMPT *** Create  constraint PK_ND_VAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_VAL ADD CONSTRAINT PK_ND_VAL PRIMARY KEY (FDAT, RNK, ND, TIPA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDVAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_VAL MODIFY (KF CONSTRAINT CC_NDVAL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ND_VAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ND_VAL ON BARS.ND_VAL (FDAT, RNK, ND, TIPA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ND_VAL ***
grant SELECT                                                                 on ND_VAL          to BARSREADER_ROLE;
grant SELECT                                                                 on ND_VAL          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_VAL          to RCC_DEAL;
grant SELECT                                                                 on ND_VAL          to START1;
grant SELECT                                                                 on ND_VAL          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_VAL.sql =========*** End *** ======
PROMPT ===================================================================================== 
