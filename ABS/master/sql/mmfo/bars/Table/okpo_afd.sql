

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OKPO_AFD.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OKPO_AFD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OKPO_AFD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OKPO_AFD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OKPO_AFD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OKPO_AFD ***
begin 
  execute immediate '
  CREATE TABLE BARS.OKPO_AFD 
   (	OKPO VARCHAR2(14), 
	ID_KLI CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OKPO_AFD ***
 exec bpa.alter_policies('OKPO_AFD');


COMMENT ON TABLE BARS.OKPO_AFD IS '';
COMMENT ON COLUMN BARS.OKPO_AFD.OKPO IS '';
COMMENT ON COLUMN BARS.OKPO_AFD.ID_KLI IS '';




PROMPT *** Create  constraint SYS_C009311 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OKPO_AFD MODIFY (OKPO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009312 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OKPO_AFD MODIFY (ID_KLI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OKPO_AFD ***
grant FLASHBACK,SELECT                                                       on OKPO_AFD        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OKPO_AFD        to BARS_DM;
grant FLASHBACK,SELECT                                                       on OKPO_AFD        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OKPO_AFD.sql =========*** End *** ====
PROMPT ===================================================================================== 
