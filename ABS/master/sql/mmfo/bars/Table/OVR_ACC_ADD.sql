

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OVR_ACC_ADD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OVR_ACC_ADD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVR_ACC_ADD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVR_ACC_ADD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OVR_ACC_ADD ***
begin 
  execute immediate '
  CREATE TABLE BARS.OVR_ACC_ADD 
   (	ACC NUMBER, 
	ACC_ADD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OVR_ACC_ADD ***
 exec bpa.alter_policies('OVR_ACC_ADD');


COMMENT ON TABLE BARS.OVR_ACC_ADD IS 'Дополнительные счета для расчета ЧКО';
COMMENT ON COLUMN BARS.OVR_ACC_ADD.ACC IS 'счет 2600-участник';
COMMENT ON COLUMN BARS.OVR_ACC_ADD.ACC_ADD IS 'дополнительный счет';




PROMPT *** Create  constraint SYS_C00132321 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_ACC_ADD MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132322 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_ACC_ADD MODIFY (ACC_ADD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OVRACCADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_ACC_ADD ADD CONSTRAINT PK_OVRACCADD PRIMARY KEY (ACC, ACC_ADD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OVRACCADD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OVRACCADD ON BARS.OVR_ACC_ADD (ACC, ACC_ADD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OVR_ACC_ADD ***
grant SELECT                                                                 on OVR_ACC_ADD     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OVR_ACC_ADD     to START1;
grant SELECT                                                                 on OVR_ACC_ADD     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OVR_ACC_ADD.sql =========*** End *** =
PROMPT ===================================================================================== 
