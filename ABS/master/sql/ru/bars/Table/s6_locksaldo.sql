

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_LockSaldo.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_LockSaldo ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_LockSaldo ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_LockSaldo 
   (	NLS VARCHAR2(25), 
	GROUP_U NUMBER(10,0), 
	I_VA NUMBER(5,0), 
	Motive NUMBER(5,0), 
	DaLock DATE, 
	DocLock VARCHAR2(100), 
	DaDocLock DATE, 
	ISP_Lock NUMBER(5,0), 
	DaUnLock DATE, 
	DocUnLock VARCHAR2(100), 
	DaDocUnLock DATE, 
	ISP_UnLock NUMBER(5,0), 
	DaAutoUnLock DATE, 
	SumLock NUMBER(16,2), 
	D_MODIFY DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_LockSaldo ***
 exec bpa.alter_policies('S6_LockSaldo');


COMMENT ON TABLE BARS.S6_LockSaldo IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.NLS IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.I_VA IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.Motive IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.DaLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.DocLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.DaDocLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.ISP_Lock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.DaUnLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.DocUnLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.DaDocUnLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.ISP_UnLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.DaAutoUnLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.SumLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo.D_MODIFY IS '';




PROMPT *** Create  constraint SYS_C0097570 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_LockSaldo MODIFY (DaLock NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097569 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_LockSaldo MODIFY (Motive NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097568 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_LockSaldo MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097567 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_LockSaldo MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097566 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_LockSaldo MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_LockSaldo.sql =========*** End *** 
PROMPT ===================================================================================== 
