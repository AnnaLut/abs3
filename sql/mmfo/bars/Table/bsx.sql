

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BSX.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BSX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BSX'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BSX'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BSX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BSX ***
begin 
  execute immediate '
  CREATE TABLE BARS.BSX 
   (	YYYY NUMBER(*,0), 
	ID NUMBER(*,0), 
	M01 NUMBER(38,0), 
	M02 NUMBER(38,0), 
	M03 NUMBER(38,0), 
	M04 NUMBER(38,0), 
	M05 NUMBER(38,0), 
	M06 NUMBER(38,0), 
	M07 NUMBER(38,0), 
	M08 NUMBER(38,0), 
	M09 NUMBER(38,0), 
	M10 NUMBER(38,0), 
	M11 NUMBER(38,0), 
	M12 NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BSX ***
 exec bpa.alter_policies('BSX');


COMMENT ON TABLE BARS.BSX IS '';
COMMENT ON COLUMN BARS.BSX.YYYY IS '';
COMMENT ON COLUMN BARS.BSX.ID IS '';
COMMENT ON COLUMN BARS.BSX.M01 IS '';
COMMENT ON COLUMN BARS.BSX.M02 IS '';
COMMENT ON COLUMN BARS.BSX.M03 IS '';
COMMENT ON COLUMN BARS.BSX.M04 IS '';
COMMENT ON COLUMN BARS.BSX.M05 IS '';
COMMENT ON COLUMN BARS.BSX.M06 IS '';
COMMENT ON COLUMN BARS.BSX.M07 IS '';
COMMENT ON COLUMN BARS.BSX.M08 IS '';
COMMENT ON COLUMN BARS.BSX.M09 IS '';
COMMENT ON COLUMN BARS.BSX.M10 IS '';
COMMENT ON COLUMN BARS.BSX.M11 IS '';
COMMENT ON COLUMN BARS.BSX.M12 IS '';




PROMPT *** Create  constraint PK_BSX ***
begin   
 execute immediate '
  ALTER TABLE BARS.BSX ADD CONSTRAINT PK_BSX PRIMARY KEY (YYYY, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BSX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BSX ON BARS.BSX (YYYY, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BSX ***
grant SELECT                                                                 on BSX             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BSX             to BARS_DM;
grant SELECT                                                                 on BSX             to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BSX.sql =========*** End *** =========
PROMPT ===================================================================================== 
