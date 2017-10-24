

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_FD5_PROC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_FD5_PROC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_FD5_PROC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FD5_PROC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_FD5_PROC ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_FD5_PROC 
   (	ACC NUMBER(*,0), 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0), 
	RNK NUMBER(38,0), 
	ISP NUMBER(38,0), 
	ACCC NUMBER(38,0), 
	TIP CHAR(3), 
	DOS NUMBER, 
	IACC NUMBER(38,0), 
	ND NUMBER, 
	SUMH NUMBER, 
	CNT NUMBER, 
	RNUM NUMBER, 
	SH NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_FD5_PROC ***
 exec bpa.alter_policies('OTCN_FD5_PROC');


COMMENT ON TABLE BARS.OTCN_FD5_PROC IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.KV IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.ACCC IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.TIP IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.DOS IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.IACC IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.ND IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.SUMH IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.CNT IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.RNUM IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_PROC.SH IS '';




PROMPT *** Create  constraint OTCN_FD5_PROC_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FD5_PROC ADD CONSTRAINT OTCN_FD5_PROC_PK PRIMARY KEY (ACC, IACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955628 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FD5_PROC MODIFY (IACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955627 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FD5_PROC MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OTCN_FD5_PROC_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.OTCN_FD5_PROC_PK ON BARS.OTCN_FD5_PROC (ACC, IACC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_FD5_PROC.sql =========*** End ***
PROMPT ===================================================================================== 
