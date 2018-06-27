

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_IIC_MSGCODE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_IIC_MSGCODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_IIC_MSGCODE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OW_IIC_MSGCODE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_IIC_MSGCODE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_IIC_MSGCODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_IIC_MSGCODE 
   (  TT CHAR(3), 
  MFOA VARCHAR2(6), 
  NLSA VARCHAR2(14), 
  MSGCODE VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Add column COBUMMFO-8228 ***
begin
  execute immediate '
            ALTER TABLE BARS.OW_IIC_MSGCODE add (
            NBS char(4),
            OB22  char(2) 
            )
  ';
  exception when others then       
    if sqlcode=-01430 then null;else raise;end if;    
end;
/


PROMPT *** ALTER_POLICIES to OW_IIC_MSGCODE ***
 exec bpa.alter_policies('OW_IIC_MSGCODE');


COMMENT ON TABLE BARS.OW_IIC_MSGCODE IS 'OpenWay. Коды проводок для формирования IIC';
COMMENT ON COLUMN BARS.OW_IIC_MSGCODE.TT IS 'Оп.';
COMMENT ON COLUMN BARS.OW_IIC_MSGCODE.MFOA IS 'МФО-А';
COMMENT ON COLUMN BARS.OW_IIC_MSGCODE.NLSA IS 'Счет-А';
COMMENT ON COLUMN BARS.OW_IIC_MSGCODE.MSGCODE IS 'Код проводки';
COMMENT ON COLUMN BARS.OW_IIC_MSGCODE.NBS IS 'Номер балансового рахунку';
COMMENT ON COLUMN BARS.OW_IIC_MSGCODE.OB22 IS 'Код ОБ22';  




PROMPT *** Create  constraint PK_OWIICMSGCODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IIC_MSGCODE ADD CONSTRAINT PK_OWIICMSGCODE PRIMARY KEY (TT, MFOA, NLSA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWIICMSGCODE_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IIC_MSGCODE MODIFY (TT CONSTRAINT CC_OWIICMSGCODE_TT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWIICMSGCODE_MFOA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IIC_MSGCODE MODIFY (MFOA CONSTRAINT CC_OWIICMSGCODE_MFOA_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWIICMSGCODE_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IIC_MSGCODE MODIFY (NLSA CONSTRAINT CC_OWIICMSGCODE_NLSA_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWIICMSGCODE_MSGCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IIC_MSGCODE MODIFY (MSGCODE CONSTRAINT CC_OWIICMSGCODE_MSGCODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWIICMSGCODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWIICMSGCODE ON BARS.OW_IIC_MSGCODE (TT, MFOA, NLSA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_IIC_MSGCODE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_IIC_MSGCODE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_IIC_MSGCODE  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_IIC_MSGCODE  to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_IIC_MSGCODE.sql =========*** End **
PROMPT ===================================================================================== 
