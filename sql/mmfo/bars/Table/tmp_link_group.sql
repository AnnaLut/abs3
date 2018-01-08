

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LINK_GROUP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LINK_GROUP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LINK_GROUP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_LINK_GROUP 
   (	RNK NUMBER(38,0), 
	LINK_GROUP NUMBER, 
	LINK_CODE VARCHAR2(3), 
	LINK_NAME VARCHAR2(70)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LINK_GROUP ***
 exec bpa.alter_policies('TMP_LINK_GROUP');


COMMENT ON TABLE BARS.TMP_LINK_GROUP IS '';
COMMENT ON COLUMN BARS.TMP_LINK_GROUP.RNK IS '';
COMMENT ON COLUMN BARS.TMP_LINK_GROUP.LINK_GROUP IS '';
COMMENT ON COLUMN BARS.TMP_LINK_GROUP.LINK_CODE IS '';
COMMENT ON COLUMN BARS.TMP_LINK_GROUP.LINK_NAME IS '';




PROMPT *** Create  constraint SYS_C00134198 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_LINK_GROUP MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_TMP_LINK_GROUP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_TMP_LINK_GROUP ON BARS.TMP_LINK_GROUP (RNK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_TMP_LINK_GROUP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_TMP_LINK_GROUP ON BARS.TMP_LINK_GROUP (LINK_GROUP, RNK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_LINK_GROUP ***
grant SELECT                                                                 on TMP_LINK_GROUP  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LINK_GROUP.sql =========*** End **
PROMPT ===================================================================================== 
