

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONTRTYPE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONTRTYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CONTRTYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CONTRTYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CONTRTYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONTRTYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONTRTYPE 
   (	ID NUMBER, 
	R_IMPEXP NUMBER(*,0), 
	NAME CHAR(10), 
	OPERATION CHAR(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONTRTYPE ***
 exec bpa.alter_policies('CONTRTYPE');


COMMENT ON TABLE BARS.CONTRTYPE IS '';
COMMENT ON COLUMN BARS.CONTRTYPE.ID IS '';
COMMENT ON COLUMN BARS.CONTRTYPE.R_IMPEXP IS '';
COMMENT ON COLUMN BARS.CONTRTYPE.NAME IS '';
COMMENT ON COLUMN BARS.CONTRTYPE.OPERATION IS '';




PROMPT *** Create  constraint SYS_C006684 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRTYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CONTRTYPE ***
grant SELECT                                                                 on CONTRTYPE       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CONTRTYPE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CONTRTYPE       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CONTRTYPE       to CONTRTYPE;
grant SELECT                                                                 on CONTRTYPE       to UPLD;
grant FLASHBACK,SELECT                                                       on CONTRTYPE       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONTRTYPE.sql =========*** End *** ===
PROMPT ===================================================================================== 
