

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SBBSPEC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SBBSPEC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_SBBSPEC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_SBBSPEC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_SBBSPEC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SBBSPEC ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SBBSPEC 
   (	REF NUMBER(38,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SBBSPEC ***
 exec bpa.alter_policies('TMP_SBBSPEC');


COMMENT ON TABLE BARS.TMP_SBBSPEC IS '';
COMMENT ON COLUMN BARS.TMP_SBBSPEC.REF IS '';




PROMPT *** Create  constraint PK_TMPSBBSPEC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SBBSPEC ADD CONSTRAINT PK_TMPSBBSPEC PRIMARY KEY (REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPSBBSPEC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SBBSPEC MODIFY (REF CONSTRAINT CC_TMPSBBSPEC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPSBBSPEC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPSBBSPEC ON BARS.TMP_SBBSPEC (REF) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SBBSPEC ***
grant SELECT                                                                 on TMP_SBBSPEC     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SBBSPEC     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SBBSPEC     to START1;
grant SELECT                                                                 on TMP_SBBSPEC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SBBSPEC.sql =========*** End *** =
PROMPT ===================================================================================== 
