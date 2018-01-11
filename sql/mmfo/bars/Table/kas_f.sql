

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KAS_F.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KAS_F ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KAS_F'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KAS_F'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KAS_F'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KAS_F ***
begin 
  execute immediate '
  CREATE TABLE BARS.KAS_F 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ID NUMBER(*,0), 
	FIO VARCHAR2(38), 
	ATRT_1 VARCHAR2(100), 
	ATRT_2 DATE, 
	ADRES VARCHAR2(100), 
	DOCN NUMBER, 
	DOCS VARCHAR2(10), 
	DT_R DATE, 
	PASP VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KAS_F ***
 exec bpa.alter_policies('KAS_F');


COMMENT ON TABLE BARS.KAS_F IS 'I���������';
COMMENT ON COLUMN BARS.KAS_F.KF IS '��� ���';
COMMENT ON COLUMN BARS.KAS_F.ID IS '���~I���������';
COMMENT ON COLUMN BARS.KAS_F.FIO IS '�I�~I���������';
COMMENT ON COLUMN BARS.KAS_F.ATRT_1 IS '���~������ ��������';
COMMENT ON COLUMN BARS.KAS_F.ATRT_2 IS '����~����i ���';
COMMENT ON COLUMN BARS.KAS_F.ADRES IS '������';
COMMENT ON COLUMN BARS.KAS_F.DOCN IS '�~���';
COMMENT ON COLUMN BARS.KAS_F.DOCS IS '���i�~���';
COMMENT ON COLUMN BARS.KAS_F.DT_R IS '����~����������';
COMMENT ON COLUMN BARS.KAS_F.PASP IS '���~���������';




PROMPT *** Create  constraint PK_KASF_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_F ADD CONSTRAINT PK_KASF_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KASF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_F MODIFY (KF CONSTRAINT CC_KASF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KASF_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KASF_ID ON BARS.KAS_F (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KAS_F ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_F           to ABS_ADMIN;
grant SELECT                                                                 on KAS_F           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KAS_F           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_F           to PYOD001;
grant SELECT                                                                 on KAS_F           to UPLD;
grant FLASHBACK,SELECT                                                       on KAS_F           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KAS_F.sql =========*** End *** =======
PROMPT ===================================================================================== 
