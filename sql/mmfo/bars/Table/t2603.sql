

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T2603.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T2603 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T2603'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''T2603'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''T2603'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T2603 ***
begin 
  execute immediate '
  CREATE TABLE BARS.T2603 
   (	ACC NUMBER, 
	SA NUMBER(24,2), 
	SR NUMBER(24,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to T2603 ***
 exec bpa.alter_policies('T2603');


COMMENT ON TABLE BARS.T2603 IS '';
COMMENT ON COLUMN BARS.T2603.ACC IS '';
COMMENT ON COLUMN BARS.T2603.SA IS '';
COMMENT ON COLUMN BARS.T2603.SR IS '';



PROMPT *** Create  grants  T2603 ***
grant SELECT                                                                 on T2603           to BARSREADER_ROLE;
grant SELECT                                                                 on T2603           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T2603.sql =========*** End *** =======
PROMPT ===================================================================================== 
