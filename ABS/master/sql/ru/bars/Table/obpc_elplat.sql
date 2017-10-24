

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_ELPLAT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_ELPLAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_ELPLAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_ELPLAT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_ELPLAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_ELPLAT 
   (	ID NUMBER(38,0), 
	NLS VARCHAR2(14), 
	S NUMBER(38,0), 
	SOS NUMBER(38,0) DEFAULT 0, 
	REF NUMBER(38,0), 
	KV NUMBER(*,0) DEFAULT 980
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_ELPLAT ***
 exec bpa.alter_policies('OBPC_ELPLAT');


COMMENT ON TABLE BARS.OBPC_ELPLAT IS '��: �������� ���������� ���������� �/� (ELPLAT1.TXT)';
COMMENT ON COLUMN BARS.OBPC_ELPLAT.KV IS '';
COMMENT ON COLUMN BARS.OBPC_ELPLAT.ID IS '���';
COMMENT ON COLUMN BARS.OBPC_ELPLAT.NLS IS '���~����';
COMMENT ON COLUMN BARS.OBPC_ELPLAT.S IS '�����';
COMMENT ON COLUMN BARS.OBPC_ELPLAT.SOS IS '���������';
COMMENT ON COLUMN BARS.OBPC_ELPLAT.REF IS '��������';




PROMPT *** Create  constraint FK_OBPCELPLAT_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ELPLAT ADD CONSTRAINT FK_OBPCELPLAT_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCELPLAT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ELPLAT MODIFY (KV CONSTRAINT CC_OBPCELPLAT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCELPLAT_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ELPLAT MODIFY (NLS CONSTRAINT CC_OBPCELPLAT_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBPCELPLAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ELPLAT ADD CONSTRAINT PK_OBPCELPLAT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCELPLAT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ELPLAT MODIFY (ID CONSTRAINT CC_OBPCELPLAT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCELPLAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCELPLAT ON BARS.OBPC_ELPLAT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_ELPLAT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_ELPLAT     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_ELPLAT     to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_ELPLAT     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_ELPLAT.sql =========*** End *** =
PROMPT ===================================================================================== 
