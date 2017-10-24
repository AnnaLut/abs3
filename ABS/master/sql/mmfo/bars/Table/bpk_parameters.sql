

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_PARAMETERS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_PARAMETERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_PARAMETERS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_PARAMETERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_PARAMETERS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_PARAMETERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_PARAMETERS 
   (	ND NUMBER(22,0), 
	TAG VARCHAR2(30), 
	VALUE VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_PARAMETERS ***
 exec bpa.alter_policies('BPK_PARAMETERS');


COMMENT ON TABLE BARS.BPK_PARAMETERS IS 'БПК. Реквізити договорів';
COMMENT ON COLUMN BARS.BPK_PARAMETERS.ND IS '№ договору';
COMMENT ON COLUMN BARS.BPK_PARAMETERS.TAG IS 'Код параметру';
COMMENT ON COLUMN BARS.BPK_PARAMETERS.VALUE IS 'Значення';




PROMPT *** Create  constraint PK_BPKPARAMETERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS ADD CONSTRAINT PK_BPKPARAMETERS PRIMARY KEY (ND, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKPARAMETERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKPARAMETERS ON BARS.BPK_PARAMETERS (ND, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_PARAMETERS ***
grant SELECT                                                                 on BPK_PARAMETERS  to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PARAMETERS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_PARAMETERS  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PARAMETERS  to OW;
grant SELECT                                                                 on BPK_PARAMETERS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_PARAMETERS.sql =========*** End **
PROMPT ===================================================================================== 
