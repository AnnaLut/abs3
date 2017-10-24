

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAG_MD.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAG_MD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAG_MD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAG_MD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAG_MD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAG_MD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAG_MD 
   (	FN VARCHAR2(15), 
	DAT DATE, 
	N NUMBER, 
	OTM NUMBER, 
	DATK DATE, 
	ERR VARCHAR2(4)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAG_MD ***
 exec bpa.alter_policies('ZAG_MD');


COMMENT ON TABLE BARS.ZAG_MD IS '';
COMMENT ON COLUMN BARS.ZAG_MD.FN IS '';
COMMENT ON COLUMN BARS.ZAG_MD.DAT IS '';
COMMENT ON COLUMN BARS.ZAG_MD.N IS '';
COMMENT ON COLUMN BARS.ZAG_MD.OTM IS '';
COMMENT ON COLUMN BARS.ZAG_MD.DATK IS '';
COMMENT ON COLUMN BARS.ZAG_MD.ERR IS '';




PROMPT *** Create  constraint XPK_ZAG_MD ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_MD ADD CONSTRAINT XPK_ZAG_MD PRIMARY KEY (FN, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAG_MD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAG_MD ON BARS.ZAG_MD (FN, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAG_MD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAG_MD          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAG_MD          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAG_MD.sql =========*** End *** ======
PROMPT ===================================================================================== 
