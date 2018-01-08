

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPR_R020_R012.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPR_R020_R012 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPR_R020_R012'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_R020_R012'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_R020_R012'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPR_R020_R012 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_R020_R012 
   (	R020 CHAR(4), 
	T020 CHAR(1), 
	R012 CHAR(1), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPR_R020_R012 ***
 exec bpa.alter_policies('SPR_R020_R012');


COMMENT ON TABLE BARS.SPR_R020_R012 IS '';
COMMENT ON COLUMN BARS.SPR_R020_R012.R020 IS '';
COMMENT ON COLUMN BARS.SPR_R020_R012.T020 IS '';
COMMENT ON COLUMN BARS.SPR_R020_R012.R012 IS '';
COMMENT ON COLUMN BARS.SPR_R020_R012.D_OPEN IS '';
COMMENT ON COLUMN BARS.SPR_R020_R012.D_CLOSE IS '';




PROMPT *** Create  constraint SPR_R020_R012_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_R020_R012 ADD CONSTRAINT SPR_R020_R012_PK PRIMARY KEY (R020, T020, D_OPEN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SPR_R020_R012_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SPR_R020_R012_PK ON BARS.SPR_R020_R012 (R020, T020, D_OPEN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPR_R020_R012 ***
grant SELECT                                                                 on SPR_R020_R012   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_R020_R012   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPR_R020_R012   to BARS_DM;
grant SELECT                                                                 on SPR_R020_R012   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPR_R020_R012.sql =========*** End ***
PROMPT ===================================================================================== 
