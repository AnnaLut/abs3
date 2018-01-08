

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_CUSTOMERW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_CUSTOMERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_CUSTOMERW'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_CUSTOMERW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_CUSTOMERW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_CUSTOMERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_CUSTOMERW 
   (	RNK NUMBER, 
	TAG VARCHAR2(10), 
	VALUE VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_CUSTOMERW ***
 exec bpa.alter_policies('KL_CUSTOMERW');


COMMENT ON TABLE BARS.KL_CUSTOMERW IS 'Доп. реквизиты кл-банка';
COMMENT ON COLUMN BARS.KL_CUSTOMERW.RNK IS '';
COMMENT ON COLUMN BARS.KL_CUSTOMERW.TAG IS '';
COMMENT ON COLUMN BARS.KL_CUSTOMERW.VALUE IS '';




PROMPT *** Create  constraint XPK_KLCUSTOMERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_CUSTOMERW ADD CONSTRAINT XPK_KLCUSTOMERW PRIMARY KEY (RNK, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KLCUSTOMERW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KLCUSTOMERW ON BARS.KL_CUSTOMERW (RNK, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_CUSTOMERW ***
grant SELECT                                                                 on KL_CUSTOMERW    to BARSREADER_ROLE;
grant SELECT                                                                 on KL_CUSTOMERW    to BARS_DM;
grant SELECT                                                                 on KL_CUSTOMERW    to KLBX;
grant SELECT                                                                 on KL_CUSTOMERW    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_CUSTOMERW    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_CUSTOMERW.sql =========*** End *** 
PROMPT ===================================================================================== 
