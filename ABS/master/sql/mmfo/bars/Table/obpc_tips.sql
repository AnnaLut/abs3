

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_TIPS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_TIPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_TIPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TIPS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_TIPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_TIPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_TIPS 
   (	TIP CHAR(3), 
	OB22 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_TIPS ***
 exec bpa.alter_policies('OBPC_TIPS');


COMMENT ON TABLE BARS.OBPC_TIPS IS 'ПЦ. Типы плат. карточек';
COMMENT ON COLUMN BARS.OBPC_TIPS.TIP IS 'Тип';
COMMENT ON COLUMN BARS.OBPC_TIPS.OB22 IS 'OB22';




PROMPT *** Create  constraint PK_OBPCTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TIPS ADD CONSTRAINT PK_OBPCTIPS PRIMARY KEY (OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTIPS_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TIPS ADD CONSTRAINT FK_OBPCTIPS_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTIPS_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TIPS MODIFY (TIP CONSTRAINT CC_OBPCTIPS_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTIPS_OB22_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TIPS MODIFY (OB22 CONSTRAINT CC_OBPCTIPS_OB22_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCTIPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCTIPS ON BARS.OBPC_TIPS (OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_TIPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TIPS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_TIPS       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TIPS       to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_TIPS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_TIPS.sql =========*** End *** ===
PROMPT ===================================================================================== 
