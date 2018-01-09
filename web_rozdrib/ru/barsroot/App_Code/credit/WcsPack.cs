using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace credit
{

    public class WcsPack : BbPackage
    {
        public WcsPack(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) {}
        public WcsPack(BbConnection Connection) : base(Connection, AutoCommit.Enabled) {}
        public void QUEST_SET ( String QUESTION_ID_,  String NAME_,  String TYPE_ID_,  Decimal? IS_CALCABLE_,  String CALC_PROC_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("NAME_", OracleDbType.Varchar2,NAME_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("TYPE_ID_", OracleDbType.Varchar2,TYPE_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("IS_CALCABLE_", OracleDbType.Decimal,IS_CALCABLE_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("CALC_PROC_", OracleDbType.Varchar2,CALC_PROC_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_DEL ( String QUESTION_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_PARS_TEXT_SET ( String QUESTION_ID_,  String LENG_MIN_,  String LENG_MAX_,  String VAL_DEFAULT_,  Decimal? TEXT_WIDTH_,  Decimal? TEXT_ROWS_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("LENG_MIN_", OracleDbType.Varchar2,LENG_MIN_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("LENG_MAX_", OracleDbType.Varchar2,LENG_MAX_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("VAL_DEFAULT_", OracleDbType.Varchar2,VAL_DEFAULT_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("TEXT_WIDTH_", OracleDbType.Decimal,TEXT_WIDTH_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("TEXT_ROWS_", OracleDbType.Decimal,TEXT_ROWS_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_PARS_TEXT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_PARS_NMBDEC_SET ( String QUESTION_ID_,  String VAL_MIN_,  String VAL_MAX_,  String VAL_DEFAULT_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("VAL_MIN_", OracleDbType.Varchar2,VAL_MIN_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("VAL_MAX_", OracleDbType.Varchar2,VAL_MAX_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("VAL_DEFAULT_", OracleDbType.Varchar2,VAL_DEFAULT_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_PARS_NMBDEC_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_PARS_DAT_SET ( String QUESTION_ID_,  String VAL_MIN_,  String VAL_MAX_,  String VAL_DEFAULT_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("VAL_MIN_", OracleDbType.Varchar2,VAL_MIN_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("VAL_MAX_", OracleDbType.Varchar2,VAL_MAX_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("VAL_DEFAULT_", OracleDbType.Varchar2,VAL_DEFAULT_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_PARS_DAT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_PARS_LIST_SET ( String QUESTION_ID_,  String SID_DEFAULT_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("SID_DEFAULT_", OracleDbType.Varchar2,SID_DEFAULT_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_PARS_LIST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_LIST_ITEM_SET ( String P_QUESTION_ID,  Decimal? P_ORD,  String P_TEXT,  Decimal? P_VISIBLE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal,P_ORD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT", OracleDbType.Varchar2,P_TEXT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VISIBLE", OracleDbType.Decimal,P_VISIBLE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_LIST_ITEM_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_LIST_ITEM_DEL ( String P_QUESTION_ID,  Decimal? P_ORD)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal,P_ORD, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_LIST_ITEM_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_LIST_ITEM_MOVE ( String P_QUESTION_ID,  Decimal? P_SRC_ORD,  Decimal? P_DEST_ORD)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_ORD", OracleDbType.Decimal,P_SRC_ORD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_ORD", OracleDbType.Decimal,P_DEST_ORD, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_LIST_ITEM_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_PARS_REF_SET ( String P_QUESTION_ID,  Decimal? P_TEXT_WIDTH,  Decimal? P_TEXT_ROWS,  String P_SID_DEFAULT,  Decimal? P_TAB_ID,  String P_KEY_FIELD,  String P_SEMANTIC_FIELD,  String P_SHOW_FIELDS,  String P_WHERE_CLAUSE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_WIDTH", OracleDbType.Decimal,P_TEXT_WIDTH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_ROWS", OracleDbType.Decimal,P_TEXT_ROWS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SID_DEFAULT", OracleDbType.Varchar2,P_SID_DEFAULT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TAB_ID", OracleDbType.Int32,P_TAB_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_KEY_FIELD", OracleDbType.Varchar2,P_KEY_FIELD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SEMANTIC_FIELD", OracleDbType.Varchar2,P_SEMANTIC_FIELD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SHOW_FIELDS", OracleDbType.Varchar2,P_SHOW_FIELDS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WHERE_CLAUSE", OracleDbType.Varchar2,P_WHERE_CLAUSE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_PARS_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_PARS_REF_SET ( String P_QUESTION_ID,  Decimal? P_TEXT_WIDTH,  Decimal? P_TEXT_ROWS,  String P_SID_DEFAULT,  Decimal? P_TAB_ID,  String P_KEY_FIELD,  String P_SEMANTIC_FIELD,  String P_SHOW_FIELDS)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_WIDTH", OracleDbType.Decimal,P_TEXT_WIDTH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_ROWS", OracleDbType.Decimal,P_TEXT_ROWS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SID_DEFAULT", OracleDbType.Varchar2,P_SID_DEFAULT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TAB_ID", OracleDbType.Int32,P_TAB_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_KEY_FIELD", OracleDbType.Varchar2,P_KEY_FIELD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SEMANTIC_FIELD", OracleDbType.Varchar2,P_SEMANTIC_FIELD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SHOW_FIELDS", OracleDbType.Varchar2,P_SHOW_FIELDS, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_PARS_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_PARS_REF_SET ( String P_QUESTION_ID,  Decimal? P_TEXT_WIDTH,  Decimal? P_TEXT_ROWS,  String P_SID_DEFAULT,  Decimal? P_TAB_ID,  String P_KEY_FIELD,  String P_SEMANTIC_FIELD)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_WIDTH", OracleDbType.Decimal,P_TEXT_WIDTH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_ROWS", OracleDbType.Decimal,P_TEXT_ROWS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SID_DEFAULT", OracleDbType.Varchar2,P_SID_DEFAULT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TAB_ID", OracleDbType.Int32,P_TAB_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_KEY_FIELD", OracleDbType.Varchar2,P_KEY_FIELD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SEMANTIC_FIELD", OracleDbType.Varchar2,P_SEMANTIC_FIELD, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_PARS_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_PARS_REF_SET ( String P_QUESTION_ID,  Decimal? P_TEXT_WIDTH,  Decimal? P_TEXT_ROWS,  String P_SID_DEFAULT,  Decimal? P_TAB_ID,  String P_KEY_FIELD)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_WIDTH", OracleDbType.Decimal,P_TEXT_WIDTH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_ROWS", OracleDbType.Decimal,P_TEXT_ROWS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SID_DEFAULT", OracleDbType.Varchar2,P_SID_DEFAULT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TAB_ID", OracleDbType.Int32,P_TAB_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_KEY_FIELD", OracleDbType.Varchar2,P_KEY_FIELD, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_PARS_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_PARS_REF_SET ( String P_QUESTION_ID,  Decimal? P_TEXT_WIDTH,  Decimal? P_TEXT_ROWS,  String P_SID_DEFAULT,  Decimal? P_TAB_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_WIDTH", OracleDbType.Decimal,P_TEXT_WIDTH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_ROWS", OracleDbType.Decimal,P_TEXT_ROWS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SID_DEFAULT", OracleDbType.Varchar2,P_SID_DEFAULT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TAB_ID", OracleDbType.Int32,P_TAB_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_PARS_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_PARS_REF_SET ( String P_QUESTION_ID,  Decimal? P_TEXT_WIDTH,  Decimal? P_TEXT_ROWS,  String P_SID_DEFAULT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_WIDTH", OracleDbType.Decimal,P_TEXT_WIDTH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_ROWS", OracleDbType.Decimal,P_TEXT_ROWS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SID_DEFAULT", OracleDbType.Varchar2,P_SID_DEFAULT, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_PARS_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_MTX_AXIS_SET ( String QUESTION_ID_,  String AXIS_QID_,  Decimal? ORD_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("AXIS_QID_", OracleDbType.Varchar2,AXIS_QID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("ORD_", OracleDbType.Decimal,ORD_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_MTX_AXIS_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_MTX_AXIS_SET ( String QUESTION_ID_,  String AXIS_QID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("AXIS_QID_", OracleDbType.Varchar2,AXIS_QID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_MTX_AXIS_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_MTX_AXIS_DEL ( String QUESTION_ID_,  String AXIS_QID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("AXIS_QID_", OracleDbType.Varchar2,AXIS_QID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_MTX_AXIS_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_PARS_BOOL_SET ( String QUESTION_ID_,  String VAL_DEFAULT_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("VAL_DEFAULT_", OracleDbType.Varchar2,VAL_DEFAULT_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_PARS_BOOL_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void QUEST_CLONE ( String P_QUESTION_ID,  String P_SRC_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_QUESTION_ID", OracleDbType.Varchar2,P_SRC_QUESTION_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.QUEST_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PROD_SET ( String PRODUCT_ID_,  String NAME_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("PRODUCT_ID_", OracleDbType.Varchar2,PRODUCT_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("NAME_", OracleDbType.Varchar2,NAME_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.PROD_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PROD_DEL ( String PRODUCT_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("PRODUCT_ID_", OracleDbType.Varchar2,PRODUCT_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.PROD_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_SET ( String SUBPRODUCT_ID_,  String NAME_,  String PRODUCT_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SUBPRODUCT_ID_", OracleDbType.Varchar2,SUBPRODUCT_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("NAME_", OracleDbType.Varchar2,NAME_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PRODUCT_ID_", OracleDbType.Varchar2,PRODUCT_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_DEL ( String SUBPRODUCT_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SUBPRODUCT_ID_", OracleDbType.Varchar2,SUBPRODUCT_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MAC_SET ( String P_MAC_ID,  String P_NAME,  String P_TYPE_ID,  String P_APPLY_LEVEL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Varchar2,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_LEVEL", OracleDbType.Varchar2,P_APPLY_LEVEL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.MAC_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MAC_DEL ( String P_MAC_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.MAC_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MAC_LIST_ITEM_SET ( String MAC_ID_,  Decimal? ORD_,  String TEXT_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("MAC_ID_", OracleDbType.Varchar2,MAC_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("ORD_", OracleDbType.Decimal,ORD_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("TEXT_", OracleDbType.Varchar2,TEXT_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.MAC_LIST_ITEM_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MAC_LIST_ITEM_MOVE ( String P_MAC_ID,  Decimal? P_SRC_ORD,  Decimal? P_DEST_ORD)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_ORD", OracleDbType.Decimal,P_SRC_ORD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_ORD", OracleDbType.Decimal,P_DEST_ORD, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.MAC_LIST_ITEM_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MAC_LIST_ITEM_DEL ( String MAC_ID_,  Decimal? ORD_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("MAC_ID_", OracleDbType.Varchar2,MAC_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("ORD_", OracleDbType.Decimal,ORD_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.MAC_LIST_ITEM_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MAC_REFER_PARAM_SET ( String MAC_ID_,  Decimal? TAB_ID_,  String KEY_FIELD_,  String SEMANTIC_FIELD_,  String SHOW_FIELDS_,  String WHERE_CLAUSE_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("MAC_ID_", OracleDbType.Varchar2,MAC_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("TAB_ID_", OracleDbType.Int32,TAB_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("KEY_FIELD_", OracleDbType.Varchar2,KEY_FIELD_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("SEMANTIC_FIELD_", OracleDbType.Varchar2,SEMANTIC_FIELD_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("SHOW_FIELDS_", OracleDbType.Varchar2,SHOW_FIELDS_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("WHERE_CLAUSE_", OracleDbType.Varchar2,WHERE_CLAUSE_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.MAC_REFER_PARAM_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MAC_REFER_PARAM_SET ( String MAC_ID_,  Decimal? TAB_ID_,  String KEY_FIELD_,  String SEMANTIC_FIELD_,  String SHOW_FIELDS_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("MAC_ID_", OracleDbType.Varchar2,MAC_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("TAB_ID_", OracleDbType.Int32,TAB_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("KEY_FIELD_", OracleDbType.Varchar2,KEY_FIELD_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("SEMANTIC_FIELD_", OracleDbType.Varchar2,SEMANTIC_FIELD_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("SHOW_FIELDS_", OracleDbType.Varchar2,SHOW_FIELDS_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.MAC_REFER_PARAM_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MAC_REFER_PARAM_SET ( String MAC_ID_,  Decimal? TAB_ID_,  String KEY_FIELD_,  String SEMANTIC_FIELD_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("MAC_ID_", OracleDbType.Varchar2,MAC_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("TAB_ID_", OracleDbType.Int32,TAB_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("KEY_FIELD_", OracleDbType.Varchar2,KEY_FIELD_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("SEMANTIC_FIELD_", OracleDbType.Varchar2,SEMANTIC_FIELD_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.MAC_REFER_PARAM_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MAC_REFER_PARAM_DEL ( String MAC_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("MAC_ID_", OracleDbType.Varchar2,MAC_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.MAC_REFER_PARAM_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_TEXT_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_VAL,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_TEXT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_TEXT_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_VAL,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_TEXT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_TEXT_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_TEXT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_NUMB_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_NUMB_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_NUMB_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_NUMB_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_NUMB_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_NUMB_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_DEC_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_DEC_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_DEC_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_DEC_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_DEC_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_DEC_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_DAT_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  DateTime? P_VAL,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Date,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_DAT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_DAT_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  DateTime? P_VAL,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Date,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_DAT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_DAT_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  DateTime? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Date,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_DAT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_LIST_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_LIST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_LIST_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_LIST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_LIST_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_LIST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_REF_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_VAL,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_REF_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_VAL,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_REF_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_FILE_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Byte[] P_VAL,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Blob,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_FILE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_FILE_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Byte[] P_VAL,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Blob,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_FILE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_FILE_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Byte[] P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Blob,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_FILE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_BOOL_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_BOOL_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_BOOL_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_BOOL_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_BOOL_SET ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  Decimal? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_BOOL_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_DEL ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_BRANCH,  DateTime? P_APPLY_DATE,  String P_COMMENT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COMMENT", OracleDbType.Varchar2,P_COMMENT, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_DEL ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_DEL ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MAC_DEL ( String P_SUBPRODUCT_ID,  String P_MAC_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MAC_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_MACS_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_MACS_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_SET_INN ( Decimal? P_BID_ID,  String P_INN)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INN", OracleDbType.Varchar2,P_INN, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_SET_INN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_SET_RNK ( Decimal? P_BID_ID,  Decimal? P_RNK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_SET_RNK", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_DEL ( Decimal? P_BID_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_STATE_SET_IMMEDIATE ( Decimal? BID_ID_,  String STATE_ID_,  String USER_COMMENT_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("STATE_ID_", OracleDbType.Varchar2,STATE_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("USER_COMMENT_", OracleDbType.Varchar2,USER_COMMENT_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_STATE_SET_IMMEDIATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_STATE_SET ( Decimal? BID_ID_,  String STATE_ID_,  String USER_COMMENT_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("STATE_ID_", OracleDbType.Varchar2,STATE_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("USER_COMMENT_", OracleDbType.Varchar2,USER_COMMENT_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_STATE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_STATE_DEL ( Decimal? BID_ID_,  String STATE_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("STATE_ID_", OracleDbType.Varchar2,STATE_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_STATE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_STATE_REAPPOINT ( Decimal? BID_ID_,  String STATE_ID_,  Decimal? REAPPOINT_USER_ID_,  String USER_COMMENT_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("STATE_ID_", OracleDbType.Varchar2,STATE_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("REAPPOINT_USER_ID_", OracleDbType.Decimal,REAPPOINT_USER_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("USER_COMMENT_", OracleDbType.Varchar2,USER_COMMENT_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_STATE_REAPPOINT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_STATES_BACKUP ( Decimal? P_BID_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_STATES_BACKUP", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_STATES_RESTORE ( Decimal? P_BID_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_STATES_RESTORE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_MGR_CHANGE ( Decimal? P_BID_ID,  Decimal? P_NEW_MGR_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NEW_MGR_ID", OracleDbType.Decimal,P_NEW_MGR_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_MGR_CHANGE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_SRV_USER_CHANGE ( Decimal? P_BID_ID,  String P_SRV_ID,  String P_SRV_HIERARCHY,  Decimal? P_NEW_MGR_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRV_ID", OracleDbType.Varchar2,P_SRV_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRV_HIERARCHY", OracleDbType.Varchar2,P_SRV_HIERARCHY, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NEW_MGR_ID", OracleDbType.Decimal,P_NEW_MGR_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_SRV_USER_CHANGE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_STATE_CHECK_OUT ( Decimal? BID_ID_,  String STATE_ID_,  String USER_COMMENT_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("STATE_ID_", OracleDbType.Varchar2,STATE_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("USER_COMMENT_", OracleDbType.Varchar2,USER_COMMENT_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_STATE_CHECK_OUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_STATE_CHECK_IN ( Decimal? BID_ID_,  String STATE_ID_,  String USER_COMMENT_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("STATE_ID_", OracleDbType.Varchar2,STATE_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("USER_COMMENT_", OracleDbType.Varchar2,USER_COMMENT_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_STATE_CHECK_IN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_STATE_HISTORY_SET ( Decimal? P_BID_ID,  String P_STATE_ID,  Decimal? P_CHECKOUTED,  DateTime? P_CHECKOUT_DAT,  Decimal? P_CHECKOUT_USER_ID,  String P_USER_COMMENT,  String P_CHANGE_ACTION)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATE_ID", OracleDbType.Varchar2,P_STATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CHECKOUTED", OracleDbType.Decimal,P_CHECKOUTED, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CHECKOUT_DAT", OracleDbType.Date,P_CHECKOUT_DAT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CHECKOUT_USER_ID", OracleDbType.Decimal,P_CHECKOUT_USER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_USER_COMMENT", OracleDbType.Varchar2,P_USER_COMMENT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CHANGE_ACTION", OracleDbType.Varchar2,P_CHANGE_ACTION, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_STATE_HISTORY_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_HISTORY_RESTORE(Decimal? P_BID_ID, String P_STATE_STATUS)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal, P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATE_STATUS", OracleDbType.Varchar2, P_STATE_STATUS, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_HISTORY_RESTORE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void LOG_SET ( Decimal? BID_ID_,  String STATE_ID_,  String TEXT_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("STATE_ID_", OracleDbType.Varchar2,STATE_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("TEXT_", OracleDbType.Varchar2,TEXT_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.LOG_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_TEXT_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_TEXT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_TEXT_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_TEXT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_TEXT_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_TEXT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_NUMB_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_NUMB_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_NUMB_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_NUMB_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_NUMB_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_NUMB_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_DEC_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_DEC_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_DEC_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_DEC_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_DEC_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_DEC_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_DAT_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  DateTime? P_VAL,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Date,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_DAT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_DAT_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  DateTime? P_VAL,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Date,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_DAT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_DAT_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  DateTime? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Date,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_DAT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_LIST_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_LIST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_LIST_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_LIST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_LIST_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_LIST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_REF_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_REF_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_REF_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_REF_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_FILE_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Byte[] P_VAL,  String P_VAL_FILE_NAME,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Blob,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL_FILE_NAME", OracleDbType.Varchar2,P_VAL_FILE_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_FILE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_FILE_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Byte[] P_VAL,  String P_VAL_FILE_NAME,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Blob,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL_FILE_NAME", OracleDbType.Varchar2,P_VAL_FILE_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_FILE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_FILE_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Byte[] P_VAL,  String P_VAL_FILE_NAME)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Blob,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL_FILE_NAME", OracleDbType.Varchar2,P_VAL_FILE_NAME, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_FILE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_MTX_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_MTX_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_MTX_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_MTX_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_MTX_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_MTX_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_BOOL_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_BOOL_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_BOOL_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_BOOL_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_BOOL_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_BOOL_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_XML_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Clob,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_XML_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_XML_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Clob,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_XML_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_XML_SET ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Clob,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_XML_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_DEL ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_DEL ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ANSW_DEL ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.ANSW_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_CRDDATA_SET ( String P_SUBPRODUCT_ID,  String P_CRDDATA_ID,  String P_QUESTION_ID,  Decimal? P_IS_VISIBLE,  String P_IS_READONLY,  Decimal? P_IS_CHECKABLE,  String P_CHECK_PROC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CRDDATA_ID", OracleDbType.Varchar2,P_CRDDATA_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_VISIBLE", OracleDbType.Decimal,P_IS_VISIBLE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_READONLY", OracleDbType.Varchar2,P_IS_READONLY, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_CHECKABLE", OracleDbType.Decimal,P_IS_CHECKABLE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CHECK_PROC", OracleDbType.Varchar2,P_CHECK_PROC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_CRDDATA_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_CRDDATA_DEL ( String P_SUBPRODUCT_ID,  String P_CRDDATA_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CRDDATA_ID", OracleDbType.Varchar2,P_CRDDATA_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_CRDDATA_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_CRDDATA_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_CRDDATA_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void STOP_SET ( String P_STOP_ID,  String P_NAME,  String P_TYPE_ID,  String P_PLSQL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_STOP_ID", OracleDbType.Varchar2,P_STOP_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Varchar2,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PLSQL", OracleDbType.Varchar2,P_PLSQL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.STOP_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void STOP_DEL ( String P_STOP_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_STOP_ID", OracleDbType.Varchar2,P_STOP_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.STOP_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_STOP_SET ( String P_SUBPRODUCT_ID,  String P_STOP_ID,  Decimal? P_ACT_LEVEL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STOP_ID", OracleDbType.Varchar2,P_STOP_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ACT_LEVEL", OracleDbType.Decimal,P_ACT_LEVEL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_STOP_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_STOP_SET ( String P_SUBPRODUCT_ID,  String P_STOP_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STOP_ID", OracleDbType.Varchar2,P_STOP_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_STOP_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_STOP_DEL ( String P_SUBPRODUCT_ID,  String P_STOP_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STOP_ID", OracleDbType.Varchar2,P_STOP_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_STOP_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_STOP_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_STOP_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOPY_SET ( String SCOPY_ID_,  String NAME_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SCOPY_ID_", OracleDbType.Varchar2,SCOPY_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("NAME_", OracleDbType.Varchar2,NAME_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOPY_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOPY_DEL ( String SCOPY_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SCOPY_ID_", OracleDbType.Varchar2,SCOPY_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOPY_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOPY_QUEST_SET ( String P_SCOPY_ID,  String P_QUESTION_ID,  String P_TYPE_ID,  Decimal? P_IS_REQUIRED)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCOPY_ID", OracleDbType.Varchar2,P_SCOPY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Varchar2,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_REQUIRED", OracleDbType.Decimal,P_IS_REQUIRED, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOPY_QUEST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOPY_QUEST_DEL ( String SCOPY_ID_,  String QUESTION_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SCOPY_ID_", OracleDbType.Varchar2,SCOPY_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOPY_QUEST_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOPY_QUEST_MOVE ( String P_SCOPY_ID,  String P_SRC_QUESTID,  String P_DEST_QUESTID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCOPY_ID", OracleDbType.Varchar2,P_SCOPY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_QUESTID", OracleDbType.Varchar2,P_SRC_QUESTID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_QUESTID", OracleDbType.Varchar2,P_DEST_QUESTID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOPY_QUEST_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_SCOPY_SET ( String SUBPRODUCT_ID_,  String SCOPY_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SUBPRODUCT_ID_", OracleDbType.Varchar2,SUBPRODUCT_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("SCOPY_ID_", OracleDbType.Varchar2,SCOPY_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_SCOPY_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_SCOPY_DEL ( String SUBPRODUCT_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SUBPRODUCT_ID_", OracleDbType.Varchar2,SUBPRODUCT_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_SCOPY_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_SCOPY_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_SCOPY_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PRINT_SCAN_SET ( String P_PRINT_SESSION_ID,  Byte[] P_SCAN_DATA)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PRINT_SESSION_ID", OracleDbType.Varchar2,P_PRINT_SESSION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCAN_DATA", OracleDbType.Blob,P_SCAN_DATA, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.PRINT_SCAN_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PRINT_SCAN_CLEAR ( String P_PRINT_SESSION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PRINT_SESSION_ID", OracleDbType.Varchar2,P_PRINT_SESSION_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.PRINT_SCAN_CLEAR", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void AUTH_SET ( String AUTH_ID_,  String NAME_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("AUTH_ID_", OracleDbType.Varchar2,AUTH_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("NAME_", OracleDbType.Varchar2,NAME_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.AUTH_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void AUTH_DEL ( String AUTH_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("AUTH_ID_", OracleDbType.Varchar2,AUTH_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.AUTH_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void AUTH_CLONE ( String P_AUTH_ID,  String P_AUTH_NAME,  String P_SRC_AUTHID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_AUTH_ID", OracleDbType.Varchar2,P_AUTH_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_AUTH_NAME", OracleDbType.Varchar2,P_AUTH_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_AUTHID", OracleDbType.Varchar2,P_SRC_AUTHID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.AUTH_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void AUTH_QUEST_SET ( String P_AUTH_ID,  String P_QUESTION_ID,  String P_SCOPY_QID,  Decimal? P_IS_REQUIRED,  Decimal? P_IS_CHECKABLE,  String P_CHECK_PROC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_AUTH_ID", OracleDbType.Varchar2,P_AUTH_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCOPY_QID", OracleDbType.Varchar2,P_SCOPY_QID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_REQUIRED", OracleDbType.Decimal,P_IS_REQUIRED, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_CHECKABLE", OracleDbType.Decimal,P_IS_CHECKABLE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CHECK_PROC", OracleDbType.Varchar2,P_CHECK_PROC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.AUTH_QUEST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void AUTH_QUEST_DEL ( String AUTH_ID_,  String QUESTION_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("AUTH_ID_", OracleDbType.Varchar2,AUTH_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.AUTH_QUEST_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void AUTH_QUEST_MOVE ( String P_AUTH_ID,  String P_SRC_QUESTID,  String P_DEST_QUESTID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_AUTH_ID", OracleDbType.Varchar2,P_AUTH_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_QUESTID", OracleDbType.Varchar2,P_SRC_QUESTID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_QUESTID", OracleDbType.Varchar2,P_DEST_QUESTID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.AUTH_QUEST_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_AUTH_SET ( String SUBPRODUCT_ID_,  String AUTH_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SUBPRODUCT_ID_", OracleDbType.Varchar2,SUBPRODUCT_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("AUTH_ID_", OracleDbType.Varchar2,AUTH_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_AUTH_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_AUTH_DEL ( String SUBPRODUCT_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SUBPRODUCT_ID_", OracleDbType.Varchar2,SUBPRODUCT_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_AUTH_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_AUTH_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_AUTH_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SURVEY_SET ( String SURVEY_ID_,  String NAME_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SURVEY_ID_", OracleDbType.Varchar2,SURVEY_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("NAME_", OracleDbType.Varchar2,NAME_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SURVEY_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SURVEY_DEL ( String SURVEY_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SURVEY_ID_", OracleDbType.Varchar2,SURVEY_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SURVEY_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SURVEY_GROUP_SET ( String P_SURVEY_ID,  String P_SGROUP_ID,  String P_NAME,  String P_DNSHOW_IF)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SGROUP_ID", OracleDbType.Varchar2,P_SGROUP_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DNSHOW_IF", OracleDbType.Varchar2,P_DNSHOW_IF, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SURVEY_GROUP_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SURVEY_GROUP_DEL ( String P_SURVEY_ID,  String P_SGROUP_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SGROUP_ID", OracleDbType.Varchar2,P_SGROUP_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SURVEY_GROUP_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SURVEY_GROUP_MOVE ( String P_SURVEY_ID,  String P_SRC_GRPID,  String P_DEST_GRPID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_GRPID", OracleDbType.Varchar2,P_SRC_GRPID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_GRPID", OracleDbType.Varchar2,P_DEST_GRPID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SURVEY_GROUP_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SURVEY_GROUP_CLONE ( String P_DEST_SURID,  String P_SRC_SURID,  String P_SRC_GRPID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEST_SURID", OracleDbType.Varchar2,P_DEST_SURID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SURID", OracleDbType.Varchar2,P_SRC_SURID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_GRPID", OracleDbType.Varchar2,P_SRC_GRPID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SURVEY_GROUP_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SURVEY_GROUP_SYNC_PROTOCOL ( String P_DEST_SURID,  String P_DEST_GRPID,  String P_SRC_SURID,  String P_SRC_GRPID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEST_SURID", OracleDbType.Varchar2,P_DEST_SURID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_GRPID", OracleDbType.Varchar2,P_DEST_GRPID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SURID", OracleDbType.Varchar2,P_SRC_SURID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_GRPID", OracleDbType.Varchar2,P_SRC_GRPID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SURVEY_GROUP_SYNC_PROTOCOL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SURVEY_GROUP_QUEST_SET ( String P_SURVEY_ID,  String P_SGROUP_ID,  String P_RECTYPE_ID,  String P_QUESTION_ID,  String P_DNSHOW_IF,  String P_IS_REQUIRED,  String P_IS_READONLY,  Decimal? P_IS_REWRITABLE,  Decimal? P_IS_CHECKABLE,  String P_CHECK_PROC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SGROUP_ID", OracleDbType.Varchar2,P_SGROUP_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RECTYPE_ID", OracleDbType.Varchar2,P_RECTYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DNSHOW_IF", OracleDbType.Varchar2,P_DNSHOW_IF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_REQUIRED", OracleDbType.Varchar2,P_IS_REQUIRED, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_READONLY", OracleDbType.Varchar2,P_IS_READONLY, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_REWRITABLE", OracleDbType.Decimal,P_IS_REWRITABLE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_CHECKABLE", OracleDbType.Decimal,P_IS_CHECKABLE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CHECK_PROC", OracleDbType.Varchar2,P_CHECK_PROC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SURVEY_GROUP_QUEST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SURVEY_GROUP_QUEST_DEL ( String SURVEY_ID_,  String SGROUP_ID_,  String QUESTION_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SURVEY_ID_", OracleDbType.Varchar2,SURVEY_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("SGROUP_ID_", OracleDbType.Varchar2,SGROUP_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SURVEY_GROUP_QUEST_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SURVEY_GROUP_QUEST_MOVE ( String P_SURVEY_ID,  String P_SGROUP_ID,  String P_SRC_QUESTID,  String P_DEST_QUESTID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SGROUP_ID", OracleDbType.Varchar2,P_SGROUP_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_QUESTID", OracleDbType.Varchar2,P_SRC_QUESTID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_QUESTID", OracleDbType.Varchar2,P_DEST_QUESTID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SURVEY_GROUP_QUEST_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_SURVEY_SET ( String SUBPRODUCT_ID_,  String SURVEY_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SUBPRODUCT_ID_", OracleDbType.Varchar2,SUBPRODUCT_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("SURVEY_ID_", OracleDbType.Varchar2,SURVEY_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_SURVEY_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_SURVEY_DEL ( String SUBPRODUCT_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SUBPRODUCT_ID_", OracleDbType.Varchar2,SUBPRODUCT_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_SURVEY_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_SURVEY_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_SURVEY_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_SET ( String SCORING_ID_,  String NAME_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SCORING_ID_", OracleDbType.Varchar2,SCORING_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("NAME_", OracleDbType.Varchar2,NAME_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_DEL ( String SCORING_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SCORING_ID_", OracleDbType.Varchar2,SCORING_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_CLONE ( String P_SCORING_ID,  String P_SRC_SCORING_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SCORING_ID", OracleDbType.Varchar2,P_SRC_SCORING_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_SET ( String P_SCORING_ID,  String P_QUESTION_ID,  Decimal? P_MULTIPLIER,  Decimal? P_ELSE_SCORE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MULTIPLIER", OracleDbType.Decimal,P_MULTIPLIER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ELSE_SCORE", OracleDbType.Decimal,P_ELSE_SCORE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_DEL ( String SCORING_ID_,  String QUESTION_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SCORING_ID_", OracleDbType.Varchar2,SCORING_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_NUMB_SET ( String P_SCORING_ID,  String P_QUESTION_ID,  Decimal? P_ORD,  Decimal? P_MIN_VAL,  String P_MIN_SIGN,  Decimal? P_MAX_VAL,  String P_MAX_SIGN,  Decimal? P_SCORE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal,P_ORD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_VAL", OracleDbType.Decimal,P_MIN_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_SIGN", OracleDbType.Varchar2,P_MIN_SIGN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_VAL", OracleDbType.Decimal,P_MAX_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_SIGN", OracleDbType.Varchar2,P_MAX_SIGN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORE", OracleDbType.Decimal,P_SCORE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_NUMB_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_NUMB_DEL ( String P_SCORING_ID,  String P_QUESTION_ID,  Decimal? P_ORD)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal,P_ORD, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_NUMB_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_NUMB_MOVE ( String P_SCORING_ID,  String P_QUESTION_ID,  Decimal? P_SRC_ORD,  Decimal? P_DEST_ORD)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_ORD", OracleDbType.Decimal,P_SRC_ORD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_ORD", OracleDbType.Decimal,P_DEST_ORD, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_NUMB_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_DECIMAL_SET ( String P_SCORING_ID,  String P_QUESTION_ID,  Decimal? P_ORD,  Decimal? P_MIN_VAL,  String P_MIN_SIGN,  Decimal? P_MAX_VAL,  String P_MAX_SIGN,  Decimal? P_SCORE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal,P_ORD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_VAL", OracleDbType.Decimal,P_MIN_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_SIGN", OracleDbType.Varchar2,P_MIN_SIGN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_VAL", OracleDbType.Decimal,P_MAX_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_SIGN", OracleDbType.Varchar2,P_MAX_SIGN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORE", OracleDbType.Decimal,P_SCORE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_DECIMAL_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_DECIMAL_DEL ( String P_SCORING_ID,  String P_QUESTION_ID,  Decimal? P_ORD)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal,P_ORD, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_DECIMAL_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_DATE_SET ( String P_SCORING_ID,  String P_QUESTION_ID,  Decimal? P_ORD,  DateTime? P_MIN_VAL,  String P_MIN_SIGN,  DateTime? P_MAX_VAL,  String P_MAX_SIGN,  Decimal? P_SCORE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal,P_ORD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_VAL", OracleDbType.Date,P_MIN_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_SIGN", OracleDbType.Varchar2,P_MIN_SIGN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_VAL", OracleDbType.Date,P_MAX_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_SIGN", OracleDbType.Varchar2,P_MAX_SIGN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORE", OracleDbType.Decimal,P_SCORE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_DATE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_DATE_DEL ( String P_SCORING_ID,  String P_QUESTION_ID,  Decimal? P_ORD)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal,P_ORD, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_DATE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_LIST_SET ( String P_SCORING_ID,  String P_QUESTION_ID,  Decimal? P_ORD,  Decimal? P_SCORE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal,P_ORD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORE", OracleDbType.Decimal,P_SCORE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_LIST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_LIST_DEL ( String P_SCORING_ID,  String P_QUESTION_ID,  Decimal? P_ORD)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal,P_ORD, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_LIST_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_BOOL_SET ( String P_SCORING_ID,  String P_QUESTION_ID,  Decimal? P_SCORE_IF_0,  Decimal? P_SCORE_IF_1)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORE_IF_0", OracleDbType.Decimal,P_SCORE_IF_0, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORE_IF_1", OracleDbType.Decimal,P_SCORE_IF_1, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_BOOL_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SCOR_QUEST_BOOL_DEL ( String P_SCORING_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SCOR_QUEST_BOOL_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_SCOR_SET ( String SUBPRODUCT_ID_,  String SCORING_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SUBPRODUCT_ID_", OracleDbType.Varchar2,SUBPRODUCT_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("SCORING_ID_", OracleDbType.Varchar2,SCORING_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_SCOR_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_SCOR_DEL ( String SUBPRODUCT_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("SUBPRODUCT_ID_", OracleDbType.Varchar2,SUBPRODUCT_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_SCOR_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_SCOR_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_SCOR_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SOLV_SET ( String P_SOLVENCY_ID,  String P_NAME)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SOLVENCY_ID", OracleDbType.Varchar2,P_SOLVENCY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SOLV_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SOLV_DEL ( String P_SOLVENCY_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SOLVENCY_ID", OracleDbType.Varchar2,P_SOLVENCY_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SOLV_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SOLV_QUEST_SET ( String P_SOLVENCY_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SOLVENCY_ID", OracleDbType.Varchar2,P_SOLVENCY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SOLV_QUEST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SOLV_QUEST_DEL ( String P_SOLVENCY_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SOLVENCY_ID", OracleDbType.Varchar2,P_SOLVENCY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SOLV_QUEST_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_SOLV_SET ( String P_SUBPRODUCT_ID,  String P_SOLVENCY_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SOLVENCY_ID", OracleDbType.Varchar2,P_SOLVENCY_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_SOLV_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_SOLV_DEL ( String P_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_SOLV_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_SOLV_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_SOLV_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IQUERY_SET ( String P_IQUERY_ID,  String P_NAME,  String P_TYPE_ID,  String P_PLSQL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Varchar2,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PLSQL", OracleDbType.Clob,P_PLSQL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.IQUERY_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IQUERY_DEL ( String P_IQUERY_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.IQUERY_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IQUERY_QUEST_SET ( String P_IQUERY_ID,  String P_QUESTION_ID,  Decimal? P_IS_REQUIRED,  Decimal? P_IS_CHECKABLE,  String P_CHECK_PROC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_REQUIRED", OracleDbType.Decimal,P_IS_REQUIRED, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_CHECKABLE", OracleDbType.Decimal,P_IS_CHECKABLE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CHECK_PROC", OracleDbType.Varchar2,P_CHECK_PROC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.IQUERY_QUEST_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IQUERY_QUEST_DEL ( String P_IQUERY_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.IQUERY_QUEST_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IQUERY_QUEST_MOVE ( String P_IQUERY_ID,  String P_SRC_QUESTID,  String P_DEST_QUESTID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_QUESTID", OracleDbType.Varchar2,P_SRC_QUESTID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_QUESTID", OracleDbType.Varchar2,P_DEST_QUESTID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.IQUERY_QUEST_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_IQUERY_SET ( String P_SUBPRODUCT_ID,  String P_IQUERY_ID,  Decimal? P_ACT_LEVEL,  String P_SERVICE_ID,  Decimal? P_IS_REQUIRED)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ACT_LEVEL", OracleDbType.Decimal,P_ACT_LEVEL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SERVICE_ID", OracleDbType.Varchar2,P_SERVICE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_REQUIRED", OracleDbType.Decimal,P_IS_REQUIRED, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_IQUERY_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_IQUERY_DEL ( String P_SUBPRODUCT_ID,  String P_IQUERY_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_IQUERY_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_IQUERY_MOVE ( String P_SUBPRODUCT_ID,  String P_SRC_IQUERYID,  String P_DEST_IQUERYID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_IQUERYID", OracleDbType.Varchar2,P_SRC_IQUERYID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_IQUERYID", OracleDbType.Varchar2,P_DEST_IQUERYID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_IQUERY_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBPROD_IQUERY_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBPROD_IQUERY_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void INSURANCE_SET ( String P_INSURANCE_ID,  String P_SURVEY_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_INSURANCE_ID", OracleDbType.Varchar2,P_INSURANCE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.INSURANCE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_INSURANCE_SET ( String P_SUBPRODUCT_ID,  String P_INSURANCE_ID,  Decimal? P_IS_REQUIRED)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_ID", OracleDbType.Varchar2,P_INSURANCE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_REQUIRED", OracleDbType.Decimal,P_IS_REQUIRED, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_INSURANCE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_INSURANCE_DEL ( String P_SUBPRODUCT_ID,  String P_INSURANCE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_ID", OracleDbType.Varchar2,P_INSURANCE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_INSURANCE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_INSURANCE_MOVE ( String P_SUBPRODUCT_ID,  String P_SRC_ID,  String P_DEST_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_ID", OracleDbType.Varchar2,P_SRC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_ID", OracleDbType.Varchar2,P_DEST_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_INSURANCE_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_INSURANCE_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_INSURANCE_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_INSURANCE_SET ( Decimal? P_BID_ID,  String P_INSURANCE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_ID", OracleDbType.Varchar2,P_INSURANCE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_INSURANCE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_INSURANCE_DEL ( Decimal? P_BID_ID,  String P_INSURANCE_ID,  Decimal? P_INSURANCE_NUM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_ID", OracleDbType.Varchar2,P_INSURANCE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_NUM", OracleDbType.Decimal,P_INSURANCE_NUM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_INSURANCE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_INSURANCE_STATUS_SET ( Decimal? P_BID_ID,  String P_INSURANCE_ID,  Decimal? P_INSURANCE_NUM,  Decimal? P_STATUS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_ID", OracleDbType.Varchar2,P_INSURANCE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_NUM", OracleDbType.Decimal,P_INSURANCE_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_ID", OracleDbType.Decimal,P_STATUS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_INSURANCE_STATUS_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_GRT_INSURANCE_SET ( Decimal? P_BID_ID,  String P_GARANTEE_ID,  Decimal? P_GARANTEE_NUM,  String P_INSURANCE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_NUM", OracleDbType.Decimal,P_GARANTEE_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_ID", OracleDbType.Varchar2,P_INSURANCE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_GRT_INSURANCE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_GRT_INSURANCE_DEL ( Decimal? P_BID_ID,  String P_GARANTEE_ID,  Decimal? P_GARANTEE_NUM,  String P_INSURANCE_ID,  Decimal? P_INSURANCE_NUM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_NUM", OracleDbType.Decimal,P_GARANTEE_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_ID", OracleDbType.Varchar2,P_INSURANCE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_NUM", OracleDbType.Decimal,P_INSURANCE_NUM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_GRT_INSURANCE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_GRT_INSURANCE_STATUS_SET ( Decimal? P_BID_ID,  String P_GARANTEE_ID,  Decimal? P_GARANTEE_NUM,  String P_INSURANCE_ID,  Decimal? P_INSURANCE_NUM,  Decimal? P_STATUS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_NUM", OracleDbType.Decimal,P_GARANTEE_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_ID", OracleDbType.Varchar2,P_INSURANCE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_NUM", OracleDbType.Decimal,P_INSURANCE_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_ID", OracleDbType.Decimal,P_STATUS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_GRT_INSURANCE_STATUS_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void GARANTEE_SET ( String P_GARANTEE_ID,  String P_SCOPY_ID,  String P_SURVEY_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCOPY_ID", OracleDbType.Varchar2,P_SCOPY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.GARANTEE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void GARANTEE_INSURANCE_SET ( String P_GARANTEE_ID,  String P_INSURANCE_ID,  Decimal? P_IS_REQUIRED)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_ID", OracleDbType.Varchar2,P_INSURANCE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_REQUIRED", OracleDbType.Decimal,P_IS_REQUIRED, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.GARANTEE_INSURANCE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void GARANTEE_INSURANCE_DEL ( String P_GARANTEE_ID,  String P_INSURANCE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSURANCE_ID", OracleDbType.Varchar2,P_INSURANCE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.GARANTEE_INSURANCE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void GARANTEE_INSURANCE_MOVE ( String P_GARANTEE_ID,  String P_SRC_ID,  String P_DEST_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_ID", OracleDbType.Varchar2,P_SRC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_ID", OracleDbType.Varchar2,P_DEST_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.GARANTEE_INSURANCE_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void GARANTEE_TEMPLATE_SET ( String P_GARANTEE_ID,  String P_TEMPLATE_ID,  String P_PRINT_STATE_ID,  Decimal? P_IS_SCAN_REQ)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEMPLATE_ID", OracleDbType.Varchar2,P_TEMPLATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PRINT_STATE_ID", OracleDbType.Varchar2,P_PRINT_STATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_SCAN_REQ", OracleDbType.Decimal,P_IS_SCAN_REQ, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.GARANTEE_TEMPLATE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void GARANTEE_TEMPLATE_DEL ( String P_GARANTEE_ID,  String P_TEMPLATE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEMPLATE_ID", OracleDbType.Varchar2,P_TEMPLATE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.GARANTEE_TEMPLATE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_GARANTEE_SET ( String P_SUBPRODUCT_ID,  String P_GARANTEE_ID,  Decimal? P_IS_REQUIRED)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_REQUIRED", OracleDbType.Decimal,P_IS_REQUIRED, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_GARANTEE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_GARANTEE_DEL ( String P_SUBPRODUCT_ID,  String P_GARANTEE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_GARANTEE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_GARANTEE_MOVE ( String P_SUBPRODUCT_ID,  String P_SRC_GID,  String P_DEST_GID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_GID", OracleDbType.Varchar2,P_SRC_GID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_GID", OracleDbType.Varchar2,P_DEST_GID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_GARANTEE_MOVE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_GARANTEE_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_GARANTEE_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_GARANTEE_SET ( Decimal? P_BID_ID,  String P_GARANTEE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_GARANTEE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_GARANTEE_DEL ( Decimal? P_BID_ID,  String P_GARANTEE_ID,  Decimal? P_GARANTEE_NUM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_NUM", OracleDbType.Decimal,P_GARANTEE_NUM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_GARANTEE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BID_GARANTEE_STATUS_SET ( Decimal? P_BID_ID,  String P_GARANTEE_ID,  Decimal? P_GARANTEE_NUM,  Decimal? P_STATUS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_NUM", OracleDbType.Decimal,P_GARANTEE_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_ID", OracleDbType.Decimal,P_STATUS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_GARANTEE_STATUS_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void TEMPLATE_SET ( String P_TEMPLATE_ID,  String P_TEMPLATE_NAME,  String P_FILE_NAME,  String P_DOCEXP_TYPE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TEMPLATE_ID", OracleDbType.Varchar2,P_TEMPLATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEMPLATE_NAME", OracleDbType.Varchar2,P_TEMPLATE_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FILE_NAME", OracleDbType.Varchar2,P_FILE_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DOCEXP_TYPE_ID", OracleDbType.Varchar2,P_DOCEXP_TYPE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.TEMPLATE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void TEMPLATE_SET ( String P_TEMPLATE_ID,  String P_TEMPLATE_NAME,  String P_FILE_NAME)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TEMPLATE_ID", OracleDbType.Varchar2,P_TEMPLATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEMPLATE_NAME", OracleDbType.Varchar2,P_TEMPLATE_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FILE_NAME", OracleDbType.Varchar2,P_FILE_NAME, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.TEMPLATE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void TEMPLATE_DEL ( String P_TEMPLATE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TEMPLATE_ID", OracleDbType.Varchar2,P_TEMPLATE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.TEMPLATE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_TEMPLATE_SET ( String P_SUBPRODUCT_ID,  String P_TEMPLATE_ID,  String P_PRINT_STATE_ID,  Decimal? P_IS_SCAN_REQ)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEMPLATE_ID", OracleDbType.Varchar2,P_TEMPLATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PRINT_STATE_ID", OracleDbType.Varchar2,P_PRINT_STATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_SCAN_REQ", OracleDbType.Decimal,P_IS_SCAN_REQ, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_TEMPLATE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_TEMPLATE_DEL ( String P_SUBPRODUCT_ID,  String P_TEMPLATE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEMPLATE_ID", OracleDbType.Varchar2,P_TEMPLATE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_TEMPLATE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_TEMPLATE_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_TEMPLATE_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_PAYMENT_SET ( String P_SUBPRODUCT_ID,  String P_PAYMENT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PAYMENT_ID", OracleDbType.Varchar2,P_PAYMENT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_PAYMENT_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_PAYMENT_DEL ( String P_SUBPRODUCT_ID,  String P_PAYMENT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PAYMENT_ID", OracleDbType.Varchar2,P_PAYMENT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_PAYMENT_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_PAYMENT_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_PAYMENT_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_PTRTYPE_SET ( String P_SUBPRODUCT_ID,  String P_PTR_TYPE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PTR_TYPE_ID", OracleDbType.Varchar2,P_PTR_TYPE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_PTRTYPE_SET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_PTRTYPE_DEL ( String P_SUBPRODUCT_ID,  String P_PTR_TYPE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PTR_TYPE_ID", OracleDbType.Varchar2,P_PTR_TYPE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_PTRTYPE_DEL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SBP_PTRTYPE_CLONE ( String P_SUBPRODUCT_ID,  String P_SRC_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SRC_SUBPRODUCT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.SBP_PTRTYPE_CLONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public String HEADER_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? BID_CREATE ( String P_SUBPRODUCT_ID,  String P_INN,  Decimal? P_RNK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INN", OracleDbType.Varchar2,P_INN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_CREATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? BID_CREATE ( String P_SUBPRODUCT_ID,  String P_INN)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INN", OracleDbType.Varchar2,P_INN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_CREATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? BID_CREATE ( String P_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_CREATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? BID_GARANTEE_SET_EXT ( Decimal? P_BID_ID,  String P_GARANTEE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GARANTEE_ID", OracleDbType.Varchar2,P_GARANTEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_PACK.BID_GARANTEE_SET_EXT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
    }
}