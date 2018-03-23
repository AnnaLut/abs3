

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F71_CUST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F71_CUST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F71_CUST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F71_CUST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


PROMPT *** Create  table OTCN_F71_CUST ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_F71_CUST 
   (	RNK NUMBER, 
	OKPO VARCHAR2(10), 
	REZ NUMBER, 
	CUSTTYPE NUMBER, 
	P010 VARCHAR2(200), 
	P020 VARCHAR2(10), 
	P025 VARCHAR2(10), 
	P040 VARCHAR2(10), 
	P050 VARCHAR2(10), 
	P055 VARCHAR2(10), 
	P060 VARCHAR2(10), 
	P085 VARCHAR2(10),
        K021 VARCHAR2(1)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F71_CUST ***
 exec bpa.alter_policies('OTCN_F71_CUST');


COMMENT ON TABLE BARS.OTCN_F71_CUST IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.OKPO IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.REZ IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.P010 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.P020 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.P025 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.P040 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.P050 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.P055 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.P060 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.P085 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST.K021 IS '';




PROMPT *** Create  constraint PK_OTCN_F71_CUST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_CUST ADD CONSTRAINT PK_OTCN_F71_CUST PRIMARY KEY (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTCN_F71_CUST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTCN_F71_CUST ON BARS.OTCN_F71_CUST (RNK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F71_CUST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_CUST   to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_CUST   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_CUST   to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F71_CUST   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F71_CUST.sql =========*** End ***
PROMPT ===================================================================================== 
