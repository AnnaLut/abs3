

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_CC_MEMBERS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_CC_MEMBERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_CC_MEMBERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_CC_MEMBERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_CC_MEMBERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_CC_MEMBERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_CC_MEMBERS 
   (	BRANCH VARCHAR2(30), 
	HEAD VARCHAR2(1000), 
	MBR1 VARCHAR2(1000), 
	MBR2 VARCHAR2(1000), 
	MBR3 VARCHAR2(1000), 
	MBR4 VARCHAR2(1000), 
	MBR5 VARCHAR2(1000), 
	MBR6 VARCHAR2(1000), 
	MBR7 VARCHAR2(1000), 
	MBR8 VARCHAR2(1000), 
	MBR9 VARCHAR2(1000), 
	MBR10 VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_CC_MEMBERS ***
 exec bpa.alter_policies('WCS_CC_MEMBERS');


COMMENT ON TABLE BARS.WCS_CC_MEMBERS IS 'Склад КК';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.HEAD IS 'ПІБ голови КК';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.MBR1 IS 'ПІБ члена КК №1';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.MBR2 IS 'ПІБ члена КК №2';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.MBR3 IS 'ПІБ члена КК №3';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.MBR4 IS 'ПІБ члена КК №4';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.MBR5 IS 'ПІБ члена КК №5';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.MBR6 IS 'ПІБ члена КК №6';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.MBR7 IS 'ПІБ члена КК №7';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.MBR8 IS 'ПІБ члена КК №8';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.MBR9 IS 'ПІБ члена КК №9';
COMMENT ON COLUMN BARS.WCS_CC_MEMBERS.MBR10 IS 'ПІБ члена КК №10';




PROMPT *** Create  constraint PK_WCSCCMEMBERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CC_MEMBERS ADD CONSTRAINT PK_WCSCCMEMBERS PRIMARY KEY (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSCCMEMBERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSCCMEMBERS ON BARS.WCS_CC_MEMBERS (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_CC_MEMBERS ***
grant SELECT                                                                 on WCS_CC_MEMBERS  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WCS_CC_MEMBERS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_CC_MEMBERS  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_CC_MEMBERS  to START1;
grant SELECT                                                                 on WCS_CC_MEMBERS  to UPLD;
grant FLASHBACK,SELECT                                                       on WCS_CC_MEMBERS  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_CC_MEMBERS.sql =========*** End **
PROMPT ===================================================================================== 
