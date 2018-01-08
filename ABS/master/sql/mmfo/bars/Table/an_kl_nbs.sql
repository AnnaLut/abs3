

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AN_KL_NBS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AN_KL_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AN_KL_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''AN_KL_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''AN_KL_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AN_KL_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.AN_KL_NBS 
   (	NBS VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AN_KL_NBS ***
 exec bpa.alter_policies('AN_KL_NBS');


COMMENT ON TABLE BARS.AN_KL_NBS IS '';
COMMENT ON COLUMN BARS.AN_KL_NBS.NBS IS '';




PROMPT *** Create  constraint PK_AN_KL_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN_KL_NBS ADD CONSTRAINT PK_AN_KL_NBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_AN_KL_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_AN_KL_NBS ON BARS.AN_KL_NBS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AN_KL_NBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on AN_KL_NBS       to ABS_ADMIN;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on AN_KL_NBS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AN_KL_NBS       to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on AN_KL_NBS       to START1;
grant FLASHBACK,SELECT                                                       on AN_KL_NBS       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AN_KL_NBS.sql =========*** End *** ===
PROMPT ===================================================================================== 
