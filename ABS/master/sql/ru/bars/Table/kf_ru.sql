

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF_RU.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF_RU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF_RU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF_RU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF_RU 
   (	KF VARCHAR2(6), 
	RU VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF_RU ***
 exec bpa.alter_policies('KF_RU');


COMMENT ON TABLE BARS.KF_RU IS 'Коды МФО - Коды учреждений(01, 02, ..., 37)';
COMMENT ON COLUMN BARS.KF_RU.KF IS '';
COMMENT ON COLUMN BARS.KF_RU.RU IS '';




PROMPT *** Create  constraint FK_KFRU_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF_RU ADD CONSTRAINT FK_KFRU_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_KFRU ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF_RU ADD CONSTRAINT UK_KFRU UNIQUE (RU)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KFRU ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF_RU ADD CONSTRAINT PK_KFRU PRIMARY KEY (KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KFRU_RU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF_RU MODIFY (RU CONSTRAINT CC_KFRU_RU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KFRU_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF_RU MODIFY (KF CONSTRAINT CC_KFRU_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KFRU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KFRU ON BARS.KF_RU (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_KFRU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_KFRU ON BARS.KF_RU (RU) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


grant select on bars.kf_ru to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF_RU.sql =========*** End *** =======
PROMPT ===================================================================================== 
