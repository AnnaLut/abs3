

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CA_UPR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CA_UPR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CA_UPR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CA_UPR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CA_UPR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CA_UPR ***
begin 
  execute immediate '
  CREATE TABLE BARS.CA_UPR 
   (	ID NUMBER, 
	NAME VARCHAR2(100), 
	DEPT_RELATION NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CA_UPR ***
 exec bpa.alter_policies('CA_UPR');


COMMENT ON TABLE BARS.CA_UPR IS '';
COMMENT ON COLUMN BARS.CA_UPR.ID IS '';
COMMENT ON COLUMN BARS.CA_UPR.NAME IS '';
COMMENT ON COLUMN BARS.CA_UPR.DEPT_RELATION IS '';



PROMPT *** Create  grants  CA_UPR ***
grant SELECT                                                                 on CA_UPR          to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CA_UPR.sql =========*** End *** ======
PROMPT ===================================================================================== 
