

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_Z.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_Z ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_Z'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_Z'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_Z'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_Z ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_Z 
   (	ACC NUMBER, 
	SK NUMBER, 
	FDAT DATE, 
	S NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_Z ***
 exec bpa.alter_policies('CASH_Z');


COMMENT ON TABLE BARS.CASH_Z IS '';
COMMENT ON COLUMN BARS.CASH_Z.ACC IS '';
COMMENT ON COLUMN BARS.CASH_Z.SK IS '';
COMMENT ON COLUMN BARS.CASH_Z.FDAT IS '';
COMMENT ON COLUMN BARS.CASH_Z.S IS '';



PROMPT *** Create  grants  CASH_Z ***
grant SELECT                                                                 on CASH_Z          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CASH_Z          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_Z          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CASH_Z          to START1;
grant SELECT                                                                 on CASH_Z          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_Z.sql =========*** End *** ======
PROMPT ===================================================================================== 
