

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NBS_OB22_R013.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NBS_OB22_R013 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_NBS_OB22_R013'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NBS_OB22_R013'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NBS_OB22_R013 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NBS_OB22_R013 
   (	NBS CHAR(4), 
	OB22 VARCHAR2(2), 
	R013 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NBS_OB22_R013 ***
 exec bpa.alter_policies('TMP_NBS_OB22_R013');


COMMENT ON TABLE BARS.TMP_NBS_OB22_R013 IS '';
COMMENT ON COLUMN BARS.TMP_NBS_OB22_R013.NBS IS '';
COMMENT ON COLUMN BARS.TMP_NBS_OB22_R013.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_NBS_OB22_R013.R013 IS '';




PROMPT *** Create  constraint XPK_TMP_NBS_OB22_R013 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBS_OB22_R013 ADD CONSTRAINT XPK_TMP_NBS_OB22_R013 PRIMARY KEY (NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TMP_NBS_OB22_R013 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TMP_NBS_OB22_R013 ON BARS.TMP_NBS_OB22_R013 (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_NBS_OB22_R013 ***
grant SELECT                                                                 on TMP_NBS_OB22_R013 to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_NBS_OB22_R013 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBS_OB22_R013 to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NBS_OB22_R013 to RCC_DEAL;
grant SELECT                                                                 on TMP_NBS_OB22_R013 to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_NBS_OB22_R013 to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on TMP_NBS_OB22_R013 to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NBS_OB22_R013.sql =========*** End
PROMPT ===================================================================================== 
