

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OVR_LIM.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OVR_LIM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVR_LIM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVR_LIM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OVR_LIM ***
begin 
  execute immediate '
  CREATE TABLE BARS.OVR_LIM 
   (	ND NUMBER, 
	ACC NUMBER, 
	FDAT DATE, 
	LIM NUMBER, 
	PR NUMBER(*,0), 
	OK NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OVR_LIM ***
 exec bpa.alter_policies('OVR_LIM');


COMMENT ON TABLE BARS.OVR_LIM IS 'График лимитов ОВР';
COMMENT ON COLUMN BARS.OVR_LIM.ND IS 'Реф мастер-дог';
COMMENT ON COLUMN BARS.OVR_LIM.ACC IS 'счет-участник';
COMMENT ON COLUMN BARS.OVR_LIM.FDAT IS 'Дата начала действия нового лимита';
COMMENT ON COLUMN BARS.OVR_LIM.LIM IS 'Значение нового лимита';
COMMENT ON COLUMN BARS.OVR_LIM.PR IS 'Режим : 1= АВТО-расчетный, иначе - Ручной расчет';
COMMENT ON COLUMN BARS.OVR_LIM.OK IS 'Признак 1=Авторизован, иначе - нет';




PROMPT *** Create  constraint FK_OVRLIM_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_LIM ADD CONSTRAINT FK_OVRLIM_ND FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OVRLIM_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_LIM ADD CONSTRAINT FK_OVRLIM_ACC FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_OVRLIM ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_LIM ADD CONSTRAINT XPK_OVRLIM PRIMARY KEY (ND, ACC, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_OVRLIM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_OVRLIM ON BARS.OVR_LIM (ND, ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OVR_LIM ***
grant SELECT                                                                 on OVR_LIM         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OVR_LIM         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OVR_LIM.sql =========*** End *** =====
PROMPT ===================================================================================== 
