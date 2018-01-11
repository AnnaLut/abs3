

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUST_PTKC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUST_PTKC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUST_PTKC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUST_PTKC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUST_PTKC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUST_PTKC 
   (	RNK NUMBER, 
	OKPO VARCHAR2(10), 
	NMK VARCHAR2(70), 
	COMM VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUST_PTKC ***
 exec bpa.alter_policies('CUST_PTKC');


COMMENT ON TABLE BARS.CUST_PTKC IS 'Перелік клієнтів з якими існують договора на обслуговування ПТКС';
COMMENT ON COLUMN BARS.CUST_PTKC.RNK IS 'РНК контрагента';
COMMENT ON COLUMN BARS.CUST_PTKC.OKPO IS 'ІНН код';
COMMENT ON COLUMN BARS.CUST_PTKC.NMK IS 'Найменування контрагента';
COMMENT ON COLUMN BARS.CUST_PTKC.COMM IS 'Коментар';
COMMENT ON COLUMN BARS.CUST_PTKC.KF IS '';



PROMPT *** Create  grants  CUST_PTKC ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_PTKC       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_PTKC       to RPBN002;
grant SELECT                                                                 on CUST_PTKC       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_PTKC       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CUST_PTKC       to WR_REFREAD;



PROMPT *** Create SYNONYM  to CUST_PTKC ***

  CREATE OR REPLACE PUBLIC SYNONYM CUST_PTKC FOR BARS.CUST_PTKC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUST_PTKC.sql =========*** End *** ===
PROMPT ===================================================================================== 
