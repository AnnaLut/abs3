

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XAR.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XAR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XAR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.XAR 
   (	XAR NUMBER(2,0), 
	NAME VARCHAR2(35), 
	PAP NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XAR ***
 exec bpa.alter_policies('XAR');


COMMENT ON TABLE BARS.XAR IS 'Характеристика аналитического счета';
COMMENT ON COLUMN BARS.XAR.XAR IS 'Код характеристики';
COMMENT ON COLUMN BARS.XAR.NAME IS 'Наименование характеристики';
COMMENT ON COLUMN BARS.XAR.PAP IS 'А/П/АП';




PROMPT *** Create  constraint CC_XAR_XAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XAR MODIFY (XAR CONSTRAINT CC_XAR_XAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XAR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XAR MODIFY (NAME CONSTRAINT CC_XAR_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XAR_PAP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XAR MODIFY (PAP CONSTRAINT CC_XAR_PAP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_XAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.XAR ADD CONSTRAINT PK_XAR PRIMARY KEY (XAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_XAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_XAR ON BARS.XAR (XAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XAR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on XAR             to ABS_ADMIN;
grant SELECT                                                                 on XAR             to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XAR             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XAR             to BARS_DM;
grant SELECT                                                                 on XAR             to CUST001;
grant SELECT                                                                 on XAR             to START1;
grant SELECT                                                                 on XAR             to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XAR             to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on XAR             to WR_REFREAD;
grant SELECT                                                                 on XAR             to WR_VIEWACC;
grant DELETE,INSERT,SELECT,UPDATE                                            on XAR             to XAR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XAR.sql =========*** End *** =========
PROMPT ===================================================================================== 
