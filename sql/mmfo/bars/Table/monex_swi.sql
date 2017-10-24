

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MONEX_SWI.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MONEX_SWI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MONEX_SWI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MONEX_SWI'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MONEX_SWI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MONEX_SWI ***
begin 
  execute immediate '
  CREATE TABLE BARS.MONEX_SWI 
   (	NUM NUMBER, 
	KV NUMBER, 
	TAG CHAR(5), 
	VALUE VARCHAR2(254), 
	ORD NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MONEX_SWI ***
 exec bpa.alter_policies('MONEX_SWI');


COMMENT ON TABLE BARS.MONEX_SWI IS '';
COMMENT ON COLUMN BARS.MONEX_SWI.NUM IS '';
COMMENT ON COLUMN BARS.MONEX_SWI.KV IS '';
COMMENT ON COLUMN BARS.MONEX_SWI.TAG IS '';
COMMENT ON COLUMN BARS.MONEX_SWI.VALUE IS '';
COMMENT ON COLUMN BARS.MONEX_SWI.ORD IS '';




PROMPT *** Create  constraint PK_MONEXSWI ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_SWI ADD CONSTRAINT PK_MONEXSWI PRIMARY KEY (NUM, KV, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MONEXSWI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MONEXSWI ON BARS.MONEX_SWI (NUM, KV, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MONEX_SWI ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEX_SWI       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MONEX_SWI       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEX_SWI       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MONEX_SWI.sql =========*** End *** ===
PROMPT ===================================================================================== 
