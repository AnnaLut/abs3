

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/F59_FIELD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to F59_FIELD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F59_FIELD ***
begin 
  execute immediate '
  CREATE TABLE BARS.F59_FIELD 
   (	ID NUMBER, 
	NMK VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to F59_FIELD ***
 exec bpa.alter_policies('F59_FIELD');


COMMENT ON TABLE BARS.F59_FIELD IS '';
COMMENT ON COLUMN BARS.F59_FIELD.ID IS '';
COMMENT ON COLUMN BARS.F59_FIELD.NMK IS '';



PROMPT *** Create  grants  F59_FIELD ***
grant SELECT                                                                 on F59_FIELD       to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on F59_FIELD       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on F59_FIELD       to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on F59_FIELD       to PYOD001;
grant SELECT                                                                 on F59_FIELD       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on F59_FIELD       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F59_FIELD.sql =========*** End *** ===
PROMPT ===================================================================================== 
