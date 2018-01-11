

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_OP_F524.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_OP_F524 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_OP_F524'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_OP_F524'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_OP_F524'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_OP_F524 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_OP_F524 
   (	KOD VARCHAR2(1), 
	TXT VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_OP_F524 ***
 exec bpa.alter_policies('KL_OP_F524');


COMMENT ON TABLE BARS.KL_OP_F524 IS '';
COMMENT ON COLUMN BARS.KL_OP_F524.KOD IS '';
COMMENT ON COLUMN BARS.KL_OP_F524.TXT IS '';




PROMPT *** Create  constraint XPK_KL_OP_F524 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_OP_F524 ADD CONSTRAINT XPK_KL_OP_F524 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KL_OP_F524 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KL_OP_F524 ON BARS.KL_OP_F524 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_OP_F524 ***
grant SELECT                                                                 on KL_OP_F524      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_OP_F524      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_OP_F524      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_OP_F524      to START1;
grant SELECT                                                                 on KL_OP_F524      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_OP_F524.sql =========*** End *** ==
PROMPT ===================================================================================== 
