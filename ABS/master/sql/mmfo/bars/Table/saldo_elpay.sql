

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SALDO_ELPAY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SALDO_ELPAY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SALDO_ELPAY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SALDO_ELPAY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SALDO_ELPAY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SALDO_ELPAY ***
begin 
  execute immediate '
  CREATE TABLE BARS.SALDO_ELPAY 
   (	NLS VARCHAR2(15), 
	KV NUMBER, 
	PAP NUMBER, 
	PDAT DATE, 
	FDAT DATE, 
	OST_START NUMBER(24,0), 
	OST_FINISH NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	OST_START_EX NUMBER(24,0), 
	OST_FINISH_EX NUMBER(24,0), 
	DOS_EX NUMBER(24,0), 
	KOS_EX NUMBER(24,0), 
	RED_SALDO NUMBER, 
	OVERDRAFT NUMBER(24,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SALDO_ELPAY ***
 exec bpa.alter_policies('SALDO_ELPAY');


COMMENT ON TABLE BARS.SALDO_ELPAY IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.NLS IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.KV IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.PAP IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.PDAT IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.FDAT IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.OST_START IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.OST_FINISH IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.DOS IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.KOS IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.OST_START_EX IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.OST_FINISH_EX IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.DOS_EX IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.KOS_EX IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.RED_SALDO IS '';
COMMENT ON COLUMN BARS.SALDO_ELPAY.OVERDRAFT IS '';




PROMPT *** Create  constraint XPK_SALDO_ELPAY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDO_ELPAY ADD CONSTRAINT XPK_SALDO_ELPAY PRIMARY KEY (NLS, KV, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SALDO_ELPAY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SALDO_ELPAY ON BARS.SALDO_ELPAY (NLS, KV, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SALDO_ELPAY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDO_ELPAY     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDO_ELPAY     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SALDO_ELPAY.sql =========*** End *** =
PROMPT ===================================================================================== 
