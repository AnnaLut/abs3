

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_OPFIELDS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_OPFIELDS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_OPFIELDS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_OPFIELDS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_OPFIELDS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_OPFIELDS ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_OPFIELDS 
   (	TAG VARCHAR2(10), 
	DESCRIPT VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_OPFIELDS ***
 exec bpa.alter_policies('KL_OPFIELDS');


COMMENT ON TABLE BARS.KL_OPFIELDS IS 'Доп. реквизиты кл-банка';
COMMENT ON COLUMN BARS.KL_OPFIELDS.TAG IS '';
COMMENT ON COLUMN BARS.KL_OPFIELDS.DESCRIPT IS '';




PROMPT *** Create  constraint XPK_KLOPFIELDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_OPFIELDS ADD CONSTRAINT XPK_KLOPFIELDS PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KLOPFIELDS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KLOPFIELDS ON BARS.KL_OPFIELDS (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_OPFIELDS ***
grant SELECT                                                                 on KL_OPFIELDS     to BARS_DM;
grant SELECT                                                                 on KL_OPFIELDS     to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_OPFIELDS     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_OPFIELDS.sql =========*** End *** =
PROMPT ===================================================================================== 
