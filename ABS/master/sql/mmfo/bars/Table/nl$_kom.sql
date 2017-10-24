

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NL$_KOM.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NL$_KOM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NL$_KOM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NL$_KOM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NL$_KOM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NL$_KOM ***
begin 
  execute immediate '
  CREATE TABLE BARS.NL$_KOM 
   (	KV NUMBER(*,0), 
	PR_KOM NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NL$_KOM ***
 exec bpa.alter_policies('NL$_KOM');


COMMENT ON TABLE BARS.NL$_KOM IS '';
COMMENT ON COLUMN BARS.NL$_KOM.KV IS '';
COMMENT ON COLUMN BARS.NL$_KOM.PR_KOM IS '';




PROMPT *** Create  constraint XPK_NL$_KOM ***
begin   
 execute immediate '
  ALTER TABLE BARS.NL$_KOM ADD CONSTRAINT XPK_NL$_KOM PRIMARY KEY (KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NL$_KOM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NL$_KOM ON BARS.NL$_KOM (KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NL$_KOM ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NL$_KOM         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NL$_KOM         to RCH_1;
grant FLASHBACK,SELECT                                                       on NL$_KOM         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NL$_KOM.sql =========*** End *** =====
PROMPT ===================================================================================== 
