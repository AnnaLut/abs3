

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OVR_LIM_DOG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OVR_LIM_DOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVR_LIM_DOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVR_LIM_DOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OVR_LIM_DOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.OVR_LIM_DOG 
   (	ND NUMBER, 
	ACC NUMBER, 
	FDAT DATE, 
	LIM NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OVR_LIM_DOG ***
 exec bpa.alter_policies('OVR_LIM_DOG');


COMMENT ON TABLE BARS.OVR_LIM_DOG IS 'График лимитов ОВР пл ДОГ';
COMMENT ON COLUMN BARS.OVR_LIM_DOG.ND IS 'Реф мастер-дог';
COMMENT ON COLUMN BARS.OVR_LIM_DOG.ACC IS 'счет-участник';
COMMENT ON COLUMN BARS.OVR_LIM_DOG.FDAT IS 'Дата начала действия нового лимита';
COMMENT ON COLUMN BARS.OVR_LIM_DOG.LIM IS 'Значение нового лимита';




PROMPT *** Create  constraint FK_OVRLIMDOG_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_LIM_DOG ADD CONSTRAINT FK_OVRLIMDOG_ACC FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_OVRLIMDOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_LIM_DOG ADD CONSTRAINT XPK_OVRLIMDOG PRIMARY KEY (ND, ACC, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OVRLIMDOG_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_LIM_DOG ADD CONSTRAINT FK_OVRLIMDOG_ND FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_OVRLIMDOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_OVRLIMDOG ON BARS.OVR_LIM_DOG (ND, ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OVR_LIM_DOG.sql =========*** End *** =
PROMPT ===================================================================================== 
