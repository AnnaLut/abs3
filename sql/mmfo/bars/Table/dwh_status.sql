

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DWH_STATUS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DWH_STATUS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DWH_STATUS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DWH_STATUS'', ''FILIAL'' , ''M'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DWH_STATUS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DWH_STATUS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DWH_STATUS 
   (	STATUS VARCHAR2(10), 
	DESCRIPT VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DWH_STATUS ***
 exec bpa.alter_policies('DWH_STATUS');


COMMENT ON TABLE BARS.DWH_STATUS IS 'Справочник статусов по загрузке в DWH';
COMMENT ON COLUMN BARS.DWH_STATUS.STATUS IS '';
COMMENT ON COLUMN BARS.DWH_STATUS.DESCRIPT IS '';




PROMPT *** Create  constraint XPK_DWHSTATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_STATUS ADD CONSTRAINT XPK_DWHSTATUS PRIMARY KEY (STATUS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DWHSTATUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DWHSTATUS ON BARS.DWH_STATUS (STATUS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DWH_STATUS ***
grant SELECT                                                                 on DWH_STATUS      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DWH_STATUS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DWH_STATUS      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DWH_STATUS      to START1;
grant SELECT                                                                 on DWH_STATUS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DWH_STATUS.sql =========*** End *** ==
PROMPT ===================================================================================== 
