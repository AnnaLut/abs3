

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_SYNC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_SYNC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_SYNC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_SYNC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_SYNC ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_SYNC 
   (	REF NUMBER, 
	TIME DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_SYNC ***
 exec bpa.alter_policies('INS_SYNC');


COMMENT ON TABLE BARS.INS_SYNC IS 'Синхронізація документів';
COMMENT ON COLUMN BARS.INS_SYNC.REF IS 'Референс';
COMMENT ON COLUMN BARS.INS_SYNC.TIME IS 'дата та час';
COMMENT ON COLUMN BARS.INS_SYNC.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_SYNC.sql =========*** End *** ====
PROMPT ===================================================================================== 
