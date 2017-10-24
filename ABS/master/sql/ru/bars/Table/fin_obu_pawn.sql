

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_OBU_PAWN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_OBU_PAWN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_OBU_PAWN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_OBU_PAWN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_OBU_PAWN ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_OBU_PAWN 
   (	ID NUMBER, 
	ND NUMBER(10,0), 
	RNK NUMBER(*,0), 
	ACC NUMBER(*,0), 
	PAWN NUMBER(*,0), 
	KV NUMBER(3,0), 
	S_SPV NUMBER(24,2) DEFAULT 0, 
	P_ZAST VARCHAR2(170), 
	DATP DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_OBU_PAWN ***
 exec bpa.alter_policies('FIN_OBU_PAWN');


COMMENT ON TABLE BARS.FIN_OBU_PAWN IS '������������ �������� � ���������� �������� ';
COMMENT ON COLUMN BARS.FIN_OBU_PAWN.ID IS '����';
COMMENT ON COLUMN BARS.FIN_OBU_PAWN.ND IS '��� ��';
COMMENT ON COLUMN BARS.FIN_OBU_PAWN.RNK IS '';
COMMENT ON COLUMN BARS.FIN_OBU_PAWN.ACC IS '';
COMMENT ON COLUMN BARS.FIN_OBU_PAWN.PAWN IS '��� ���� �������';
COMMENT ON COLUMN BARS.FIN_OBU_PAWN.KV IS '��� ������';
COMMENT ON COLUMN BARS.FIN_OBU_PAWN.S_SPV IS '����������� �������';
COMMENT ON COLUMN BARS.FIN_OBU_PAWN.P_ZAST IS '������� �������';
COMMENT ON COLUMN BARS.FIN_OBU_PAWN.DATP IS '���� �������� ��������';




PROMPT *** Create  constraint FK_FINOBUPAWN_PAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_PAWN ADD CONSTRAINT FK_FINOBUPAWN_PAWN FOREIGN KEY (PAWN)
	  REFERENCES BARS.CC_PAWN (PAWN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FINOBUPAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_PAWN ADD CONSTRAINT PK_FINOBUPAWN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FINOBU_S_SPV ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_PAWN MODIFY (S_SPV CONSTRAINT NK_FINOBU_S_SPV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FINOBUPAWN_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_PAWN MODIFY (KV CONSTRAINT NK_FINOBUPAWN_KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FINOBUPAWN_PAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_PAWN MODIFY (PAWN CONSTRAINT NK_FINOBUPAWN_PAWN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FINOBUPAWN_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_PAWN MODIFY (RNK CONSTRAINT NK_FINOBUPAWN_RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FINOBUPAWN_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_PAWN MODIFY (ND CONSTRAINT NK_FINOBUPAWN_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FINOBUPAWN_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_PAWN MODIFY (ID CONSTRAINT NK_FINOBUPAWN_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINOBUPAWN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINOBUPAWN ON BARS.FIN_OBU_PAWN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_FIN_OBU_PAWN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_FIN_OBU_PAWN ON BARS.FIN_OBU_PAWN (RNK, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_OBU_PAWN ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_OBU_PAWN    to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_OBU_PAWN    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_OBU_PAWN.sql =========*** End *** 
PROMPT ===================================================================================== 
