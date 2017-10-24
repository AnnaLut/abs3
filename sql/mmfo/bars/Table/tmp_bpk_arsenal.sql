

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BPK_ARSENAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BPK_ARSENAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BPK_ARSENAL ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_BPK_ARSENAL 
   (	ID NUMBER(38,0), 
	ACC NUMBER(38,0), 
	DEBT NUMBER(16,2), 
	TARIF NUMBER(16,4)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BPK_ARSENAL ***
 exec bpa.alter_policies('TMP_BPK_ARSENAL');


COMMENT ON TABLE BARS.TMP_BPK_ARSENAL IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL.ID IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL.ACC IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL.DEBT IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL.TARIF IS '';



PROMPT *** Create  grants  TMP_BPK_ARSENAL ***
grant SELECT                                                                 on TMP_BPK_ARSENAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_BPK_ARSENAL to BARS_DM;
grant SELECT                                                                 on TMP_BPK_ARSENAL to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BPK_ARSENAL.sql =========*** End *
PROMPT ===================================================================================== 
