

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F71_RNK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F71_RNK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F71_RNK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F71_RNK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F71_RNK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F71_RNK ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_F71_RNK 
   (	RNK NUMBER, 
	NMK VARCHAR2(70), 
	OKPO VARCHAR2(10), 
	CODCAGENT NUMBER, 
	COUNTRY NUMBER, 
	C_REG NUMBER, 
	VED CHAR(5), 
	PRINS NUMBER, 
	CUSTTYPE NUMBER, 
	CRISK NUMBER, 
	FS CHAR(2), 
	ISE CHAR(5), 
	OSTF NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F71_RNK ***
 exec bpa.alter_policies('OTCN_F71_RNK');


COMMENT ON TABLE BARS.OTCN_F71_RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.NMK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.OKPO IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.CODCAGENT IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.COUNTRY IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.C_REG IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.VED IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.PRINS IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.CRISK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.FS IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.ISE IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK.OSTF IS '';




PROMPT *** Create  constraint PK_OTCN_F71_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_RNK ADD CONSTRAINT PK_OTCN_F71_RNK PRIMARY KEY (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTCN_F71_RNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTCN_F71_RNK ON BARS.OTCN_F71_RNK (RNK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F71_RNK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_RNK    to ABS_ADMIN;
grant SELECT                                                                 on OTCN_F71_RNK    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_RNK    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_RNK    to RPBN002;
grant SELECT                                                                 on OTCN_F71_RNK    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F71_RNK    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F71_RNK.sql =========*** End *** 
PROMPT ===================================================================================== 
