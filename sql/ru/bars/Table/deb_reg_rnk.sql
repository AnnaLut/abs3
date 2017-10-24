

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEB_REG_RNK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEB_REG_RNK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEB_REG_RNK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEB_REG_RNK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEB_REG_RNK ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.DEB_REG_RNK 
   (	RNK NUMBER(*,0), 
	SUMD NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEB_REG_RNK ***
 exec bpa.alter_policies('DEB_REG_RNK');


COMMENT ON TABLE BARS.DEB_REG_RNK IS 'Сумма задолженности по каждому клиенту';
COMMENT ON COLUMN BARS.DEB_REG_RNK.RNK IS '';
COMMENT ON COLUMN BARS.DEB_REG_RNK.SUMD IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEB_REG_RNK.sql =========*** End *** =
PROMPT ===================================================================================== 
