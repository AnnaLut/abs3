

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_PARAMS_UPDATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_PARAMS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_PARAMS_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_PARAMS_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_PARAMS_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_PARAMS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_PARAMS_UPDATE 
   (	PAR_NAME VARCHAR2(128), 
	PAR_VALUE VARCHAR2(4000), 
	GLOBAL NUMBER(*,0), 
	KF VARCHAR2(6), 
	S_USER_ID NUMBER DEFAULT sys_context(''bars_global'',''user_id''), 
	S_KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	S_CHGDATE DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_PARAMS_UPDATE ***
 exec bpa.alter_policies('CIM_PARAMS_UPDATE');


COMMENT ON TABLE BARS.CIM_PARAMS_UPDATE IS '';
COMMENT ON COLUMN BARS.CIM_PARAMS_UPDATE.PAR_NAME IS '';
COMMENT ON COLUMN BARS.CIM_PARAMS_UPDATE.PAR_VALUE IS '';
COMMENT ON COLUMN BARS.CIM_PARAMS_UPDATE.GLOBAL IS '';
COMMENT ON COLUMN BARS.CIM_PARAMS_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CIM_PARAMS_UPDATE.S_USER_ID IS '';
COMMENT ON COLUMN BARS.CIM_PARAMS_UPDATE.S_KF IS '';
COMMENT ON COLUMN BARS.CIM_PARAMS_UPDATE.S_CHGDATE IS '';



PROMPT *** Create  grants  CIM_PARAMS_UPDATE ***
grant SELECT                                                                 on CIM_PARAMS_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_PARAMS_UPDATE to BARS_DM;
grant SELECT                                                                 on CIM_PARAMS_UPDATE to CIM_ROLE;
grant SELECT                                                                 on CIM_PARAMS_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_PARAMS_UPDATE.sql =========*** End
PROMPT ===================================================================================== 
