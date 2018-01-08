

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC262005.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC262005 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC262005'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC262005'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC262005'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC262005 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC262005 
   (	ACC NUMBER(*,0), 
	DAPP_REAL DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC262005 ***
 exec bpa.alter_policies('ACC262005');


COMMENT ON TABLE BARS.ACC262005 IS '';
COMMENT ON COLUMN BARS.ACC262005.ACC IS '';
COMMENT ON COLUMN BARS.ACC262005.DAPP_REAL IS '';




PROMPT *** Create  index IND_ACC262005 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IND_ACC262005 ON BARS.ACC262005 (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC262005 ***
grant SELECT                                                                 on ACC262005       to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ACC262005       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC262005       to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ACC262005       to START1;
grant SELECT                                                                 on ACC262005       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC262005.sql =========*** End *** ===
PROMPT ===================================================================================== 
