

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_PREPARED_ACC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_PREPARED_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_PREPARED_ACC'', ''WHOLE'' , ''M'', ''M'', ''M'', ''M'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_PREPARED_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_PREPARED_ACC 
   (	ACC NUMBER, 
	KF VARCHAR2(6), 
	CHUNK_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_PREPARED_ACC ***
 exec bpa.alter_policies('RKO_PREPARED_ACC');


COMMENT ON TABLE BARS.RKO_PREPARED_ACC IS '';
COMMENT ON COLUMN BARS.RKO_PREPARED_ACC.ACC IS '';
COMMENT ON COLUMN BARS.RKO_PREPARED_ACC.KF IS '';
COMMENT ON COLUMN BARS.RKO_PREPARED_ACC.CHUNK_ID IS '';



PROMPT *** Create  grants  RKO_PREPARED_ACC ***
grant SELECT                                                                 on RKO_PREPARED_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_PREPARED_ACC.sql =========*** End 
PROMPT ===================================================================================== 
