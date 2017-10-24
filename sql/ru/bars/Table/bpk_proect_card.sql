

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_PROECT_CARD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_PROECT_CARD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_PROECT_CARD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_PROECT_CARD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_PROECT_CARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_PROECT_CARD 
   (	OKPO VARCHAR2(14), 
	OKPO_N NUMBER(22,0), 
	CARD_CODE VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_PROECT_CARD ***
 exec bpa.alter_policies('BPK_PROECT_CARD');


COMMENT ON TABLE BARS.BPK_PROECT_CARD IS '���. ���������� ���� ���� � ������� �/� ��������';
COMMENT ON COLUMN BARS.BPK_PROECT_CARD.OKPO IS '���� �/� �������';
COMMENT ON COLUMN BARS.BPK_PROECT_CARD.OKPO_N IS '���� �������� ������';
COMMENT ON COLUMN BARS.BPK_PROECT_CARD.CARD_CODE IS '����� �����';




PROMPT *** Create  constraint PK_BPKPROECTCARD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PROECT_CARD ADD CONSTRAINT PK_BPKPROECTCARD PRIMARY KEY (OKPO, OKPO_N, CARD_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKPROECTCARD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKPROECTCARD ON BARS.BPK_PROECT_CARD (OKPO, OKPO_N, CARD_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_PROECT_CARD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PROECT_CARD to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PROECT_CARD to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_PROECT_CARD.sql =========*** End *
PROMPT ===================================================================================== 
