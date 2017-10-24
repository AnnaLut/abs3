

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_TRANS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TRANS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_TRANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_TRANS 
   (	TRAN_TYPE CHAR(2), 
	NAME VARCHAR2(45), 
	BOF NUMBER(38,0), 
	DK NUMBER(1,0), 
	NAME_RUSS VARCHAR2(40)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_TRANS ***
 exec bpa.alter_policies('OBPC_TRANS');


COMMENT ON TABLE BARS.OBPC_TRANS IS 'ŒÔËÒ‡ÌËÂ Ú‡ÌÁ‡ÍˆËÈ œ÷';
COMMENT ON COLUMN BARS.OBPC_TRANS.TRAN_TYPE IS ' Ó‰ ÓÔÂ œ÷';
COMMENT ON COLUMN BARS.OBPC_TRANS.NAME IS 'Õ‡ËÏÂÌÓ‚‡ÌËÂ';
COMMENT ON COLUMN BARS.OBPC_TRANS.BOF IS '¬Ë‰ ÓÔ. 0-œ÷->¡¿Õ  1-¡¿Õ ->œ÷ 2-¡¿Õ <->œ÷ 3-¡¿Õ ';
COMMENT ON COLUMN BARS.OBPC_TRANS.DK IS '';
COMMENT ON COLUMN BARS.OBPC_TRANS.NAME_RUSS IS '';




PROMPT *** Create  constraint PK_OBPCTRANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS ADD CONSTRAINT PK_OBPCTRANS PRIMARY KEY (TRAN_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_OBPCTRANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS ADD CONSTRAINT UK_OBPCTRANS UNIQUE (TRAN_TYPE, DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANS_OBPCBOF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS ADD CONSTRAINT FK_OBPCTRANS_OBPCBOF FOREIGN KEY (BOF)
	  REFERENCES BARS.OBPC_BOF (BOF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANS_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS ADD CONSTRAINT FK_OBPCTRANS_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANS_TRANTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS MODIFY (TRAN_TYPE CONSTRAINT CC_OBPCTRANS_TRANTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANS_BOF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS MODIFY (BOF CONSTRAINT CC_OBPCTRANS_BOF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANS_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS MODIFY (DK CONSTRAINT CC_OBPCTRANS_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCTRANS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCTRANS ON BARS.OBPC_TRANS (TRAN_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_OBPCTRANS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_OBPCTRANS ON BARS.OBPC_TRANS (TRAN_TYPE, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_TRANS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_TRANS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_TRANS      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRANS      to OBPC;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRANS      to OBPC_TRANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_TRANS      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OBPC_TRANS      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS.sql =========*** End *** ==
PROMPT ===================================================================================== 
