

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/cim_params_update.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to cim_params_update ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''cim_params_update'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''cim_params_update'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''cim_params_update'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table cim_params_update ***
begin 
  execute immediate '
  CREATE TABLE BARS.cim_params_update 
   (	PAR_NAME VARCHAR2(128), 
	PAR_VALUE VARCHAR2(4000), 
	GLOBAL INTEGER, 
	KF VARCHAR2(6),
        S_USER_ID NUMBER default sys_context(''bars_global'',''user_id''),
        S_KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''),
        S_chgdate    DATE default sysdate  
   ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




grant SELECT                                            on cim_params_update      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on cim_params_update      to BARS_DM;
grant SELECT                                            on cim_params_update      to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/cim_params_update.sql =========*** End *** ==
PROMPT ===================================================================================== 
