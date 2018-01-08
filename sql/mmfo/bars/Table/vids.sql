

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIDS.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIDS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIDS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VIDS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''VIDS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIDS ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIDS 
   (	VID NUMBER(2,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIDS ***
 exec bpa.alter_policies('VIDS');


COMMENT ON TABLE BARS.VIDS IS 'Виды счетов ( НИ )';
COMMENT ON COLUMN BARS.VIDS.VID IS 'Вид';
COMMENT ON COLUMN BARS.VIDS.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_VIDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIDS ADD CONSTRAINT PK_VIDS PRIMARY KEY (VID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VIDS_VID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIDS MODIFY (VID CONSTRAINT CC_VIDS_VID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VIDS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIDS MODIFY (NAME CONSTRAINT CC_VIDS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VIDS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VIDS ON BARS.VIDS (VID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VIDS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VIDS            to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VIDS            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VIDS            to BARS_DM;
grant SELECT                                                                 on VIDS            to CUST001;
grant SELECT                                                                 on VIDS            to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIDS            to VIDS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VIDS            to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on VIDS            to WR_REFREAD;
grant SELECT                                                                 on VIDS            to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIDS.sql =========*** End *** ========
PROMPT ===================================================================================== 
