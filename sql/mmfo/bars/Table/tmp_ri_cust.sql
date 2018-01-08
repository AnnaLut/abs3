

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RI_CUST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RI_CUST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RI_CUST ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_RI_CUST 
   (	RNK NUMBER, 
	BRANCH VARCHAR2(30), 
	CUSTTYPE NUMBER, 
	OKPO VARCHAR2(20), 
	PASSP NUMBER, 
	SER VARCHAR2(10), 
	NUMDOC VARCHAR2(20), 
	PRINSIDER NUMBER, 
	INSFO NUMBER(1,0), 
	PRINSIDER_BEFORE NUMBER, 
	INSFO_BEFORE NUMBER(1,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_RI_CUST ***
 exec bpa.alter_policies('TMP_RI_CUST');


COMMENT ON TABLE BARS.TMP_RI_CUST IS '';
COMMENT ON COLUMN BARS.TMP_RI_CUST.RNK IS '';
COMMENT ON COLUMN BARS.TMP_RI_CUST.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_RI_CUST.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.TMP_RI_CUST.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_RI_CUST.PASSP IS '';
COMMENT ON COLUMN BARS.TMP_RI_CUST.SER IS '';
COMMENT ON COLUMN BARS.TMP_RI_CUST.NUMDOC IS '';
COMMENT ON COLUMN BARS.TMP_RI_CUST.PRINSIDER IS '';
COMMENT ON COLUMN BARS.TMP_RI_CUST.INSFO IS '';
COMMENT ON COLUMN BARS.TMP_RI_CUST.PRINSIDER_BEFORE IS '';
COMMENT ON COLUMN BARS.TMP_RI_CUST.INSFO_BEFORE IS '';




PROMPT *** Create  index IX_TMP_RI_CUST ***
begin   
 execute immediate '
  CREATE INDEX BARS.IX_TMP_RI_CUST ON BARS.TMP_RI_CUST (RNK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RI_CUST.sql =========*** End *** =
PROMPT ===================================================================================== 
