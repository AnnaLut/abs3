

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_MFO_NLS29.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_MFO_NLS29 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_MFO_NLS29'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_MFO_NLS29 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_MFO_NLS29 
   (	MFO VARCHAR2(6), 
	NLS29 VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_MFO_NLS29 ***
 exec bpa.alter_policies('ZAY_MFO_NLS29');


COMMENT ON TABLE BARS.ZAY_MFO_NLS29 IS '';
COMMENT ON COLUMN BARS.ZAY_MFO_NLS29.MFO IS '';
COMMENT ON COLUMN BARS.ZAY_MFO_NLS29.NLS29 IS '';




PROMPT *** Create  constraint PK_ZAYMFONLS29 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_MFO_NLS29 ADD CONSTRAINT PK_ZAYMFONLS29 PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYMFONLS29 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYMFONLS29 ON BARS.ZAY_MFO_NLS29 (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_MFO_NLS29.sql =========*** End ***
PROMPT ===================================================================================== 
