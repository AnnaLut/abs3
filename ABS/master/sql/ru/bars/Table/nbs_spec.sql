

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_SPEC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_SPEC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_SPEC'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBS_SPEC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_SPEC ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_SPEC 
   (	NBS CHAR(4), 
	S230 VARCHAR2(3) DEFAULT ''0'', 
	KTK NUMBER(38,0) DEFAULT 0, 
	IDG NUMBER(38,0), 
	IDS NUMBER(38,0), 
	SPS NUMBER(38,0) DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_SPEC ***
 exec bpa.alter_policies('NBS_SPEC');


COMMENT ON TABLE BARS.NBS_SPEC IS '���.�� � �������������';
COMMENT ON COLUMN BARS.NBS_SPEC.NBS IS '���������� ����';
COMMENT ON COLUMN BARS.NBS_SPEC.S230 IS '������ �����';
COMMENT ON COLUMN BARS.NBS_SPEC.KTK IS '��� ���';
COMMENT ON COLUMN BARS.NBS_SPEC.IDG IS '��� �� ����������';
COMMENT ON COLUMN BARS.NBS_SPEC.IDS IS '��� ����� ����������';
COMMENT ON COLUMN BARS.NBS_SPEC.SPS IS '������ ����������';




PROMPT *** Create  constraint FK_NBSSPEC_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_SPEC ADD CONSTRAINT FK_NBSSPEC_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBSSPEC_PEREKRG ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_SPEC ADD CONSTRAINT FK_NBSSPEC_PEREKRG FOREIGN KEY (IDG)
	  REFERENCES BARS.PEREKR_G (IDG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBSSPEC_PEREKRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_SPEC ADD CONSTRAINT FK_NBSSPEC_PEREKRS FOREIGN KEY (IDS)
	  REFERENCES BARS.PEREKR_S (IDS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBSSPEC ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_SPEC ADD CONSTRAINT PK_NBSSPEC PRIMARY KEY (NBS, S230, KTK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBSSPEC_KTK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_SPEC MODIFY (KTK CONSTRAINT CC_NBSSPEC_KTK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBSSPEC_S230_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_SPEC MODIFY (S230 CONSTRAINT CC_NBSSPEC_S230_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010581 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_SPEC MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBSSPEC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBSSPEC ON BARS.NBS_SPEC (NBS, S230, KTK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_SPEC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_SPEC        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_SPEC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_SPEC        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_SPEC        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on NBS_SPEC        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_SPEC.sql =========*** End *** ====
PROMPT ===================================================================================== 
